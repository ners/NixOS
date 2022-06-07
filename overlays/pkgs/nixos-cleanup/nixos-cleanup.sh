function find_stale_links()
{
	find "$1" -type l | while read -r f; do
		s=${f//-[0-9]*-link/}
		if [ "$s" = "$f" ] || [ "$(readlink -f "$s")" = "$(readlink -f "$f")" ]
			then continue
			else echo "$f"
		fi
	done
}

stale_links=("$(find_stale_links /nix/var/nix/profiles)")
if [ "${stale_links#}" -gt 0 ]
	then
		info "Found stale links:"
		info "${stale_links[@]}"
		if ask "Remove stale links? (sudo)" y
			then peval sudo rm -rf "${stale_links[*]}"
		fi
	else info No stale links found
fi

info Collecting garbage
peval sudo nix-collect-garbage -d
