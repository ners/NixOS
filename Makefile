build:
	nixos-rebuild $@

boot switch: build
	sudo nixos-rebuild $@
