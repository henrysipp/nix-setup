{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.omarchy.nixosModules.default
  ];

  omarchy = {
    full_name = "Henry Sipp";
    email_address = "hesipp@gmail.com";
    theme = "tokyo-night";
    primary_font = "Berkeley Mono";
    exclude_packages = with pkgs; [
      signal-desktop
    ];
    vscode_settings = {
      "editor.fontFamily" = "Berkeley Mono";
      "editor.minimap.enabled" = false;
      "vim.useCtrlKeys" = false;
      "[typescriptreact]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };
    quick_app_bindings = [
      "SUPER, A, exec, $webapp=https://claude.ai"
      "SUPER, C, exec, $webapp=https://app.hey.com/calendar/weeks/"
      "SUPER, E, exec, $webapp=https://app.hey.com"
      "SUPER, Y, exec, $webapp=https://youtube.com/"
      "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"
      "SUPER, X, exec, $webapp=https://x.com/"
      "SUPER SHIFT, X, exec, $webapp=https://x.com/compose/post"

      "SUPER, return, exec, $terminal"
      "SUPER, F, exec, $fileManager"
      "SUPER, B, exec, $browser"
      "SUPER, M, exec, $music"
      "SUPER, N, exec, $terminal -e nvim"
      "SUPER, T, exec, $terminal -e btop"
      "SUPER, D, exec, $terminal -e lazydocker"
      "SUPER, G, exec, $messenger"
      "SUPER, O, exec, obsidian -disable-gpu"
      "SUPER, slash, exec, $passwordManager"
    ];
  };
}
