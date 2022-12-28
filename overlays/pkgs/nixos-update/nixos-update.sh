ensure_tmux nixos-update "$@"
peval cd /etc/nixos
peval nix flake update
peval nixos-rebuild build --impure --flake "$PWD" "$@"
peval nvd diff /run/current-system result
if ask "Perform switch? (sudo)" y; then
	peval sudo result/bin/switch-to-configuration switch
	if systemctl is-active --quiet plymouth-start.service; then
		peval sudo systemctl stop plymouth-start.service
	fi
fi
