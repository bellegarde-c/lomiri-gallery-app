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
 */

#ifndef GALLERY_MEDIA_COLLECTION_H_
#define GALLERY_MEDIA_COLLECTION_H_

#include <QObject>
#include <QDir>
#include <QMap>
#include <QSet>

#include "core/data-object.h"
#include "core/source-collection.h"
#include "media-source.h"
#include "photo/photo.h"

class Photo;

class MediaCollection : public SourceCollection {
  Q_OBJECT
  
public:
  MediaCollection(const QDir& directory);
  
  static bool ExposureDateTimeAscendingComparator(DataObject* a, DataObject* b);
  static bool ExposureDateTimeDescendingComparator(DataObject* a, DataObject* b);
  
  const QDir& directory() const;
  
  // Returns a media object for a row id.
  MediaSource* mediaForId(qint64 id);

  // Returns an existing photo object if we've already loaded one
  // for this file, or NULL otherwise. Used for preventing duplicates
  // from appearing after an edit.
  Photo* photoFromFileinfo(QFileInfo file_to_load);
  
protected slots:
  virtual void notify_contents_altered(const QSet<DataObject*>* added,
    const QSet<DataObject*>* removed);
  
private:
  // Used by photoFromFileinfo() to prevent ourselves from accidentally
  // seeing a duplicate photo after an edit.
  QHash<QString, Photo*> file_photo_map_;

  QDir directory_;
  QHash<qint64, DataObject*> id_map_;
};

#endif  // GALLERY_MEDIA_COLLECTION_H_
