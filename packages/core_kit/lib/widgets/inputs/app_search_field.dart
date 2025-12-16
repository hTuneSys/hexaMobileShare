// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:async';

import 'package:flutter/material.dart';

/// A Material Design 3 search field with debounced input and search-specific features.
///
/// AppSearchField extends the standard text field with search-optimized functionality:
/// - Debounced input to reduce unnecessary API calls
/// - Clear button that appears when text is entered
/// - Search icon prefix for visual clarity
/// - Loading indicator support for async operations
/// - Configurable debounce delay (default 300ms)
///
/// Example:
/// ```dart
/// AppSearchField(
///   hint: 'Search products...',
///   onSearchChanged: (query) {
///     // Triggered after debounce delay
///     performSearch(query);
///   },
///   onSearchSubmitted: (query) {
///     // Triggered immediately on submit
///     executeSearch(query);
///   },
/// )
/// ```
class AppSearchField extends StatefulWidget {
  /// Controller for the search field
  final TextEditingController? controller;

  /// Hint text displayed when field is empty
  final String? hint;

  /// Callback triggered after debounce delay when text changes
  final ValueChanged<String>? onSearchChanged;

  /// Callback triggered immediately when search is submitted
  final ValueChanged<String>? onSearchSubmitted;

  /// Whether to show loading indicator
  final bool isLoading;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether to auto-focus on mount
  final bool autofocus;

  /// Debounce delay in milliseconds (default 300ms)
  final int debounceDelay;

  /// Whether to clear field on submit
  final bool clearOnSubmit;

  /// Creates an AppSearchField
  const AppSearchField({
    this.controller,
    this.hint,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.isLoading = false,
    this.enabled = true,
    this.autofocus = false,
    this.debounceDelay = 300,
    this.clearOnSubmit = false,
    super.key,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late TextEditingController _controller;
  Timer? _debounceTimer;
  bool _isControllerInternal = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isControllerInternal = widget.controller == null;
  }

  @override
  void didUpdateWidget(AppSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (_isControllerInternal) {
        _controller.dispose();
      }
      _controller = widget.controller ?? TextEditingController();
      _isControllerInternal = widget.controller == null;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (_isControllerInternal) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new debounce timer
    _debounceTimer = Timer(Duration(milliseconds: widget.debounceDelay), () {
      if (widget.onSearchChanged != null) {
        widget.onSearchChanged!(query);
      }
    });

    // Trigger setState to show/hide clear button
    setState(() {});
  }

  void _onSubmitted(String query) {
    // Cancel debounce timer on submit
    _debounceTimer?.cancel();

    // Immediately trigger submit callback
    if (widget.onSearchSubmitted != null) {
      widget.onSearchSubmitted!(query);
    }

    // Clear field if configured
    if (widget.clearOnSubmit) {
      _controller.clear();
      setState(() {});
    }
  }

  void _onClearTapped() {
    _controller.clear();
    _debounceTimer?.cancel();

    // Notify listeners about empty query
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!('');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: _onTextChanged,
      onSubmitted: _onSubmitted,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: widget.hint ?? 'Search...',
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
        ),
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        suffixIcon: _buildSuffixIcon(),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.12),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    final colorScheme = Theme.of(context).colorScheme;

    // Show loading indicator if loading
    if (widget.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colorScheme.primary,
          ),
        ),
      );
    }

    // Show clear button if text is not empty
    if (_controller.text.isNotEmpty) {
      return IconButton(
        icon: Icon(Icons.clear, color: colorScheme.onSurfaceVariant),
        onPressed: widget.enabled ? _onClearTapped : null,
        tooltip: 'Clear search',
      );
    }

    // No suffix icon
    return null;
  }
}
