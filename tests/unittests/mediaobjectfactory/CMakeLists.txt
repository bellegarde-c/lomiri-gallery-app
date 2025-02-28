add_definitions(-DTEST_SUITE)

if(NOT CTEST_TESTING_TIMEOUT)
    set(CTEST_TESTING_TIMEOUT 60)
endif()

include_directories(
    ${CMAKE_BINARY_DIR}
    ${gallery_src_SOURCE_DIR}
    ${gallery_album_src_SOURCE_DIR}
    ${gallery_core_src_SOURCE_DIR}
    ${gallery_database_src_SOURCE_DIR}
    ${gallery_event_src_SOURCE_DIR}
    ${gallery_media_src_SOURCE_DIR}
    ${gallery_medialoader_src_SOURCE_DIR}
    ${gallery_photo_src_SOURCE_DIR}
    ${gallery_util_src_SOURCE_DIR}
    ${gallery_video_src_SOURCE_DIR}
    )

QT5_WRAP_CPP(MEDIAOBJECTFACTORY_MOCS
    ${gallery_database_src_SOURCE_DIR}/media-table.h
    ${gallery_photo_src_SOURCE_DIR}/photo-metadata.h
    ${gallery_medialoader_src_SOURCE_DIR}/video-metadata.h
    )

add_definitions(-DSAMPLE_DATA_DIR="${CMAKE_CURRENT_SOURCE_DIR}/data")
add_executable(mediaobjectfactory
    tst_mediaobjectfactory.cpp
    ${gallery_src_SOURCE_DIR}/media-object-factory.cpp
    ${gallery_photo_src_SOURCE_DIR}/photo.cpp
    ../stubs/media-table_stub.cpp
    ../stubs/video_stub.cpp
    ../stubs/photometa-data_stub.cpp
    ../stubs/video-metadata_stub.cpp
    ${MEDIAOBJECTFACTORY_MOCS}
    )

add_test(mediaobjectfactory mediaobjectfactory -xunitxml -o test_mediaobjectfactory.xml)
set_tests_properties(mediaobjectfactory PROPERTIES
    TIMEOUT ${CTEST_TESTING_TIMEOUT}
    ENVIRONMENT "QT_QPA_PLATFORM=minimal;TZ=Pacific/Auckland"
    )

target_link_libraries(mediaobjectfactory
    gallery-core
    gallery-media
    gallery-util
    gallery-video
    Qt5::Core
    Qt5::Qml
    Qt5::Quick
    Qt5::Test
    Qt5::Widgets
    )
