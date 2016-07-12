QT          += core network
QT          -= gui
CONFIG      += console
CONFIG      += c++11
osx:CONFIG  -= app_bundle

TARGET       = benchmark
TEMPLATE     = app

SOURCES     += main.cpp \
    ../include/gason.cpp \
    server.cpp \
    clients.cpp

HEADERS     += \
    ../include/gason.hpp \
    ../include/jsonbuilder.hpp \
    server.hpp \
    clients.hpp

include($$PWD/../../vendor/qompote.pri)
$$setLibPath()
VENDORNAME=azadkuh
APPNAME=qhttp
VERSION = 2.1
defined(EXPORT_PATH_PREFIX, "var"){
    EXPORT_PATH = $$EXPORT_PATH_PREFIX
}
else{
    EXPORT_PATH = $$OUT_PWD/export
}
EXPORT_PATH = $${EXPORT_PATH}/$${VENDORNAME}/$${APPNAME}/v$${VERSION}-lib
EXPORT_INCLUDEPATH = $$EXPORT_PATH/include
EXPORT_LIBPATH = $$EXPORT_PATH/$$LIBPATH
INCLUDEPATH += $$EXPORT_INCLUDEPATH
LIBS += -L$$EXPORT_LIBPATH -l$$getLibName($${APPNAME}, "Qt")
