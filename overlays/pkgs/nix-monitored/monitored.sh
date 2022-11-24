if ! [ -t 2 ]; then
	exec $command "\$@"
fi

verb="\$1"
shift
case "\$verb" in
	run)
		nom build --no-link "\$@"
		exec $command "\$verb" "\$@"
		;;
	repl|flake)
		exec $command "\$verb" "\$@"
		;;
	build|shell|develop)
		exec nom "\$verb" "\$@"
		;;
	*)
		exec $command "\$verb" "\$@" 2> >(nom 1>&2)
		;;
esac
