#!/usr/bin/env sh

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X platform
    SED=gsed
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux platform
    SED=sed
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Windows NT platform
    SED=sed
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
    # Cygwin NT platform
    SED=sed
else
    # Default
    SED=sed
fi

for arg in "$@"; do

    # UNIX Line Ending
    dos2unix "$arg"

    # POSIX EOF
    vi -escwq "$arg"

    # Remove Trailing White Spaces
    $SED -i 's/\s*$//' "$arg"

    # Remove Trailing Empty Lines
    $SED -i ':a;/^[\s\n]*$/{$d;N;ba}' "$arg"
done
