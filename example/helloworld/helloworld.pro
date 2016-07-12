QT          += core network
QT          -= gui
osx:CONFIG  -= app_bundle

TARGET       = helloworld
TEMPLATE     = app
CONFIG      += c++11

HEADERS   +=

SOURCES   += main.cpp

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
