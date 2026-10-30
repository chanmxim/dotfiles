# .dotfiles

![License](https://img.shields.io/badge/License-MIT-000000?style=for-the-badge&logo=opensourceinitiative&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-00A79D?style=for-the-badge&logo=hyprland&logoColor=white)
![Kitty](https://img.shields.io/badge/Kitty-393939?style=for-the-badge&logo=terminal&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Tmux](https://img.shields.io/badge/Tmux-1TBS?style=for-the-badge&logo=tmux&logoColor=white)
![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-292E31?style=for-the-badge&logo=terminal&logoColor=white)
![Starship](https://img.shields.io/badge/STARSHIP-dd0b78?style=for-the-badge&logo=Starship&logoColor=white)
![Fastfetch](https://img.shields.io/badge/Fastfetch-38;2;118;159;240?style=for-the-badge&logo=linux&logoColor=white)
![Pacman](https://img.shields.io/badge/Pacman-ECC400?style=for-the-badge&logo=arch-linux&logoColor=black)

## Description

A personal collection of dotfiles to help set up and maintain a consistent development environment across systems. This includes configurations for my terminal, prompt, window manager, and shell aliases. Primarily tailored for **Arch Linux** environments using **GNU Stow** for management.

## Features

- **Hyprland** — Dynamic tiling Wayland compositor setup with custom keybindings, window rules, and animations
- **Kitty** — GPU-accelerated terminal emulator configured with custom fonts and theming to match the system aesthetic
- **Neovim** — Custom Lua configuration using `lazy.nvim`
- **Tmux** - Multiplexer setup featuring a custom Starship-themed status bar
- **Bash** - Customized shell setup
- **Zsh** — Customized shell setup featuring interactive menu selection, categorized autocompletion, and Vim keybindings
- **Starship** — **Tokyo Night** prompt theme, customized with the Arch Linux logo (``) and a matching blue color palette
- **Fastfetch** — Minimalist system information display featuring custom ASCII art and a `#769ff0` color theme
- **Package Management** — Automated tracking of system and AUR packages via `pacman` hooks

## Requirements

- **GNU Stow** — Used to symlink these dotfiles into place
- **MesloLGS Nerd Font** — Required to display the prompt icons correctly

## Package Management

Plain-text lists stored in `packages/` for easy system replication.

- **`pacman.txt`** — Official repository packages
- **`aur.txt`** — Foreign (AUR) packages
