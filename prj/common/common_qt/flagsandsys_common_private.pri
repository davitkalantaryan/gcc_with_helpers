#
# repo:			gcc_with_helpers
# name:			flagsandsys_common_private.pri
# path:			prj/common/common_qt/flagsandsys_common_private.pri
# created on:   2024 Jul 19
# created by:   Davit Kalantaryan (davit.kalantaryan@desy.de)
# usage:		Use this qt include file to calculate some platform specific stuff
#


message("!!! $${PWD}/flagsandsys_common_private.pri")

isEmpty(gccWithHelpersPrivateFlagsAndSysCommonIncluded){
    gccWithHelpersPrivateFlagsAndSysCommonIncluded = 1

    include("$${PWD}/flagsandsys_common.pri")

    INCLUDEPATH += $${gccWithHelpersRepositoryRoot}/src/include
}
