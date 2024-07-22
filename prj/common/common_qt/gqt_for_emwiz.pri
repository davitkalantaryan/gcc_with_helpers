#  
# file:			gqt_for_emwiz.pri  
# path:			${repositoryRoot}/prj/common/common_qt/gqt_for_emwiz.pri  
# created on:	2021 Apr 07  
# created by:	Davit Kalantaryan (davit.kalantaryan@desy.de)  
#
# purpose:		To have file that will include all sources necessary for 
#				Emwiz compilation missing from libGQt library
#


message("!!! $${PWD}/gqt_for_emwiz.pri")

include ( "$${PWD}/../../common/common_qt/flagsandsys_common_private.pri" )

ROOTSYS	= /afs/ifh.de/group/pitz/doocs/data/ers/sys/$$CODENAME/opt/root-v6-02-00

LIBS += -lpcre

gQtIncludeDir   = $${rootWithHelpersRepositoryRoot}/include/gqt_for_emwiz/fromroot
gQtSourceDir	= $${rootWithHelpersRepositoryRoot}/src/gqt_for_emwiz/fromroot

INCLUDEPATH += $${rootWithHelpersRepositoryRoot}/include
INCLUDEPATH += $${gQtIncludeDir}

QMAKE_CXXFLAGS += $$system($$ROOTSYS/bin/root-config --cflags)

win32 {
	QMAKE_CXXFLAGS += /FI"extra/first_include_for_fixing_issues.h"
} else {
	QMAKE_CXXFLAGS += -Wno-misleading-indentation
	QMAKE_CXXFLAGS += -Wno-implicit-fallthrough
	QMAKE_CXXFLAGS += -include"gqt_for_emwiz/extra/first_include_for_fixing_issues.h"
}

DEFINES += GQT_FOR_EMWIZ_USED

SOURCES += \
        $${rootWithHelpersRepositoryRoot}/src/gqt_for_emwiz/extra/gqt_for_emwiz_extra01.cpp

HEADERS += \
        $${rootWithHelpersRepositoryRoot}/include/gqt_for_emwiz/extra/first_include_for_fixing_issues.h			\
	$${rootWithHelpersRepositoryRoot}/include/gqt_for_emwiz/extra/gqt_for_emwiz.h


SOURCES += $$files($${gQtSourceDir}/*.cxx,true)

HEADERS += $$files($${gQtIncludeDir}/*.h,true)
