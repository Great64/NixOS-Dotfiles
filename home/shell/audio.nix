{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "audio-switch";
      runtimeInputs = [ pkgs.pulseaudio pkgs.gawk ];
      text = ''
        chosen=$(pactl list sinks | awk '
          /^[[:space:]]*Name:/        { name = $2 }
          /^[[:space:]]*Description:/ { desc = substr($0, index($0,$2)); print desc "\t" name }
        ' | rofi -dmenu -p "Audio Output" | awk -F'\t' '{print $2}')

        [ -z "$chosen" ] && exit 0

        pactl set-default-sink "$chosen"
        pactl list sink-inputs short | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$chosen"
      '';
    })
  ];
}
