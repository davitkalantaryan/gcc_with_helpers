#!/bin/bash

# example: ./scripts/unix_compile_gcc_args_version_installpath.sh releases/gcc-9.5.0 /afs/ifh.de/group/pitz/doocs/ers/sys/AlmaLinux9/gccv/9.5.0

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

startDate=$(date)

#export CFLAGS="$CFLAGS -I${repositoryRoot}/include"
#export CPPFLAGS="$CPPFLAGS -I${repositoryRoot}/include"

${scriptDirectory}/unix_prepare_repo_once.sh

gccDir=${repositoryRoot}/.extras/gcc

cd ${gccDir}
git checkout .
git checkout ${gccBranchName}
git clean -xfd
git submodule sync --recursive
git submodule update --init --recursive
./contrib/download_prerequisites

# build dir
buildDir=${repositoryRoot}/build/${lsbCode}/gcc-${gccBranchName}
mkdir -p ${buildDir}

# install dir
rm -fr ${installDir}

# cd to build dir
cd ${buildDir}
${gccDir}/configure --prefix=${installDir} --disable-multilib --disable-libsanitizer --disable-libjava
#${gccDir}/configure --prefix=${installDir} --disable-multilib --disable-libsanitizer --enable-languages=c,c++
make -j$(nproc)
mkdir -p ${installDir}
make install

endDate=$(date)

echo "startDate: " $startDate
echo "endDate:   " $endDate
