#!/bin/bash

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

scriptFileFullPath=`readlink -f ${0}`
scriptDirectory=`dirname ${scriptFileFullPath}`
cd ${scriptDirectory}/..
repositoryRoot=`pwd`

EXTRAS_DIRECTORY=${repositoryRoot}/.extras
if [ ! -d "$EXTRAS_DIRECTORY" ]; then
    mkdir -p "$EXTRAS_DIRECTORY"
fi

cd ${EXTRAS_DIRECTORY}
if [ ! -d "gcc" ]; then
    git clone https://github.com/davitkalantaryan/fork-gcc.git gcc
fi
