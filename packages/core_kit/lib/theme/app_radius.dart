// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';

/// Consistent border radius values following Material Design 3 guidelines.
class AppRadius {
  const AppRadius._();

  /// No radius: 0dp
  static const double none = 0.0;

  /// Extra small radius: 4dp
  static const double xs = 4.0;

  /// Small radius: 8dp
  static const double sm = 8.0;

  /// Medium radius: 12dp
  static const double md = 12.0;

  /// Large radius: 16dp
  static const double lg = 16.0;

  /// Extra large radius: 28dp
  static const double xl = 28.0;

  /// Full/circle radius: 9999dp
  static const double full = 9999.0;

  // BorderRadius convenience methods
  static const BorderRadius noneRadius = BorderRadius.zero;
  static const BorderRadius xsRadius = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlRadius = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullRadius = BorderRadius.all(
    Radius.circular(full),
  );
}
