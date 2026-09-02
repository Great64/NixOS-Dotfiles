{ pkgs, ... }:

let
  winboat-desktop = pkgs.writeShellScriptBin "winboat-desktop" ''
    exec > /tmp/winboat-desktop.log 2>&1
    set -x
    set -e
    CONTAINER=WinBoat
    CREDS=$HOME/.config/nixos-local/winboat.env
    
    # Check if env exists
    if [ ! -f "$CREDS" ]; then
      ${pkgs.libnotify}/bin/notify-send "winboat-desktop" "Missing $CREDS"
      exit 1
    fi

    # Shellcheck disable=SC1090
    . "$CREDS"

    ${pkgs.docker}/bin/docker start "$CONTAINER" >/dev/null 2>&1 || true

    # Shitty workaround since RDP port always changes
    RDP_PORT=""
    for _ in $(seq 1 60); do
      RDP_PORT=$(${pkgs.docker}/bin/docker port "$CONTAINER" 3389/tcp 2>/dev/null | ${pkgs.gawk}/bin/awk -F: '{print $NF}' | head -1)
      [ -n "$RDP_PORT" ] && ${pkgs.netcat-openbsd}/bin/nc -z 127.0.0.1 "$RDP_PORT" 2>/dev/null && break
      sleep 1
    done

    if [ -z "$RDP_PORT" ]; then
      ${pkgs.libnotify}/bin/notify-send "winboat-desktop" "Failed to detect RDP port"
      exit 1
    fi

    # Retry connect if RDP port opens before windows TLS is ready
    set +e
    for _ in $(seq 1 20); do
      ${pkgs.freerdp}/bin/xfreerdp \
        /v:127.0.0.1:$RDP_PORT \
        /u:"$WINBOAT_USER" \
        /p:"$WINBOAT_PASS" \
        /cert:ignore \
        /dynamic-resolution \
        /sound:sys:pulse \
        /microphone:sys:pulse \
        /f
      rc=$?
      # rc=0 = clean exit (user closed window); anything else = connect fail, retry
      [ $rc -eq 0 ] && break
      sleep 2
    done
    set -e

    # Kill container if window closed
    ${pkgs.docker}/bin/docker stop "$CONTAINER" >/dev/null 2>&1 || true
  '';
in
{
  boot.kernelModules = [ "kvm-intel" "usbip-core" "usbip-host" "vhci-hcd" ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  # Needed groups
  users.users.great.extraGroups = [ "docker" "kvm" "libvirtd" ];
  environment.systemPackages = with pkgs; [
    winboat
    freerdp   # for seemless windows
    winboat-desktop
    linuxPackages.usbip
  ];

  # usbip daemon exposes host USB devices to WinBoat over TCP
  systemd.services.usbipd = {
    description = "usbip daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.usbip}/bin/usbipd -D";
  };

  # Grant non-root access to Pico (VID 2e8a) so WinBoat can bind it
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e8a", MODE="0666"
  '';
}
