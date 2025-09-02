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

1) Generate hardware config on the target NixOS host (nuc):
```bash
sudo nixos-generate-config --show-hardware-config > hosts/nuc/hardware-configuration.nix
```

2) Pin inputs and validate the flake:
```bash
nix flake update
nix flake check
```

3) Switch the system to this flake:
```bash
sudo nixos-rebuild switch --flake .#nuc
```

4) Optionally switch Home Manager directly (without full NixOS rebuild):
```bash
home-manager switch --flake .#"vince@nuc"
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
  sudo nixos-rebuild switch --flake .#nuc
  ```

- **Home Manager switch (flake)**:
  ```bash
  home-manager switch --flake .#"vince@nuc"
  ```

## Bootstrap on Arch (later)

Do this when you decide to try Home Manager on Arch. These commands are safe and reversible.

1) Install Nix (multi-user) and enable flakes:
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
echo "experimental-features = nix-command flakes" | sudo tee /etc/nix/nix.conf
```

2) Run Home Manager from this flake (simpler alias):
```bash
home-manager switch --flake .#vince
```

3) Alternative build-then-activate (no HM in profile):
```bash
nix build .#homeConfigurations.vince.activationPackage
./result/activate
```

4) When moving to NixOS later (on the NUC):
```bash
sudo nixos-rebuild switch --flake .#nuc
```

## Repository Structure

- `flake.nix` — inputs (nixpkgs, home-manager) and outputs
- `hosts/nuc/configuration.nix` — minimal host entrypoint (hostname + imports)
- `hosts/nuc/hardware-configuration.nix` — generated hardware config
- `hosts/nuc/modules/` — small focused NixOS modules:
  - `boot.nix`, `locale.nix`, `users.nix`, `nix.nix`, `networking.nix`, `firewall.nix`
  - `audio.nix`, `greetd-sway.nix`, `graphics.nix`, `fonts.nix`, `packages.nix`, `services.nix`, `security.nix`, `state.nix`
- `home/vince.nix` — minimal Home Manager entrypoint (user metadata + imports)
- `home/modules/` — user modules: `packages.nix`, `sway.nix`, `programs.nix`, `services.nix`, `git.nix`, `fonts.nix`, `waybar.nix`, `foot.nix`, `wofi.nix`

## Suggested Layout

- `flake.lock` — pinned inputs (auto-generated)
- `hosts/<host>/configuration.nix` — host configs
- `hosts/<host>/modules/*.nix` — per-host modules
- `home/<user>/modules/*.nix` — per-user modules
- `overlays/*.nix` — package overlays (optional)
- `pkgs/<name>/default.nix` — custom packages (optional)

## Tips

- Prefer `nixos-unstable` or a stable branch (e.g., `nixos-24.05`) for `nixpkgs`
- Keep modules small and composable; avoid monolith host configs
- Add CI later with `nix flake check` to validate builds

## License

Choose a license (e.g., MIT). Add a `LICENSE` file when decided.
