{
  config,
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.kamadorueda.alejandra
        pkgs.vscode-extensions.aaron-bond.better-comments
        pkgs.vscode-extensions.streetsidesoftware.code-spell-checker
        pkgs.vscode-extensions.kamikillerto.vscode-colorize
        pkgs.vscode-extensions.mkhl.direnv
        pkgs.vscode-extensions.mikestead.dotenv
        pkgs.vscode-extensions.dbaeumer.vscode-eslint
        pkgs.vscode-extensions.tamasfe.even-better-toml
        pkgs.vscode-extensions.mhutchie.git-graph
        pkgs.vscode-extensions.oderwat.indent-rainbow
        pkgs.vscode-extensions.tecosaur.latex-utilities
        pkgs.vscode-extensions.james-yu.latex-workshop
        pkgs.vscode-extensions.shd101wyy.markdown-preview-enhanced
        pkgs.vscode-extensions.pkief.material-icon-theme
        pkgs.vscode-extensions.pkief.material-product-icons
        pkgs.vscode-extensions.arrterian.nix-env-selector
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.christian-kohler.path-intellisense
        pkgs.vscode-extensions.esbenp.prettier-vscode
        pkgs.vscode-extensions.yoavbls.pretty-ts-errors
        # pkgs.vscode-extensions.dustypomerleau.rust-syntax # Not valid nix option
        pkgs.vscode-extensions.rust-lang.rust-analyzer
        pkgs.vscode-extensions.shardulm94.trailing-spaces
        pkgs.vscode-extensions.vscodevim.vim
        pkgs.vscode-extensions.github.copilot
        pkgs.vscode-extensions.github.copilot-chat
      ];
      userSettings = {
        # Default formatter settings
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true; # Format on save globally enabled

        # Rust settings
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.checkOnSave" = true;

        # TypeScript/JavaScript settings
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "typescript.preferences.importModuleSpecifier" = "relative";
        "typescript.suggest.autoImports" = true;
        "javascript.suggest.autoImports" = true;

        # Nix settings
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";

        # General settings
        "alejandra.program" = "alejandra";
        "chat.editor.fontFamily" = config.stylix.fonts.monospace.name;
        "chat.editor.fontSize" = 16.0;
        "debug.console.fontFamily" = config.stylix.fonts.monospace.name;
        "debug.console.fontSize" = 16.0;
        "editor.fontFamily" = config.stylix.fonts.monospace.name;
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16.0;
        "editor.inlayHints.fontFamily" = config.stylix.fonts.monospace.name;
        "editor.inlineSuggest.fontFamily" = config.stylix.fonts.monospace.name;
        "editor.lineNumbers" = "relative";
        "editor.renderFinalNewline" = "off";
        "markdown.preview.fontFamily" = config.stylix.fonts.sansSerif.name;
        "path-intellisense.showHiddenFiles" = true;
        "terminal.integrated.fontSize" = 16.0;
        "workbench.colorTheme" = "Stylix";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.productIconTheme" = "material-product-icons";

        # Editor settings for better developer experience
        "editor.codeActionsOnSave" = {
          "source.fixAll.eslint" = true;
          "source.organizeImports" = true;
        };

        # Spell checker settings
        "cSpell.userWords" = ["alejandra" "nextjs" "tailwindcss" "typescriptreact"];
        "cSpell.enabled" = true;
      };
    };
  };
}
