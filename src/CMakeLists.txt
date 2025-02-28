project(gallery_src)

add_subdirectory(util)
add_subdirectory(core)
add_subdirectory(album)
add_subdirectory(database)
add_subdirectory(event)
add_subdirectory(media)
add_subdirectory(medialoader)
add_subdirectory(photo)
add_subdirectory(qml)
add_subdirectory(video)

configure_file(
    config.h.in
    ${CMAKE_CURRENT_BINARY_DIR}/config.h
    @ONLY
    )

include_directories(
    ${gallery_util_src_SOURCE_DIR}
    ${gallery_core_src_SOURCE_DIR}
    ${gallery_database_src_SOURCE_DIR}
    ${gallery_media_src_SOURCE_DIR}
    ${gallery_medialoader_src_SOURCE_DIR}
    ${gallery_event_src_SOURCE_DIR}
    ${gallery_album_src_SOURCE_DIR}
    ${gallery_photo_src_SOURCE_DIR}
    ${gallery_video_src_SOURCE_DIR}
    ${gallery_qml_src_SOURCE_DIR}
    ${CMAKE_BINARY_DIR}
    )

set(gallery_HDRS
    gallery-application.h
    gallery-manager.h
    media-object-factory.h
    )

set(gallery_SRCS
    gallery-application.cpp
    gallery-manager.cpp
    main.cpp
    media-object-factory.cpp
    )

add_executable(${GALLERY}
    ${gallery_SRCS}
    )

target_link_libraries( ${GALLERY}
    gallery-album
    gallery-core
    gallery-database
    gallery-event
    gallery-media
    gallery-medialoader
    gallery-photo
    gallery-qml
    gallery-util
    gallery-video
    ${CONTENTHUB_LIBRARIES}
    Qt5::Core
    Qt5::DBus
    Qt5::Gui
    Qt5::Qml
    Qt5::Quick
    Qt5::Sql
    Qt5::Widgets
    )

install(TARGETS ${GALLERY} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

install(PROGRAMS lomiri-gallery-app-migrate.py DESTINATION "${GALLERY_DIR}/")
