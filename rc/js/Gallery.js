/*
 * Copyright (C) 2012 Canonical Ltd
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

var EVENT_TIMELINE_MEDIA_SOURCE_OPACITY = 0.8;
var EVENT_TIMELINE_EVENT_CARD_OPACITY = 1.0;

function getDeviceSpecific(key, form_factor, is_portrait) {
  var specifics = {
    'default': {
      photoThumbnailWidth: gu(24),
      photoThumbnailHeight: gu(18),
      photoThumbnailWidthTimeline: gu(24),
      photoThumbnailHeightTimeline: gu(18),

      photoGridTopMargin: gu(2),
      photoGridLeftMargin: gu(2),
      photoGridRightMargin: gu(2),
      photoGridTopMarginPortrait: gu(2),
      photoGridLeftMarginPortrait: gu(2),
      photoGridRightMarginPortrait: gu(2),

      photoGridGutterWidth: gu(2),
      photoGridGutterHeight: gu(2),
      photoGridGutterWidthPortrait: gu(2),
      photoGridGutterHeightPortrait: gu(2),

      albumThumbnailWidth: gu(28),
      albumThumbnailHeight: gu(33),
    },

    phone: {
      photoThumbnailWidth: gu(17),
      photoThumbnailHeight: gu(13),
      photoThumbnailWidthTimeline: gu(13),
      photoThumbnailHeightTimeline: gu(10),

      photoGridTopMargin: gu(2),
      photoGridLeftMargin: gu(4),
      photoGridRightMargin: gu(4),
      photoGridTopMarginPortrait: gu(1),
      photoGridLeftMarginPortrait: gu(1),
      photoGridRightMarginPortrait: gu(1),

      photoGridGutterWidth: gu(4),
      photoGridGutterHeight: gu(4),
      photoGridGutterWidthPortrait: gu(2),
      photoGridGutterHeightPortrait: gu(2),

      albumThumbnailWidth: gu(17),
      albumThumbnailHeight: gu(20),
    },
  };

  if (is_portrait === undefined)
    is_portrait = isPortrait; // From GalleryApplication.

  if (!form_factor)
    form_factor = FORM_FACTOR; // From C++.
  if (specifics[form_factor] === undefined)
    form_factor = 'default';

  var portrait_key = key + 'Portrait';
  if (is_portrait && specifics[form_factor][portrait_key] !== undefined)
    return specifics[form_factor][portrait_key];
  if (is_portrait && specifics['default'][portrait_key] !== undefined)
    return specifics['default'][portrait_key];

  if (specifics[form_factor][key] !== undefined)
    return specifics[form_factor][key];
  if (specifics['default'][key] !== undefined)
    return specifics['default'][key];

  console.debug("Invalid key '" + key + "' passed to Gallery.getDeviceSpecific()");
  return undefined;
}
