{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "audio-switch";
      runtimeInputs = with pkgs; [ pulseaudio gawk coreutils findutils rofi ];
      text = ''
        CARD="alsa_card.pci-0000_01_00.1"

        entries=$(
          # HDMI profiles — reset per card, match target by name
          pactl list cards | awk '
            /^Card #/                                     { in_target=0 }
            /Name: alsa_card\.pci-0000_01_00\.1/         { in_target=1 }
            in_target && /output:hdmi/ && /available: yes/ {
              line = $0
              gsub(/^[[:space:]]+/, "", line)
              colon  = index(line, ": ")
              profile = substr(line, 1, colon - 1)
              label   = substr(line, colon + 2)
              sub(/ \(sinks:.*/, "", label)
              print label "\tprofile\t" profile
            }
          '

          # Non-NVIDIA sinks (headset, built-in, etc.)
          pactl list sinks | awk '
            /^[[:space:]]*Name:/        { name = $2 }
            /^[[:space:]]*Description:/ {
              desc = substr($0, index($0,$2))
              if (name !~ /pci-0000_01_00\.1/) print desc "\tsink\t" name
            }
          '
        )

        chosen=$(printf '%s\n' "$entries" | awk -F'\t' '{print $1}' | rofi -dmenu -p "Audio Output")
        [ -z "$chosen" ] && exit 0

        entry=$(printf '%s\n' "$entries" | awk -F'\t' -v label="$chosen" '$1 == label {print; exit}')
        type=$(printf '%s' "$entry"  | cut -f2)
        value=$(printf '%s' "$entry" | cut -f3)

        case "$type" in
          profile)
            pactl set-card-profile "$CARD" "$value"
            sleep 0.3
            new_sink=$(pactl list sinks short | awk '/pci-0000_01_00\.1/ {print $2; exit}')
            if [ -n "$new_sink" ]; then
              pactl set-default-sink "$new_sink"
              pactl list sink-inputs short | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$new_sink"
            fi
            ;;
          sink)
            pactl set-default-sink "$value"
            pactl list sink-inputs short | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$value"
            ;;
        esac
      '';
    })
  ];
}
