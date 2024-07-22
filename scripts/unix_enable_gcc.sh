#
# Author: D. Kalantaryan (davit.kalantaryan@desy.de)
#

makeMainJob (){
    local gccRootDir=${1}
    export PATH=${gccRootDir}/bin:${PATH}
    export LD_LIBRARY_PATH=${gccRootDir}/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
}

makeMainJob ${1}
