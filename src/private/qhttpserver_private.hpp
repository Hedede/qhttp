/** private imeplementation.
 * https://github.com/azadkuh/qhttp
 *
 * @author amir zamani
 * @version 2.0.0
 * @date 2014-07-11
  */

#ifndef QHTTPSERVER_PRIVATE_HPP
#define QHTTPSERVER_PRIVATE_HPP
///////////////////////////////////////////////////////////////////////////////

#include "qhttpserver.hpp"
#include "qhttpserverconnection.hpp"
#include "qhttpserverrequest.hpp"
#include "qhttpserverresponse.hpp"
#include "qhttpsslconfig.hpp"

#include <QTcpServer>
#include <QLocalServer>
#include <QWebSocketServer>
///////////////////////////////////////////////////////////////////////////////
namespace qhttp {
namespace server {
///////////////////////////////////////////////////////////////////////////////

class QHttpServerPrivate
{
public:
    template<class TServer>
    class BackendServer : public TServer
    {
    public:
        QHttpServer*    iserver;

        explicit BackendServer(QHttpServer* s) : TServer(s), iserver(s) {
        }

    protected:
        // if it's a QTcpServer
        virtual void    incomingConnection(qintptr socketDescriptor) {
            iserver->incomingConnection(socketDescriptor);
        }

        // if it's a QLocalServer
        virtual void    incomingConnection(quintptr socketDescriptor) {
            iserver->incomingConnection((qintptr) socketDescriptor);
        }
    };

    using TTcpServer   = QScopedPointer<BackendServer<QTcpServer>>;
    using TLocalServer = QScopedPointer<BackendServer<QLocalServer>>;

public:
    quint32         itimeOut = 0;
    TServerHandler  ihandler = nullptr;

    TBackend        ibackend = ETcpSocket;

    TTcpServer      itcpServer;
    TLocalServer    ilocalServer;
    QWebSocketServer iwsServer;

    QByteArray      iproxyHeader;

    ssl::Config     isslConfig;

public:
    explicit    QHttpServerPrivate() : iwsServer("QHTTP", QWebSocketServer::NonSecureMode) {
        QHTTP_LINE_DEEPLOG
    }

    virtual    ~QHttpServerPrivate() {
        QHTTP_LINE_DEEPLOG
    }

    void        initialize(TBackend backend, QHttpServer* parent) {
        ibackend = backend;
        iwsServer.moveToThread(parent->thread());
        iwsServer.setParent(parent);

        if ( ibackend == ETcpSocket ) {
            ilocalServer.reset( nullptr );
            itcpServer.reset( new BackendServer<QTcpServer>(parent) );

        } else if ( ibackend == ELocalSocket ) {
            itcpServer.reset( nullptr );
            ilocalServer.reset( new BackendServer<QLocalServer>(parent) );
        }
    }
};

///////////////////////////////////////////////////////////////////////////////
} // namespace server
} // namespace qhttp
///////////////////////////////////////////////////////////////////////////////

#endif // QHTTPSERVER_PRIVATE_HPP
