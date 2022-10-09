/*
 * Copyright (C) 2011-2015 Canonical Ltd.
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
 * Charles Lindsay <chaz@yorba.org>
 */

import QtQuick 2.9

/*!
*/
AlbumPageLayout {
    id: albumPageLayoutLeftPortrait

    mediaFrames: [ left ]

    FramePortrait {
        id: left

        anchors.fill: parent

        anchors.topMargin: albumPageLayoutLeftPortrait.topMargin
        anchors.bottomMargin: albumPageLayoutLeftPortrait.bottomMargin
        anchors.leftMargin: albumPageLayoutLeftPortrait.outerMargin
        anchors.rightMargin: albumPageLayoutLeftPortrait.gutterMargin

        mediaSource: (albumPageLayoutLeftPortrait.mediaSourceList
                      ? albumPageLayoutLeftPortrait.mediaSourceList[0]
                      : null)
        load: albumPageLayoutLeftPortrait.load
        isPreview: albumPageLayoutLeftPortrait.isPreview
    }
}
