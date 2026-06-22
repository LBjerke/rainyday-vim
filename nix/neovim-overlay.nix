# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (p: [ p.zig p.go p.nix p.lua p.vim ]))
    luasnip
    nvim-cmp
    cmp_luasnip
    lspkind-nvim
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-cmdline-history
    harpoon2
    gitsigns-nvim
    telescope-nvim
    telescope-fzy-native-nvim
    lualine-nvim
    nvim-navic
    nvim-surround
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring
    nvim-unception
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    bamboo-nvim
    which-key-nvim
    oil-nvim
    sidekick-nvim
  ];
  all-plugins-mac = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (p: [ p.zig p.go p.nix p.lua p.vim ]))
    luasnip
    nvim-cmp
    cmp_luasnip
    lspkind-nvim
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-cmdline
    cmp-cmdline-history
    harpoon2
    gitsigns-nvim
    telescope-nvim
    telescope-fzy-native-nvim
    lualine-nvim
    nvim-navic
    nvim-surround
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring
    nvim-unception
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    bamboo-nvim
    which-key-nvim
    oil-nvim
    sidekick-nvim
  ];

  extraPackagesMac = with pkgs; [
    lua-language-server
    nil
    go
    gopls
    nodejs
    copilot-language-server
    opencode
    ripgrep
    git
    cacert
    hostname
  ];
  extraPackages = with pkgs; [
    lua-language-server
    nil
    go
    gopls
    zig
    zls
    nodejs
    copilot-language-server
    opencode
    ripgrep
    git
    cacert
    hostname
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This is meant to be used within a devshell.
  # Instead of loading the lua Neovim configuration from
  # the Nix store, it is loaded from $XDG_CONFIG_HOME/nvim-dev
  nvim-dev = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    appName = "nvim-dev";
    wrapRc = false;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

   nvim-mac-pkg = mkNeovim {
     plugins = all-plugins-mac;
     inherit extraPackages;
   };
}
