#
# Author: D. Kalantaryan (davit.kalantaryan@desy.de)
#

makeMainJob (){
    local gccRootDir=${1}
    export PATH=${gccRootDir}/bin:${PATH}
    export LD_LIBRARY_PATH=${gccRootDir}/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
    export C_INCLUDE_PATH=${gccRootDir}/include${C_INCLUDE_PATH:+:$C_INCLUDE_PATH}
    export CPLUS_INCLUDE_PATH=${gccRootDir}/include${CPLUS_INCLUDE_PATH:+:$CPLUS_INCLUDE_PATH}
    export LIBRARY_PATH=${gccRootDir}/lib64${LIBRARY_PATH:+:$LIBRARY_PATH}
}

makeMainJob ${1}
