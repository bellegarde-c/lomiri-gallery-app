# -*- Mode: Python; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
# Copyright 2012 Canonical
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 3, as published
# by the Free Software Foundation.


"""Tests the Photos view of the gallery app."""

from __future__ import absolute_import

from testtools.matchers import Equals, GreaterThan, Is
from autopilot.matchers import Eventually

from gallery_app.tests import GalleryTestCase
from gallery_app.emulators.photos_view import PhotosView

from os.path import exists


class TestPhotosView(GalleryTestCase):

    @property
    def photos_view(self):
        return PhotosView(self.app)

    def setUp(self):
        self.ARGS = []
        super(TestPhotosView, self).setUp()
        self.switch_to_photos_tab()

    def switch_to_photos_tab(self):
        tabs_bar = self.photos_view.get_tabs_bar()
        self.click_item(tabs_bar)

        photos_tab_button = self.photos_view.get_photos_tab_button()
        # Due to some timing issues sometimes mouse moves to the location a bit
        # earlier even though the tab item is not fully visible, hence the tab
        # does not activate.
        self.assertThat(photos_tab_button.opacity,
                        Eventually(GreaterThan(0.2)))
        self.click_item(photos_tab_button)

        self.ensure_tabs_dont_move()

    def click_first_photo(self):
        photo = self.photos_view.get_first_photo_in_photos_view()
        self.click_item(photo)

    def test_open_photo(self):
        self.click_first_photo()
        photo_viewer = self.photos_view.get_main_photo_viewer()
        self.assertThat(photo_viewer.visible, Eventually(Equals(True)))

    def test_select_button_cancel(self):
        """Clicking the cancel button after clicking the select button must
        hide the toolbar automatically."""
        self.main_view.open_toolbar().click_button("selectButton")

        self.main_view.open_toolbar().click_custom_button("cancelButton")

        toolbar = self.main_view.get_toolbar()
        self.assertThat(toolbar.active, Eventually(Equals(False)))

    def test_delete_a_photo(self):
        """Selecting a photo must make the delete button clickable."""
        number_of_photos = self.photos_view.number_of_photos()
        self.main_view.open_toolbar().click_button("selectButton")
        self.click_first_photo()
        self.main_view.open_toolbar().click_button("deleteButton")

        cancel_item = self.photos_view.get_delete_dialog_cancel_button()
        self.click_item(cancel_item)
        self.assertThat(lambda: self.gallery_utils.get_delete_dialog(),
                        Eventually(Is(None)))

        self.assertThat(lambda: exists(self.sample_file),
                        Eventually(Equals(True)))

        new_number_of_photos = self.photos_view.number_of_photos()
        self.assertThat(new_number_of_photos, Equals(number_of_photos))

        self.main_view.open_toolbar().click_button("deleteButton")

        delete_item = self.photos_view.get_delete_dialog_delete_button()
        self.click_item(delete_item)

        self.assertThat(lambda: exists(self.sample_file),
                        Eventually(Equals(False)))

        self.ui_update()
        new_number_of_photos = self.photos_view.number_of_photos()
        self.assertThat(new_number_of_photos, Equals(number_of_photos - 1))
