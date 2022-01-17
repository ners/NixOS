function ask()
{
	while : ; do
		echo -n "$1 [Y/n] "
		read -r -t "$2" answer
		case $answer in
			"") echo; return 0 ;;
			[yY]*) return 0 ;;
			[nN]*) return 1 ;;
		esac
	done
}

function shout()
{
	echo -e "$(tput rev)${*}$(tput sgr0)"
}

function updateChannels()
{
	shout Updating channels...
	sudo nix-channel --update
	shout Channels updated
}

function rebuild()
{
	shout Rebuilding...
	cd /etc/nixos
	nix build --no-link -f '<nixpkgs/nixos>' config.system.build.toplevel
	shout Rebuild succeeded
	nvd diff /run/current-system "$PWD"/result
}

function switch()
{
	shout Switching to configuration...
	sudo "$PWD"/result/bin/switch-to-configuration switch
	shout Switched to "$(cat "$PWD"/result/nixos-version)"
}

if ask "Update channels? (sudo)" 3; then updateChannels; fi
rebuild
if ask "Perform switch? (sudo)" 3; then switch; fi
