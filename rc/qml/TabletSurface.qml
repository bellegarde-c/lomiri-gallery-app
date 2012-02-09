/*
 * Copyright (C) 2011 Canonical Ltd
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 * Jim Nelson <jim@yorba.org>
 * Lucas Beeler <lucas@yorba.org>
 */

import QtQuick 1.0
import Gallery 1.0

Rectangle {
  id: tablet_surface
  objectName: "tablet_surface"
  
  width: 1280
  height: 776
  color: "white"
  
  Overview {
    id: overview
    objectName: "overview"
    
    x: 0
    y: 0
    width: parent.width
    height: parent.height
    
    visible: false
  }
  
  AlbumViewer {
    id: albumViewer
    objectName: "albumViewer"
    
    x: 0
    y: 0
    width: parent.width
    height: parent.height
    
    visible: false

    onCloseRequested: {
      if (state == "gridView") {
        albumViewerTransition.dissolveFromAlbumViewer(albumViewer, navStack.previous());
      } else {
        navStack.goBack();
        var thumbnailRect = overview.getRectOfAlbumPreview(album, albumViewer);
        if (thumbnailRect)
          albumViewerTransition.transitionFromAlbumViewer(album, thumbnailRect);
      }
    }
  }

  AlbumViewerTransition {
    id: albumViewerTransition

    x: 0
    y: 0
    width: parent.width
    height: parent.height

    toolbarHeight: albumViewer.mastheadHeight

    onTransitionToAlbumViewerCompleted: {
      albumViewer.resetView();
      navStack.switchToPage(albumViewer);
    }

    onDissolveFromAlbumViewerCompleted: {
      navStack.goBack();
    }
  }
  
  MediaSelector {
    id: mediaSelector
    objectName: "mediaSelector"
    
    x: 0
    y: 0
    width: parent.width
    height: parent.height
    
    visible: false
  }
  
  NavStack {
    id: navStack
    objectName: "navStack"
  
    function switchToAlbumViewer(album, thumbnailRect) {
      albumViewer.album = album;
      
      albumViewerTransition.transitionToAlbumViewer(album, thumbnailRect);
    }
    
    function switchToMediaSelector(album) {
      mediaSelector.album = album;
      
      navStack.switchToPage(mediaSelector);
    }
  }

  Component.onCompleted: {
    navStack.switchToPage(overview);
  }
}
