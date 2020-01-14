/*
 * Copyright (C) 2013-2015 Canonical Ltd
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
 */

import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import "../../js/Gallery.js" as Gallery

/*!
  Dialog specialiced for the question to delete
  */
Dialog {
    id: dialogue
    objectName: "deleteDialog"

    /// Emitted if delete should be performed
    signal deleteClicked()

    title: i18n.tr("Delete")

    Button {
        objectName: "deleteDialogYes"
        text: i18n.tr("Delete")
        color: theme.palette.normal.negative
        onClicked: {
            dialogue.deleteClicked()
            PopupUtils.close(dialogue);
        }
    }
    Button {
        objectName: "deleteDialogNo"
        text: i18n.tr("Cancel")
        onClicked: PopupUtils.close(dialogue);
    }
}
