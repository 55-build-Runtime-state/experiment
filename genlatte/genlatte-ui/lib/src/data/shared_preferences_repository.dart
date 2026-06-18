// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for local settings. Backed by [SharedPreferences]
/// and not mirrored on server.
class SharedPreferencesRepository {
  /// Creates a shared preferences repository.
  const SharedPreferencesRepository(this._prefs);

  static final Logger _logger = Logger('$SharedPreferencesRepository');

  final SharedPreferences _prefs;

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String? getString(String key) => _prefs.getString(key);

  /// Saves a string [value] to persistent storage in the background.
  Future<void> setString(String key, String value) {
    _logger.fine(
      'Setting $key to "${value.substring(0, min(200, value.length))}"',
    );
    return _prefs.setString(key, value);
  }
}
