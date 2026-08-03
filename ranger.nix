{inputs,config, pkgs, ... }: 

{
    programs.ranger = {
        enable = true;
        settings = {
            show_hidden = false;
            show_hidden_bookmarks = true;
            preview_files = true;
            preview_directories = true;
            collapse_preview = true;
            preview_images = true;
            preview_images_method = "kitty";
            viewmode = "miller";
            column_ratios = "1,3,4";
            save_tabs_on_exit = true;
            save_console_history = true;
            use_preview_script = true;
        };
        aliases = {
            scott = "scout -prts";
        };
        extraConfig = "default_linemode devicons";
    };
    home.file.".config/ranger/scope.sh" = {
        source = ./scope.sh;
        executable = true;
    };
}
