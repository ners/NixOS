if [ -t 1 ] && [ "\$1" == build ]; then
  exec $command "\$@" |& $nom
elif [ -t 1 ] && [ "\$1" == run ]; then
  shift
  $command build --no-link "\$@" |& $nom
  exec $command run "\$@"
else
  exec $command "\$@"
fi
