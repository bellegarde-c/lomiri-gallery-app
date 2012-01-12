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

#ifndef GALLERY_QML_PHOTO_VIEWER_PAGE_H_
#define GALLERY_QML_PHOTO_VIEWER_PAGE_H_

#include <QObject>
#include <QDeclarativeView>

#include "album/album.h"
#include "photo/photo.h"
#include "core/selectable-view-collection.h"
#include "qml/qml-album-collection-model.h"
#include "qml/qml-media-collection-model.h"
#include "qml/qml-page.h"

class QmlPhotoViewerPage : public QmlPage {
  Q_OBJECT
  
 signals:
  void exit_viewer();
  
 public:
  QmlPhotoViewerPage(QDeclarativeView* view);
  
  // returned path is a relative path, not an absolute one
  virtual const char* qml_rc() const;
  
  virtual void PrepareContext();
  virtual void PageLoaded();
  void PrepareToEnter(QmlMediaCollectionModel* model, Photo* start);
  
 private slots:
  void on_popup_album_picked(int album_number);
  void on_new_album_requested();
  
 private:
  SelectableViewCollection album_view_collection;
  QmlAlbumCollectionModel album_picker_model_;
  QmlMediaCollectionModel* media_collection_model_;
};

#endif  // GALLERY_QML_PHOTO_VIEWER_PAGE_H_
