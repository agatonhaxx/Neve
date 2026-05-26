{
  description = "Neve is a Neovim configuration built with Nixvim, which allows you to use Nix language to manage Neovim plugins/options";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/d233902339c02a9c334e7e593de68855ad26c4cb";
    nixvim.url = "github:nix-community/nixvim/9b28a7e6e3e6f61b114a550941abfc9fce0645cc";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      flake-utils,
      ...
    }@inputs:
    let
      config = import ./config; # import the module directly
      # Enable unfree packages
      nixpkgsConfig = {
        allowUnfree = true;
      };
    in
    {
      nixvimModule = config;
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixvimLib = nixvim.lib.${system};
        pkgs = import nixpkgs {
          inherit system;
          config = nixpkgsConfig;
        };
        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = config;
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            inherit self;
          };
        };
      in
      {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = (nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "Neve";
          }).overrideAttrs (oldAttrs: {
            # Neovim 0.12 requires $HOME/.local/share/nvim for stdpath('data').
            # The nixvim test harness only creates .cache/nvim. Pre-create the
            # missing directory before running nvim.
            buildCommand = ''
              mkdir -p .local/share/nvim
            '' + oldAttrs.buildCommand;
          });
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nvim;

          # Wrapped with Lua runtimepath fix for Neovim 0.12
          wrapped = pkgs.symlinkJoin {
            name = "neve-wrapped";
            paths = [ nvim ];
            postBuild = ''
              mv $out/bin/nvim $out/bin/.nvim-real
              cat > $out/bin/nvim << 'SCRIPT'
            #!/bin/sh
            exec "$(dirname "$0")/.nvim-real" --cmd "lua for _,p in ipairs(vim.api.nvim_get_runtime_file('lua',true)) do package.path=package.path..';'..p..'/?.lua;'..p..'/?/init.lua' end" "$@"
            SCRIPT
              chmod +x $out/bin/nvim
            '';
            meta.mainProgram = "nvim";
          };
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
