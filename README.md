# blepos — NixOS Flakes Repository

A personal Nix/NixOS flakes repository to manage system configurations, Home Manager setups, development environments, and reusable modules.

## Goals

- **Single source of truth** for machines, users, and packages
- **Reproducible** and **composable** flake outputs
- Easy workflows for **nixos-rebuild**, **home-manager**, and **devShells**

## Prerequisites

- Nix with flakes and nix-command enabled
  - Temporarily: use `nix --extra-experimental-features 'nix-command flakes' ...`
  - Permanently: add to `/etc/nix/nix.conf` or `/etc/nixos/configuration.nix`:
    ```nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    ```
- For NixOS systems: NixOS 22.11+ recommended
- Optional: Home Manager (flake-based)

## Quick Start

This repo is currently empty. To bootstrap:

1. Initialize a flake:
   ```bash
   nix flake init -t github:nix-community/nixdirenv#minimal  # or: -t templates from your choice
   # Or start from an empty flake:
   cat > flake.nix <<'EOF'
   {
     description = "blepos — personal Nix/NixOS flakes";

     inputs = {
       nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
       # home-manager.url = "github:nix-community/home-manager";
       # home-manager.inputs.nixpkgs.follows = "nixpkgs";
     };

     outputs = { self, nixpkgs, ... }@inputs: let
       systems = [ "x86_64-linux" "aarch64-linux" ];
       forAllSystems = f: nixpkgs.lib.genAttrs systems (s: f s);
     in {
       # Dev shells for hacking on this repo
       devShells = forAllSystems (system: let pkgs = import nixpkgs { inherit system; }; in {
         default = pkgs.mkShell { buildInputs = [ pkgs.nixfmt-rfc-style pkgs.git ]; };
       });

       # Placeholders for future use
       packages = forAllSystems (system: {});
       apps = forAllSystems (system: {});

       # Example NixOS configuration: define hosts under ./nixos/...
       # nixosConfigurations = {
       #   my-host = nixpkgs.lib.nixosSystem {
       #     system = "x86_64-linux";
       #     modules = [ ./nixos/hosts/my-host/configuration.nix ];
       #   };
       # };

       # Example Home Manager: define users under ./home/...
       # homeConfigurations = {
       #   "vince@machine" = inputs.home-manager.lib.homeManagerConfiguration {
       #     pkgs = import nixpkgs { system = "x86_64-linux"; };
       #     modules = [ ./home/vince/home.nix ];
       #   };
       # };
     };
   }
   EOF
   ```

2. Pin inputs and check:
   ```bash
   nix flake update
   nix flake check
   ```

3. Commit the baseline:
   ```bash
   git add .
   git commit -m "init: flake skeleton for blepos"
   ```

## Common Workflows

- **Update inputs**:
  ```bash
  nix flake update
  ```

- **Dev shell in this repo**:
  ```bash
  nix develop
  ```

- **Build a package or app output**:
  ```bash
  nix build .#<name>
  ```

- **NixOS rebuild (from this flake)**:
  ```bash
  sudo nixos-rebuild switch --flake .#<hostname>
  ```

- **Home Manager switch (flake)**:
  ```bash
  home-manager switch --flake .#<user>@<host>
  ```

## Suggested Layout

- `flake.nix` — top-level inputs/outputs
- `flake.lock` — pinned inputs (auto-generated)
- `nixos/hosts/<host>/configuration.nix` — host configs
- `nixos/modules/*.nix` — reusable NixOS modules
- `home/<user>/*.nix` — Home Manager configs
- `overlays/*.nix` — package overlays
- `pkgs/<name>/default.nix` — custom packages

## Tips

- Prefer `nixos-unstable` or a stable branch (e.g., `nixos-24.05`) for `nixpkgs`
- Keep modules small and composable; avoid monolith host configs
- Add CI later with `nix flake check` to validate builds

## License

Choose a license (e.g., MIT). Add a `LICENSE` file when decided.
