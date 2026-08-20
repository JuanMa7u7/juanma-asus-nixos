# NixOS Configuration

This repository manages two NixOS hosts with a shared Hyprland + Caelestia desktop layer:

- `thinkpad-l15`: laptop-oriented profile
- `mamalona`: desktop profile with Nvidia-specific configuration, VFIO/VM, gaming

## Layout

- `flake.nix`: host definitions and shared inputs
- `common/default.nix`: host assembly (imports system config + home-manager bootstrap)
- `common/system/`: shared system-wide configuration (boot, hardware, networking, services, users)
- `common/hm/`: shared Home Manager configuration (programs, packages, services, raw config files, Caelestia settings)
- `hosts/<name>/configuration.nix`: host-specific NixOS settings
- `hosts/<name>/home.nix`: host-specific Home Manager settings
- `hosts/<name>/hm/`: host-specific Home Manager configuration (monitor layout, etc.)
- `hosts/<name>/system.nix`: host-local system fragments when needed

## Caelestia Shell

Caelestia Shell is consumed as a GitHub flake input (`github:JuanMa7u7/caelestia-shell`).
The `caelestia-shell/` directory is a git submodule containing the source for reference and local customization.

Per-host Caelestia customization (monitor layout, gifs) lives under `hosts/<name>/hm/confs/caelestia/`.

## Conventions

- Hardware-specific drivers, mounts, and quirks belong inside the relevant host directory.
- NVIDIA, gaming, and VFIO configuration belongs only to `mamalona`.
- Shared modules should stay hardware-agnostic unless every host needs the same behavior.
- Some legacy/unused modules are preserved under `common/hm/` as inactive references (e.g., `hydenix.nix`, `gh-repos.nix`, `opencode.nix`, and upstream Arch leftovers under `confs/`).

## Common Commands

```bash
sudo nixos-rebuild switch --flake .#thinkpad-l15
sudo nixos-rebuild switch --flake .#mamalona
```
