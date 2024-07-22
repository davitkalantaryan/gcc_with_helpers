
TEMPLATE = subdirs
#CONFIG += ordered

message("!!! $${_PRO_FILE_}")

include ( "$${PWD}/../../prj/common/common_qt/flagsandsys_common_private.pri" )

#SUBDIRS		+=	$${rootWithHelpersRepositoryRoot}/prj/core/root_srcs_qt/root_srcs.pro
#SUBDIRS		+=	$${rootWithHelpersRepositoryRoot}/prj/core/libgqt_for_emwiz_qt/libgqt_for_emwiz.pro


OTHER_FILES += $$files($${gccWithHelpersRepositoryRoot}/scripts/*.sh,true)
OTHER_FILES += $$files($${gccWithHelpersRepositoryRoot}/scripts/*.bat,true)
OTHER_FILES += $$files($${gccWithHelpersRepositoryRoot}/scripts/.raw/*.sh,true)
OTHER_FILES += $$files($${gccWithHelpersRepositoryRoot}/scripts/.raw/*.bat,true)

OTHER_FILES	+=	\
        $${gccWithHelpersRepositoryRoot}/.gitattributes	\
	$${gccWithHelpersRepositoryRoot}/.gitignore	\
	$${gccWithHelpersRepositoryRoot}/.gitmodules	\
	$${gccWithHelpersRepositoryRoot}/README.md
