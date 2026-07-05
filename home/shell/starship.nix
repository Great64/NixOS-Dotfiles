{ config, lib, ... }:

{

  programs.starship = {
    enable = true;
    enableZshIntegration = true; 

    settings = {
      add_newline = false;
      
      format = "$username$directory$character";
   
      username = {
        show_always = true;
        format = "[$user]($style) ";
      };

      directory = {
        format = "[$path]($style) ";
      };

      character = {
        format = "$symbol ";        
        success_symbol = "λ";      
        error_symbol   = "λ";   
        vicmd_symbol   = "λ";       
      };
    };
  };
}
