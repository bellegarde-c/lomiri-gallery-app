if(CLICK_MODE)
    set(GALLERY_RC_DIR rc)
else(CLICK_MODE)
    set(GALLERY_RC_DIR ${GALLERY_DIR}/rc)
endif(CLICK_MODE)

install(DIRECTORY img DESTINATION ${GALLERY_RC_DIR} FILES_MATCHING PATTERN *)
install(DIRECTORY js DESTINATION ${GALLERY_RC_DIR} FILES_MATCHING PATTERN *)
install(DIRECTORY qml DESTINATION ${GALLERY_RC_DIR} FILES_MATCHING PATTERN *)
install(DIRECTORY sql DESTINATION ${GALLERY_RC_DIR} FILES_MATCHING PATTERN *)
