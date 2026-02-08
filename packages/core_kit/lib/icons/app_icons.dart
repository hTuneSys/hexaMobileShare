// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A comprehensive collection of semantic icon constants for the hexaMobileShare app.
///
/// This class provides meaningful, typed access to Material Design icons used
/// throughout the application. Using semantic names improves code readability
/// and maintainability by revealing intent rather than just icon appearance.
///
/// All icons use Material Design outlined variants by default for consistency
/// with Material Design 3 guidelines.
///
/// ## Benefits:
/// - **Semantic Names**: Use `AppIcons.home` instead of `Icons.home_outlined`
/// - **Code Readability**: Intent-revealing names improve understanding
/// - **Consistency**: Ensures same icon for same purposes across the app
/// - **Refactoring Safety**: Change icon in one place, updates everywhere
/// - **IDE Support**: Auto-complete suggests available app icons
/// - **Type Safety**: Compile-time checking of icon usage
///
/// ## Usage:
/// ```dart
/// Icon(AppIcons.home)
/// IconButton(icon: Icon(AppIcons.search), onPressed: () {})
/// AppButton(icon: AppIcons.add, label: 'Add Item')
/// ```
class AppIcons {
  const AppIcons._();

  // ============================================================================
  // NAVIGATION ICONS (10-15)
  // Common navigation and wayfinding icons
  // ============================================================================

  /// Home/main screen navigation icon
  ///
  /// Usage: Bottom navigation, drawer menu, home button
  static const IconData home = Icons.home_outlined;

  /// Search/find functionality icon
  ///
  /// Usage: Search bars, search buttons, find features
  static const IconData search = Icons.search;

  /// Menu/hamburger icon for navigation drawer
  ///
  /// Usage: App bar menu button, drawer toggle
  static const IconData menu = Icons.menu;

  /// Back/return navigation icon
  ///
  /// Usage: App bar back button, navigation back
  static const IconData back = Icons.arrow_back;

  /// Close/dismiss icon
  ///
  /// Usage: Dialog close, modal dismiss, remove overlay
  static const IconData close = Icons.close;

  /// Navigate to next item/page icon
  ///
  /// Usage: Carousel next, pagination, forward navigation
  static const IconData navigateNext = Icons.navigate_next;

  /// Navigate to previous item/page icon
  ///
  /// Usage: Carousel previous, pagination, back navigation
  static const IconData navigateBefore = Icons.navigate_before;

  /// Forward arrow for directional navigation
  ///
  /// Usage: "Go to" actions, link arrows, forward navigation
  static const IconData arrowForward = Icons.arrow_forward;

  /// Back arrow for directional navigation
  ///
  /// Usage: "Return to" actions, back navigation
  static const IconData arrowBack = Icons.arrow_back;

  /// Refresh/reload icon
  ///
  /// Usage: Pull to refresh, reload content, retry actions
  static const IconData refresh = Icons.refresh;

  /// More options (vertical) icon
  ///
  /// Usage: Overflow menu, more options button
  static const IconData moreVert = Icons.more_vert;

  /// More options (horizontal) icon
  ///
  /// Usage: Horizontal overflow menu, additional options
  static const IconData moreHoriz = Icons.more_horiz;

  // ============================================================================
  // ACTION ICONS (15-20)
  // User actions and commands
  // ============================================================================

  /// Add/create new item icon
  ///
  /// Usage: Add buttons, create new, plus actions
  static const IconData add = Icons.add;

  /// Edit/modify icon
  ///
  /// Usage: Edit buttons, modify content, update actions
  static const IconData edit = Icons.edit_outlined;

  /// Delete/remove icon
  ///
  /// Usage: Delete buttons, remove items, trash actions
  static const IconData delete = Icons.delete_outline;

  /// Share content icon
  ///
  /// Usage: Share buttons, social sharing, send to others
  static const IconData share = Icons.share_outlined;

  /// Favorite/like icon (unfilled)
  ///
  /// Usage: Like buttons, favorite toggles, wishlist
  static const IconData favorite = Icons.favorite_outline;

  /// Favorited/liked icon (filled)
  ///
  /// Usage: Active favorite state, liked items
  static const IconData favorited = Icons.favorite;

  /// Download from cloud/server icon
  ///
  /// Usage: Download buttons, save locally, fetch content
  static const IconData download = Icons.download_outlined;

  /// Upload to cloud/server icon
  ///
  /// Usage: Upload buttons, send files, cloud sync
  static const IconData upload = Icons.upload_outlined;

  /// Save changes icon
  ///
  /// Usage: Save buttons, persist changes, bookmark
  static const IconData save = Icons.save_outlined;

  /// Copy to clipboard icon
  ///
  /// Usage: Copy buttons, duplicate content, clipboard actions
  static const IconData copy = Icons.content_copy;

  /// Cut to clipboard icon
  ///
  /// Usage: Cut buttons, move content, clipboard actions
  static const IconData cut = Icons.content_cut;

  /// Paste from clipboard icon
  ///
  /// Usage: Paste buttons, insert content, clipboard actions
  static const IconData paste = Icons.content_paste;

  /// Undo last action icon
  ///
  /// Usage: Undo buttons, revert changes
  static const IconData undo = Icons.undo;

  /// Redo last undone action icon
  ///
  /// Usage: Redo buttons, reapply changes
  static const IconData redo = Icons.redo;

  /// Print document icon
  ///
  /// Usage: Print buttons, generate PDF
  static const IconData print = Icons.print_outlined;

  /// Attach file icon
  ///
  /// Usage: Attach files, add attachments
  static const IconData attach = Icons.attach_file;

  /// Create/copy link icon
  ///
  /// Usage: Link buttons, copy URL, create hyperlink
  static const IconData link = Icons.link;

  /// Send/submit icon
  ///
  /// Usage: Send buttons, submit forms, post content
  static const IconData send = Icons.send_outlined;

  // ============================================================================
  // STATUS ICONS (8-10)
  // Status indicators and feedback
  // ============================================================================

  /// Success/check/complete icon
  ///
  /// Usage: Success messages, completed tasks, confirmations
  static const IconData check = Icons.check;

  /// Error/critical issue icon
  ///
  /// Usage: Error messages, failed operations, critical alerts
  static const IconData error = Icons.error_outline;

  /// Warning/caution icon
  ///
  /// Usage: Warning messages, caution alerts, attention needed
  static const IconData warning = Icons.warning_amber;

  /// Information/help icon
  ///
  /// Usage: Info messages, tooltips, help dialogs
  static const IconData info = Icons.info_outline;

  /// Help/question icon
  ///
  /// Usage: Help buttons, FAQ, support
  static const IconData help = Icons.help_outline;

  /// Verified/certified icon
  ///
  /// Usage: Verified accounts, certified content, trusted sources
  static const IconData verified = Icons.verified_outlined;

  /// Pending/in-progress icon
  ///
  /// Usage: Pending status, processing, waiting
  static const IconData pending = Icons.pending_outlined;

  /// Blocked/prohibited icon
  ///
  /// Usage: Blocked users, prohibited actions, access denied
  static const IconData blocked = Icons.block;

  /// Success/done icon (filled circle)
  ///
  /// Usage: Completed steps, success status, done indicator
  static const IconData success = Icons.check_circle;

  // ============================================================================
  // CONTENT ICONS (10-12)
  // Content types and media
  // ============================================================================

  /// Image/photo icon
  ///
  /// Usage: Image placeholders, photo galleries, picture uploads
  static const IconData image = Icons.image_outlined;

  /// Video content icon
  ///
  /// Usage: Video players, video uploads, media libraries
  static const IconData video = Icons.videocam_outlined;

  /// Audio/music icon
  ///
  /// Usage: Audio players, music libraries, sound files
  static const IconData audio = Icons.audiotrack;

  /// Document/file icon
  ///
  /// Usage: Document viewers, file uploads, text files
  static const IconData document = Icons.description_outlined;

  /// Folder/directory icon
  ///
  /// Usage: Folder navigation, file organization, directories
  static const IconData folder = Icons.folder_outlined;

  /// Attachment/paperclip icon
  ///
  /// Usage: File attachments, linked documents
  static const IconData attachment = Icons.attachment;

  /// Code/programming icon
  ///
  /// Usage: Code editors, developer tools, technical content
  static const IconData code = Icons.code;

  /// Text/article icon
  ///
  /// Usage: Text content, articles, written documents
  static const IconData text = Icons.article_outlined;

  /// Generic file icon
  ///
  /// Usage: Unknown file types, generic files
  static const IconData file = Icons.insert_drive_file_outlined;

  /// Camera/take photo icon
  ///
  /// Usage: Camera features, take photo button
  static const IconData camera = Icons.camera_alt_outlined;

  /// Photo library icon
  ///
  /// Usage: Photo galleries, image collections
  static const IconData photo = Icons.photo_outlined;

  // ============================================================================
  // COMMUNICATION ICONS (8-10)
  // Communication and messaging
  // ============================================================================

  /// Email/mail icon
  ///
  /// Usage: Email features, send mail, mail inbox
  static const IconData email = Icons.email_outlined;

  /// Chat/messaging icon
  ///
  /// Usage: Chat features, messaging, conversations
  static const IconData chat = Icons.chat_outlined;

  /// Phone call icon
  ///
  /// Usage: Call buttons, phone features, contact
  static const IconData call = Icons.phone_outlined;

  /// Notifications/alerts icon
  ///
  /// Usage: Notification settings, alerts, push messages
  static const IconData notifications = Icons.notifications_outlined;

  /// Inbox/received messages icon
  ///
  /// Usage: Inbox view, received items, incoming
  static const IconData inbox = Icons.inbox_outlined;

  /// Archive/storage icon
  ///
  /// Usage: Archive actions, stored items, history
  static const IconData archive = Icons.archive_outlined;

  /// Mark as read icon
  ///
  /// Usage: Mark messages read, seen status
  static const IconData markAsRead = Icons.mark_email_read_outlined;

  /// Unread messages icon
  ///
  /// Usage: Unread count, new messages indicator
  static const IconData unread = Icons.mark_email_unread_outlined;

  // ============================================================================
  // UI CONTROL ICONS (8-10)
  // Interface controls and toggles
  // ============================================================================

  /// Expand/show more icon (down chevron)
  ///
  /// Usage: Dropdown menus, expand sections, show more
  static const IconData expandMore = Icons.expand_more;

  /// Collapse/show less icon (up chevron)
  ///
  /// Usage: Collapse sections, show less, minimize
  static const IconData expandLess = Icons.expand_less;

  /// Filter/refine icon
  ///
  /// Usage: Filter controls, refine results, search filters
  static const IconData filter = Icons.filter_list;

  /// Sort/order icon
  ///
  /// Usage: Sort controls, change order, organize
  static const IconData sort = Icons.sort;

  /// List view icon
  ///
  /// Usage: Switch to list view, list layout toggle
  static const IconData viewList = Icons.view_list;

  /// Grid view icon
  ///
  /// Usage: Switch to grid view, grid layout toggle
  static const IconData viewGrid = Icons.grid_view;

  /// Settings/preferences icon
  ///
  /// Usage: Settings pages, preferences, configuration
  static const IconData settings = Icons.settings_outlined;

  /// Visible/show icon
  ///
  /// Usage: Show password, visibility toggle, unhide
  static const IconData visibility = Icons.visibility_outlined;

  /// Hidden/hide icon
  ///
  /// Usage: Hide password, visibility toggle, conceal
  static const IconData visibilityOff = Icons.visibility_off_outlined;

  /// Adjust/tune icon
  ///
  /// Usage: Adjustment controls, fine-tune settings, customize
  static const IconData tune = Icons.tune;

  // ============================================================================
  // CATEGORICAL MAPPINGS (For Dynamic Discovery/Stories)
  // ============================================================================

  /// All icons grouped by their semantic category.
  static const Map<String, Map<String, IconData>> categoricalIcons = {
    'Navigation': {
      'home': home,
      'search': search,
      'menu': menu,
      'back': back,
      'close': close,
      'navigateNext': navigateNext,
      'navigateBefore': navigateBefore,
      'arrowForward': arrowForward,
      'arrowBack': arrowBack,
      'refresh': refresh,
      'moreVert': moreVert,
      'moreHoriz': moreHoriz,
    },
    'Actions': {
      'add': add,
      'edit': edit,
      'delete': delete,
      'share': share,
      'favorite': favorite,
      'favorited': favorited,
      'download': download,
      'upload': upload,
      'save': save,
      'copy': copy,
      'cut': cut,
      'paste': paste,
      'undo': undo,
      'redo': redo,
      'print': print,
      'attach': attach,
      'link': link,
      'send': send,
    },
    'Status': {
      'check': check,
      'error': error,
      'warning': warning,
      'info': info,
      'help': help,
      'verified': verified,
      'pending': pending,
      'blocked': blocked,
      'success': success,
    },
    'Content': {
      'image': image,
      'video': video,
      'audio': audio,
      'document': document,
      'folder': folder,
      'attachment': attachment,
      'code': code,
      'text': text,
      'file': file,
      'camera': camera,
      'photo': photo,
    },
    'Communication': {
      'email': email,
      'chat': chat,
      'call': call,
      'notifications': notifications,
      'inbox': inbox,
      'archive': archive,
      'markAsRead': markAsRead,
      'unread': unread,
    },
    'UI Controls': {
      'expandMore': expandMore,
      'expandLess': expandLess,
      'filter': filter,
      'sort': sort,
      'viewList': viewList,
      'viewGrid': viewGrid,
      'settings': settings,
      'visibility': visibility,
      'visibilityOff': visibilityOff,
      'tune': tune,
    },
  };

  /// A flat map of all icon names to their IconData.
  static final Map<String, IconData> allIcons = {
    for (final category in categoricalIcons.values) ...category,
  };
}

class AppIconSizes {
  const AppIconSizes._();

  // ===========================================================================
  // CORE ICON SIZES (MD3 Standard)
  // ===========================================================================

  /// Extra small icons for dense UIs: 16dp
  ///
  /// Usage: Inline text icons, very dense UIs, chips, status indicators
  static const double xs = 16.0;

  /// Small icons for compact components: 20dp
  ///
  /// Usage: Toast icons, small badges, compact buttons, chips
  static const double sm = 20.0;

  /// Standard MD3 icon size: 24dp
  ///
  /// Usage: Icon buttons, navigation bars, app bars, list tiles,
  /// text field icons, snackbars, FABs (small/default)
  /// Reference: This is the default size for most MD3 components
  static const double md = 24.0;

  /// Large icons for prominent actions: 32dp
  ///
  /// Usage: Large FAB icons, prominent action buttons, card icons
  static const double lg = 32.0;

  /// Extra large icons for state screens: 48dp
  ///
  /// Usage: Empty states, error states, loading states, onboarding
  static const double xl = 48.0;

  // ===========================================================================
  // SEMANTIC ALIASES (Context-Specific)
  // ===========================================================================

  /// Icon size for chips (16dp)
  static const double chip = xs;

  /// Icon size for toast notifications (20dp)
  static const double toast = sm;

  /// Icon size for navigation components (24dp)
  static const double navigation = md;

  /// Icon size for app bar actions (24dp)
  static const double appBar = md;

  /// Icon size for list tile leading icons (24dp)
  static const double listTile = md;

  /// Icon size for FAB default (24dp)
  static const double fab = md;

  /// Icon size for FAB large (32dp)
  static const double fabLarge = lg;

  /// Icon size for empty/error state illustrations (48dp)
  static const double stateIcon = xl;
}
