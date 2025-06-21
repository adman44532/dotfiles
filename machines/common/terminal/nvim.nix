# This is the sample configuration for nvf, aiming to give you a feel of the default options
# while certain plugins are enabled. While it may partially act as one, this is *not* quite
# an overview of nvf's module options. To find a complete and curated list of nvf module
# options, examples, instruction tutorials and more; please visit the online manual.
# https://notashelf.github.io/nvf/options.html
{
  inputs,
  pkgs,
  user,
  ...
}: {
  imports = [inputs.nvf.nixosModules.default];
  environment.systemPackages = with pkgs; [ueberzug];
  home-manager.users.${user}.home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };
      options = {
        tabstop = 2;
      };
      spellcheck = {
        enable = true;
      };

      lsp = {
        # This must be enabled for the language modules to hook into
        # the LSP API.
        enable = true;

        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = false; # conflicts with blink in maximal
        otter-nvim.enable = true;
        nvim-docs-view.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      # This section does not include a comprehensive list of available language modules.
      # To list all available language module options, please visit the nvf manual.
      languages = {
        enableFormat = true; #
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Languages that will be supported in default and maximal configurations.
        nix.enable = true;
        markdown.enable = true;
        yaml.enable = true;

        # Languages that are enabled in the maximal configuration.
        bash.enable = true;
        clang.enable = true;
        css.enable = true;
        tailwind.enable = true;
        html.enable = true;
        sql.enable = true;
        ts.enable = true;
        lua.enable = true;
        python.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };

        # Language modules that are not as common.
        # java.enable = true;
        # kotlin.enable = true;
        # go.enable = true;
        # zig.enable = true;
        # typst.enable = true;
        # assembly.enable = true;
        # astro.enable = true;
        # nu.enable = true;
        # csharp.enable = true;
        # julia.enable = true;
        # vala.enable = true;
        # scala.enable = true;
        # r.enable = true;
        # gleam.enable = true;
        # dart.enable = true;
        # ocaml.enable = true;
        # elixir.enable = true;
        # haskell.enable = true;
        # ruby.enable = true;
        # fsharp.enable = true;
        # svelte.enable = true;

        # Nim LSP is broken on Darwin and therefore
        # should be disabled by default. Users may still enable
        # `vim.languages.vim` to enable it, this does not restrict
        # that.
        # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
        nim.enable = false;
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;

        # Fun
        cellular-automaton.enable = false;
      };

      statusline = {
        lualine.enable = true;
      };

      # Let Stylix handle the theming
      # theme = {
      #   enable = true;
      #   name = "catppuccin";
      #   style = "mocha";
      #   transparent = false;
      # };

      autopairs.nvim-autopairs.enable = true;

      # nvf provides various autocomplete options. The tried and tested nvim-cmp
      # is enabled in default package, because it does not trigger a build. We
      # enable blink-cmp in maximal because it needs to build its rust fuzzy
      # matcher library.
      autocomplete = {
        nvim-cmp.enable = false;
        blink-cmp.enable = true;
      };

      snippets.luasnip.enable = true;

      filetree = {
        neo-tree = {
          enable = true;
        };
      };

      tabline = {
        nvimBufferline.enable = true;
      };

      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
        hardtime-nvim.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      minimap = {
        minimap-vim.enable = false;
        codewindow.enable = true; # lighter, faster, and uses lua for configuration
      };

      projects = {
        project-nvim.enable = true;
      };

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        icon-picker.enable = true;
        surround.enable = true;
        leetcode-nvim.enable = true;
        multicursors.enable = true;
        snacks-nvim.enable = true;
        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = true;
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false; # the theme looks terrible with catppuccin
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            # this is a freeform module, it's `buftype = int;` for configuring column position
            nix = "110";
            ruby = "120";
            java = "130";
            go = ["90" "130"];
          };
        };
        fastaction.enable = true;
      };

      assistant = {
        chatgpt.enable = false;
        copilot = {
          enable = false;
          cmp.enable = true;
        };
        codecompanion-nvim.enable = false;
      };

      session = {
        nvim-session-manager.enable = false;
      };

      gestures = {
        gesture-nvim.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence = {
        neocord.enable = false;
      };
    };
  };
}
