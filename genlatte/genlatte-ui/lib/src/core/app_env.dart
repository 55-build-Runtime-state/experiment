// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Represents the supported application environments.
enum AppEnv {
  /// Local development environment.
  dev,

  /// Shared staging environment.
  staging,

  /// Production environment.
  prod;

  /// Parses an [AppEnv] from a [String].
  static AppEnv fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'dev' => AppEnv.dev,
      'staging' => AppEnv.staging,
      'prod' => AppEnv.prod,
      _ => AppEnv.staging,
    };
  }

  /// Returns the current [AppEnv] based on the `APP_ENV` environment variable.
  static AppEnv get current {
    const value = String.fromEnvironment('APP_ENV');
    return fromString(value);
  }

  /// Whether the current environment is [AppEnv.dev].
  bool get isDev => this == AppEnv.dev;

  /// Whether the current environment is [AppEnv.staging].
  bool get isStaging => this == AppEnv.staging;

  /// Whether the current environment is [AppEnv.prod].
  bool get isProd => this == AppEnv.prod;
}
