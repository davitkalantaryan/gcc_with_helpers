#!/bin/bash

# example: ./scripts/unix_compile_glibc_args_version_installpath.sh glibc-2.17.90 /afs/ifh.de/group/pitz/doocs/ers/sys/AlmaLinux9/glibcv/2.17.90

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# some defs
glibcBranchName=${1}
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

startDate=$(date)

${scriptDirectory}/unix_prepare_repo_once.sh

glibcDir=${repositoryRoot}/.extras/glibc

cd ${glibcDir}
git checkout .
git checkout ${gccBranchName}
git clean -xfd
git submodule sync --recursive
git submodule update --init --recursive

# build dir
buildDir=${repositoryRoot}/build/${lsbCode}/glibc/${gccBranchName}
mkdir -p ${buildDir}

# install dir
rm -fr ${installDir}

# cd to build dir
cd ${buildDir}
${glibcDir}/configure --prefix=${installDir}
make
mkdir -p ${installDir}
make install

endDate=$(date)

echo "startDate: " $startDate
echo "endDate:   " $endDate
