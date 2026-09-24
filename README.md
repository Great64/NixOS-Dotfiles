# ❄️ NixOS System ❄️

## :: About

> My personal NixOS system files.

Although NixOS is known to be easily reproducible, these files are not intended to work on other systems; please do not copy and paste these configurations as they will not work. 

Coming from Arch Linux and prone to breaking things, I wanted a system I could rely on without the privacy invasions and AI features of [Microslop](https://www.pcworld.com/article/3075135/microsoft-says-stop-calling-it-microslop-or-youre-banned.html). After reading more about NixOS, I decided to switch to it for a few main reasons: it's virtually bulletproof, it's reproducible, and it's much easier to manage bloat. 

Now, I am slowly fine tuning my system towards my own workflows while trying to keep a minimal yet practical approach. I am by no means an expert in anything Nix or NixOS but I have done my best to keep simple and effective Nix practices throughout my configurations. 

## :: Environment


> I've recently been liking a clean & monochrome setup; easy on the eyes and less distractions. 

![[Pasted image 20260924145910.png]]

![[Pasted image 20260924145349.png]]

## :: Info


| System Tool          | Purpose          |
| -------------------- | ---------------- |
| Window Manager       | Niri             |
| Display Manager      | Tuigreet         |
| Terminal Emulator    | Alacritty, Kitty |
| Terminal Multiplexer | Tmux             |
| File Manager         | Yazi             |
| File System          | ext4 + FAT32     |
| Shell                | Zsh              |
| Editor               | Neovim           |
| Browser              | Librewolf        |

**Other:** rofi, noctalia, awww

> Noctalia is subject to be removed at some point since I do not use it much

## :: Nix Features

1. home-manager
2. flakes

> I have tried using the dendritic pattern, however I found it to be needless abstraction for my use case
