TEMPLATE = subdirs

SUBDIRS += helloworld
SUBDIRS += postcollector
SUBDIRS += basic-server
SUBDIRS += ssl-simple

contains(DEFINES, QHTTP_HAS_CLIENT) {
    SUBDIRS += keep-alive
}

