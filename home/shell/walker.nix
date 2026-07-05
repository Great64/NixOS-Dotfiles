{ inputs, ... }:

{
  imports = [ inputs.walker.homeManagerModules.default ];

  programs.walker = {
  enable = true;
  runAsService = true;
  config = {
    theme = "mono";
    placeholders.default = {
      input = "Search";
      list = "No Results";
    };
    providers.prefixes = [
      { provider = "websearch";    prefix = "+"; }
      { provider = "providerlist"; prefix = "_"; }
    ];
    keybinds.quick_activate = [ "F1" "F2" "F3" ];
  };

  themes.mono.style = ''
  @define-color window_bg_color #000000;
  @define-color accent_bg_color #3d3d3d;
  @define-color theme_fg_color  #e0e0e0;
  @define-color muted_fg_color  #a6a6a6;
  @define-color error_bg_color  #4a4a4a;
  @define-color error_fg_color  #e0e0e0;

  * {
    all: unset;
  }

  .box-wrapper {
    background: @window_bg_color;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid @accent_bg_color;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8);
  }

  .input {
    background: transparent;
    color: @theme_fg_color;
    caret-color: @theme_fg_color;
    padding: 8px 4px;
    border-bottom: 1px solid @accent_bg_color;
  }

  .input placeholder {
    color: @muted_fg_color;
    opacity: 0.4;
  }

  .list {
    color: @theme_fg_color;
    margin-top: 8px;
  }

  .item-box {
    padding: 6px 8px;
    border-radius: 6px;
  }

  child:hover .item-box,
  child:selected .item-box {
    background: @accent_bg_color;
  }

  .item-text {
    color: @theme_fg_color;
    font-size: 14px;
  }

  /* Hide subtext */
  .item-subtext {
    opacity: 0;
    font-size: 0;
  }

  .item-image,
  .item-image-text {
    margin-right: 10px;
  }

  .item-quick-activation {
    margin-left: 10px;
    background: @accent_bg_color;
    border-radius: 4px;
    padding: 4px 8px;
    color: @muted_fg_color;
    font-size: 11px;
  }

  .placeholder,
  .elephant-hint {
    color: @muted_fg_color;
    opacity: 0.4;
  }

  /* Hide keybinds bar */
  .keybinds-wrapper {
    opacity: 0;
    min-height: 0;
    padding: 0;
    font-size: 0;
  }

  .keybinds {
    min-height: 0;
    padding: 0;
  }

  .keybind {
    min-height: 0;
    padding: 0;
    font-size: 0;
  }

  .error {
    padding: 8px;
    background: @error_bg_color;
    color: @error_fg_color;
    border-radius: 5px;
  }

  .preview {
    border: 1px solid @accent_bg_color;
    padding: 10px;
    border-radius: 6px;
    color: @theme_fg_color;
  }

  .normal-icons { -gtk-icon-size: 16px; }
  .large-icons  { -gtk-icon-size: 32px; }

  scrollbar { opacity: 0; }
'';
};
}
