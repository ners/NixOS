peval cd /etc/nixos
peval nix flake update
peval nixos-rebuild build --flake . --impure "$@"
peval nvd diff /run/current-system result
if ask "Perform switch? (sudo)" y; then
	peval sudo result/bin/switch-to-configuration switch
fi
