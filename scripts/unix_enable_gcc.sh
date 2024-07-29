#
# Author: D. Kalantaryan (davit.kalantaryan@desy.de)
#

makeMainJob() {
    local gccRootDir=${1}

    # Add GCC binary to the PATH
    export PATH=${gccRootDir}/bin:${PATH}

    # Add GCC libraries to the LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=${gccRootDir}/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

    # Set up C++ include path
    local cplus_include_path=$(find ${gccRootDir} -name "iostream" -type f | head -n 1)
    if [ -n "$cplus_include_path" ]; then
        cplus_include_path=$(dirname $(dirname "$cplus_include_path"))
	export CPLUS_INCLUDE_PATH=${cplus_include_path}${CPLUS_INCLUDE_PATH:+:$CPLUS_INCLUDE_PATH}
    else
        echo "Error: iostream header not found in ${gccRootDir}. C++ include path not set."
	        return 1
    fi

    # Set up C include path
    local c_include_path=$(find ${gccRootDir} -name "stdlib.h" -type f | head -n 1)
    if [ -n "$c_include_path" ]; then
        c_include_path=$(dirname "$c_include_path")
	export C_INCLUDE_PATH=${c_include_path}${C_INCLUDE_PATH:+:$C_INCLUDE_PATH}
    else
        echo "Warning: stdlib.h header not found in ${gccRootDir}. C include path not set."
    fi

    # Set up library path
    export LIBRARY_PATH=${gccRootDir}/lib64${LIBRARY_PATH:+:$LIBRARY_PATH}
}

# Call the function with the provided GCC root directory
makeMainJob ${1}
