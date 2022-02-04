# A Somewhat Attractive NixOS Configuration

<img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg" align="right" alt="Nix logo" width="150">

> This is my Nix flake. There are many like it, but this one is mine.
>
> My Nix flake is my best friend. It is my life. I must master it as I must master my life.
>
> Without me, my Nix flake is useless. Without my Nix flake, I am useless. I must configure my Nix flake true. I must build more reproducibly than my computer who is trying to deceive me. I must configure it before it deceives me. I will ...
>
> My Nix flake and I know that what counts in IT is not the amount of words we type, the noise of our keyboard, nor the outputs we make. We know that it is the derivations that count. We will derive ...
>
> My Nix flake is human, even as I am human, because it is my life. Thus, I will learn it as a brother. I will learn its weaknesses, its strength, its code, its tooling, its inputs and outputs. I will keep my Nix flake clean and ready, even as I am clean and ready. We will become part of each other. We will ...
>
> Before God, I swear this creed. My Nix flake and I are the defenders of reliability. We are the masters of reproducibility. We are the saviors of my life.
>
> So be it, until victory is reproducible and there is no uncertainty, but peace!
>
> — NixOS User's Creed

## Overview

This repository contains configuration files that can be used to build a [NixOS][nixos] image, or to configure [Nix on other Linux distributions][nix-on-linux] (including [WSL][nix-on-wsl]) by using [home-manager][home-manager].

## Who is this for?

The primary purpose of this repository is to [Just Work™][just-work] as a configuration for [my][ners] [devices][configurations].

However, the repository is also intended as a model of a fully-featured NixOS configuration.
As such it can be used as a reference or starting point for others interested in Nix and NixOS.

## Design goals

The following goals are the driving force of this repository:

### Easy to study and extend

The configurations provided by this repository are opinionated, and are indeed only guaranteed to work for me.
However, they should provide a good starting point for those seeking to strengthen their Nix-fu, as well as a base on top of which one can easily create derivative configurations, even with little Nix knowledge.
If nothing else, I rely on this feature when creating new configurations for myself.
 - Separation of concerns makes it easy to enable features, either shared across configurations, or specific to a configuration.
 - There should be as few sources of truth as possible; e.g. the [latest NixOS version], while referenced in multiple places, is only specified [once][nixos-version-defined].
 - Care has gone into organising and documenting the repository. Eventually all non-trivial decisions should be documented and justified.

### Good desktop experience

The Linux Desktop has in many ways surpassed other desktop offerings in both form and function.
A good distribution should delight its users from first boot.

This largely comes down to choosing sensible defaults:
 - The GNOME desktop environment has rightfully become the de facto standard of modern Linux Desktop. It is mature, feature-complete, and polished to a shine even out of the box.
 - Wayland and Pipewire are modern standards for video and audio respectively.
 - The keyboard layout of choice should be set up in both console and graphical environments.
 - The shell/terminal setup should be delightful rather than boring and plain, and should not break POSIX compatilibity.
 - Reasonably useful utilities such as virtualisation managers, e-mail clients, and office applications, should come out of the box; the ease of doing so is the largest victory of modern Linux desktop.
 - When running as a virtualised guest, it should be easy to configure guest tools and agents for improved integration with the host; e.g. the [ISO image][iso-image] is one such configuration.

### Easy server setup

In addition to desktop configurations, this repository should also make it easy to specify server configurations.
Many of these goals also benefit the desktop experience:
 - Full-disk encryption should be an easy default.
 - Modern filesystems (e.g. [btrfs][btrfs]) add features such as subvolumes, snapshotting, transparent compression, and many more. These should be used to their full potential.
 - systemd and NetworkManager should be leveraged to their full extent.

### Easy to install and maintain

After test-driving the live environment, installing it to persistent storage should be as painless as possible.

NixOS has no canonical guided installation yet, so this repository provides [an opinionated one][installation-wizard].

There is also [a utility][update-wizard] for updating the system.

## How to get started?

WIP

[btrfs]: https://btrfs.wiki.kernel.org
[configurations]: /configurations
[home-manager]: https://github.com/nix-community/home-manager
[installation-wizard]: /overlays/pkgs/nixos-wizard/wizard.sh
[iso-image]: /configurations/iso-image/default.nix
[just-work]: https://youtu.be/CZFKWt3S2Ys
[ners]: https://github.com/ners
[nix-on-linux]: https://nixos.org/download.html#nix-install-linux
[nix-on-wsl]: https://nixos.wiki/wiki/Nix_Installation_Guide#Windows_Subsystem_for_Linux_.28WSL.29
[nixos-version-defined]: /flake.nix#L3
[nixos]: https://nixos.org
[update-wizard]: /overlays/pkgs/nixos-update/nixos-update.sh
