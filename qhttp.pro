TEMPLATE = subdirs

APPNAME=qhttp
SUBDIRS += src
SUBDIRS += example

example.depends = src

OTHER_FILES += \
    build.xml \
    build.properties \
    build.properties.dist \
    qompoter.json \
    qompoter.pri \
    README.md \
    changelogs.md \

include($$PWD/vendor/qompote.pri)
$$setBuildDir()
message("$$APPNAME [ build folder is $$OBJECTS_DIR ]")
