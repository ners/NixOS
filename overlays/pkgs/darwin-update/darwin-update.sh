set -e
ensure_tmux nixos-update "$@"
peval cd ~/Projects/NixOS
peval nix flake update
peval darwin-rebuild build --flake .
peval nvd diff /run/current-system result
if ask "Perform switch? (sudo)" y; then
	peval result/sw/bin/darwin-rebuild switch --flake .
fi
