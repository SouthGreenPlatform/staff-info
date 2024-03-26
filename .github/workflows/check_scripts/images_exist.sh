#!/bin/bash

cd "$( git rev-parse --show-toplevel )" || exit

awk '/^[[:blank:]]*image: / {
    print FILENAME, " trombinoscope/photo/"$2
}'  trombinoscope/staff/*.yaml |
{
    success=true

    while read -r ymlfile imgfile; do
        if [[ $ymlfile == *TEMPLATE* ]]; then
            continue
        fi
        imgfile=$(tr -dc '[[:print:]]' <<< "$imgfile") # remove non printable character
        if [ ! -e "$imgfile" ]; then
            echo  "Achtung: $imgfile (from $ymlfile) does not exist\n" >&2
            success=false
        fi
    done

    "$success"
}
