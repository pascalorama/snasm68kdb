#!/bin/sh

echo "Generating build information using aclocal, autoheader, automake and autoconf"
echo "This may take a while ..."

test -n "$srcdir" || srcdir=$(dirname "$0")
test -n "$srcdir" || srcdir=.

olddir=$(pwd)

cd $srcdir

# Regenerate configuration files.

aclocal
autoheader
automake --include-deps --add-missing --copy 
autoconf

cd "$olddir"

if [ "$NOCONFIGURE" = "" ]; then
	$srcdir/configure "$@" || exit 1
else
	echo "Now you are ready to run ./configure."
	echo "You can also run  ./configure --help for extra features to enable/disable."
fi
