{ inputs, lib, ... }:

with lib;
{
  # Pipes a value through a list of functions.
  # Produces a lambda that accepts a starting value when called with just a list of functions.
  pipef = flip pipe;

  # The unary function equivalent of ! operator
  not = x: !x;

  # A convenient attribute to debug which version of lib we are using.
  zzz = "zzz";
}
