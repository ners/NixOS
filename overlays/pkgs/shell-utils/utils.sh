function is_interactive()
{
	[ -t 0 ]
}

function ask()
{
	local default
	local answer
	if [[ "${2:-y}" =~ ^[yY] ]]
		then default=0
		else default=1
	fi
	while : ; do
		echo -n "$1"
		if [ "$default" -eq 0 ]
			then echo -n " [Y/n] "
			else echo -n " [y/N] "
		fi
		tput dim || true
		read -r answer
		is_interactive || echo "$answer"
		tput sgr 0
		case $answer in
			"") return $default ;;
			[yY]*) return 0 ;;
			[nN]*) return 1 ;;
		esac
	done
}

function error()
{
	tput setaf 1 >&2
	echo "${@}" >&2
	tput sgr 0 >&2
}

function warn()
{
	tput setaf 3 >&2
	echo "${@}" >&2
	tput sgr 0 >&2
}

function info()
{
	tput dim || true
	echo "${@}"
	tput sgr 0
}

function debug()
{
	tput setaf 3
	echo "${@}"
	tput sgr 0
}

function fatal()
{
	error "$@"
	exit 1
}

function peval()
{
	info "$@"
	# shellcheck disable=SC2294
	eval "$@"
}

function is_root()
{
	[ "$EUID" -eq 0 ]
}

function is_tmux()
{
	[ -n "${TMUX+1}" ]
}

function ensure_root()
{
	if is_root; then
		return
	fi
	error This script should be run as root user!
	if ask "Rerun as root? (sudo)" y; then
		exec sudo "$0" "$@"
	else
		exit 1
	fi
}

function ensure_tmux()
{
	if is_tmux; then
		return
	fi
	local session
	session="$1"
	shift
	local window
	window="$session:0"
	tmux start-server
	if ! tmux has-session -t "$session" 2>/dev/null; then
		tmux new-session -d -t "$session"
	fi
	local command
	command="$0"
	local shortCommand
	shortCommand="$(basename "$command")"
	if command -v "$shortCommand" >/dev/null; then
		command="$shortCommand"
	fi
	tmux send-keys -t "$window" "$command $*" C-m
	exec tmux attach-session -t "$session"
}

function is_mounted()
{
	mount | awk "{if (\$3 == \"$1\") {exit 0}} ENDFILE{exit -1}"
}

function maybe_unmount()
{
	if is_mounted "$1"; then
		peval umount "$*"
	fi
}

function ensure_dir()
{
	if ! [ -d "$1" ]; then
		peval mkdir "$1"
	fi
}

function maybe_mount()
{
	mount_point="${*: -1}"
	ensure_dir "$mount_point"
	is_mounted "$mount_point" || peval mount "$@"
}
