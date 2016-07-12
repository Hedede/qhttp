DEPENDPATH += $$PWD
INCLUDEPATH += $$PWD $$PWD/. $$PWD/..

include($$PWD/../vendor/qompote.pri)
include($$PWD/../vendor/vendor.pri)
$$setLibPath()

VENDORNAME=azadkuh
APPNAME=qhttp
TARGET = $$getLibName($$APPNAME, "Qt")
TEMPLATE = lib
CONFIG += staticlib
CONFIG += debug_and_release build_all
QT += network
QT -= gui
CONFIG += c++11
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
message("$$APPNAME [ export folder is $${EXPORT_LIBPATH} ]")

DEFINES  += QHTTP_MEMORY_LOG=0

PUBLIC_HEADERS = \
    $$PWD/qhttpfwd.hpp \
    $$PWD/qhttpabstracts.hpp \
    $$PWD/qhttpserverconnection.hpp \
    $$PWD/qhttpserverrequest.hpp \
    $$PWD/qhttpserverresponse.hpp \
    $$PWD/qhttpserver.hpp \
    $$PWD/qhttpclient.hpp \
    $$PWD/qhttpclientresponse.hpp \
    $$PWD/qhttpclientrequest.hpp \

HEADERS  += $$PUBLIC_HEADERS

HEADERS  += \
    $$PWD/../vendor/http-parser/http_parser.h \
    $$PWD/private/qhttpbase.hpp \
    $$PWD/private/qhttpserverconnection_private.hpp \
    $$PWD/private/qhttpserverrequest_private.hpp \
    $$PWD/private/qhttpserverresponse_private.hpp \
    $$PWD/private/qhttpserver_private.hpp \
    $$PWD/private/qhttpclientrequest_private.hpp \
    $$PWD/private/qhttpclientresponse_private.hpp \
    $$PWD/private/qhttpclient_private.hpp \

SOURCES  += \
    $$PWD/../vendor/http-parser/http_parser.c \
    $$PWD/qhttpabstracts.cpp \
    $$PWD/qhttpserverconnection.cpp \
    $$PWD/qhttpserverrequest.cpp \
    $$PWD/qhttpserverresponse.cpp \
    $$PWD/qhttpserver.cpp \
    $$PWD/qhttpclientrequest.cpp \
    $$PWD/qhttpclientresponse.cpp \
    $$PWD/qhttpclient.cpp \

# Lib
QMAKE_STRIP = echo # Avoid striping header files (which will not work)
DESTDIR = $${EXPORT_LIBPATH}

# Include files
headers.files = $$PUBLIC_HEADERS
headers.path = $$EXPORT_INCLUDEPATH
INSTALLS += headers

## qompoter.pri
qompoter.files = $$PWD/../qompoter.pri
qompoter.files += $$PWD/../qompoter.json
qompoter.path = $$EXPORT_PATH
INSTALLS += qompoter
