cmake_minimum_required(VERSION 3.19)

project(qhttp)

find_package(Qt5 REQUIRED Core Network WebSockets)

add_library(qhttp
        src/qhttpfwd.hpp
        src/qhttpabstracts.hpp
        src/private/httpparser.hxx
        src/private/httpreader.hxx
        src/private/httpwriter.hxx
        src/private/qhttpbase.hpp
        src/private/qsocket.hpp
        src/qhttpabstracts.cpp
)
target_include_directories(
	qhttp PUBLIC
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
		$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
)

target_link_libraries(qhttp
	PUBLIC
		http-parser
		Qt5::Core Qt5::Network Qt5::WebSockets)

add_library(qhttp-server
        src/qhttpserverconnection.hpp
        src/qhttpserverrequest.hpp
        src/qhttpserverresponse.hpp
        src/qhttpserver.hpp
        src/private/qhttpserver_private.hpp
        src/private/qhttpserverconnection_private.hpp
        src/private/qhttpserverrequest_private.hpp
        src/private/qhttpserverresponse_private.hpp
        src/qhttpserverconnection.cpp
        src/qhttpserverrequest.cpp
        src/qhttpserverresponse.cpp
        src/qhttpserver.cpp
)

target_link_libraries(qhttp-server PUBLIC qhttp)

add_library(qhttp-client
        src/qhttpclient.hpp
        src/qhttpclientresponse.hpp
        src/qhttpclientrequest.hpp
        src/private/qhttpclient_private.hpp
        src/private/qhttpclientrequest_private.hpp
        src/private/qhttpclientresponse_private.hpp
        src/qhttpclientrequest.cpp
        src/qhttpclientresponse.cpp
        src/qhttpclient.cpp
)

target_link_libraries(qhttp-client PUBLIC qhttp)
target_compile_definitions(qhttp-client PRIVATE QHTTP_HAS_CLIENT)
