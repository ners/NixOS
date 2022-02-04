peval cd /etc/nixos
shout Updating...
peval nix flake update
shout Rebuilding...
peval nixos-rebuild build --flake ".#$(hostname)" --impure
shout Rebuild succeeded
peval nvd diff /run/current-system "$PWD"/result
if ask "Perform switch? (sudo)" y; then
	debug Switching to configuration...
	peval sudo "$PWD"/result/bin/switch-to-configuration switch
	debug Switched to "$(cat "$PWD"/result/nixos-version)"
fi
