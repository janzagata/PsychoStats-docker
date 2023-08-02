#!/usr/bin/env bash

MODS=' bg3 cod4 cod4x cstrike cstrikes dod dods firearms gungame hl2dm hldm natural soldat tf2 tfc'

if ! [[ -d ".git" ]]
then
    echo "This script must be run from root directory!"
    exit 1
fi

if [ $# -eq 0 ]
  then
    echo "Please specify mod you wish to install. i.e: ./scritps/install.sh cstrikes."
    echo "Options are: "
    echo -$MODS | sed 's/ /\n - /g'
    exit 1
fi

if [ $(echo $MODS | grep -w $1 > /dev/null) ]
 then
    echo "Please specify mod you wish to install. i.e: ./scritps/install.sh cstrikes."
    echo "Options are: "
    echo - $MODS | sed 's/ /\n - /g'
    exit 2
fi


git clone "https://github.com/Drek282/ps_$1.git"
cp -R "ps_$1"/* PsychoStats

cp ./docker-compose/www/config.php ./PsychoStats/www/config.php
cd PsychoStats && git ls-files www/install | xargs git update-index --assume-unchanged &&  rm -rf ./www/install && cd ..

cp ./docker-compose/root/stats.cfg ./PsychoStats/root/stats.cfg
