#!/bin/bash

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# some defs
gccBranchName=${1}
installDir=${2}

scriptFileFullPath=`readlink -f ${0}`
scriptDirectory=`dirname ${scriptFileFullPath}`
cd ${scriptDirectory}/..
repositoryRoot=`pwd`

# thanks to https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
if [[ "$(uname)" == "Darwin" ]]; then
    lsbCode=mac
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    lsbCode=`lsb_release -sc`
else
    echo "Unsupported platform"
    exit 1
fi

${scriptDirectory}/unix_prepare_repo_once.sh

gccDir=${repositoryRoot}/.extras/gcc

cd ${gccDir}
git checkout ${gccBranchName}
git clean -xfd
./contrib/download_prerequisites

# build dir
buildDir=${repositoryRoot}/build/${lsbCode}/gcc-${gccBranchName}
mkdir -p ${buildDir}

# install dir
rm -fr ${installDir}
mkdir -p ${installDir}

# cd to build dir
cd ${buildDir}
${gccDir}/configure --prefix=${installDir} --disable-multilib
make -j$(nproc)
