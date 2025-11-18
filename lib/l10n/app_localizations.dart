import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Generator App'**
  String get appTitle;

  /// No description provided for @navGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get navGenerate;

  /// No description provided for @navSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get navSaved;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your password manager'**
  String get settingsSubtitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurity;

  /// No description provided for @settingsPasswordGeneration.
  ///
  /// In en, this message translates to:
  /// **'Password Generation'**
  String get settingsPasswordGeneration;

  /// No description provided for @settingsDataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get settingsDataManagement;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @selectPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get selectPreferredLanguage;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @switchToDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark theme'**
  String get switchToDarkTheme;

  /// No description provided for @switchToLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Switch to light theme'**
  String get switchToLightTheme;

  /// No description provided for @requireFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Require Fingerprint'**
  String get requireFingerprint;

  /// No description provided for @fingerprintDescription.
  ///
  /// In en, this message translates to:
  /// **'Ask for fingerprint authentication on launch'**
  String get fingerprintDescription;

  /// No description provided for @charTypeInstructions.
  ///
  /// In en, this message translates to:
  /// **'Choose which character types to include'**
  String get charTypeInstructions;

  /// No description provided for @uppercase.
  ///
  /// In en, this message translates to:
  /// **'Uppercase Letters (A-Z)'**
  String get uppercase;

  /// No description provided for @lowercase.
  ///
  /// In en, this message translates to:
  /// **'Lowercase Letters (a-z)'**
  String get lowercase;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers (0-9)'**
  String get numbers;

  /// No description provided for @symbols.
  ///
  /// In en, this message translates to:
  /// **'Symbols (@#\$%...)'**
  String get symbols;

  /// No description provided for @deleteAllPasswordsHeader.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete all saved passwords'**
  String get deleteAllPasswordsHeader;

  /// No description provided for @deleteAllPasswords.
  ///
  /// In en, this message translates to:
  /// **'Delete All Passwords'**
  String get deleteAllPasswords;

  /// No description provided for @deleteAllPasswordsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete All Passwords?'**
  String get deleteAllPasswordsDialogTitle;

  /// No description provided for @deleteAllPasswordsDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete {count} saved passwords.'**
  String deleteAllPasswordsDialogContent(Object count);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// No description provided for @noPasswordsToDelete.
  ///
  /// In en, this message translates to:
  /// **'No passwords to delete'**
  String get noPasswordsToDelete;

  /// No description provided for @allPasswordsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted every password!'**
  String get allPasswordsDeleted;

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'Auth Failed'**
  String get authFailed;

  /// No description provided for @atLeastOneOptionRequired.
  ///
  /// In en, this message translates to:
  /// **'At least one option required'**
  String get atLeastOneOptionRequired;

  /// No description provided for @addNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Add New Password'**
  String get addNewPassword;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @enterNickname.
  ///
  /// In en, this message translates to:
  /// **'Enter a nickname for this password'**
  String get enterNickname;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the password'**
  String get enterPassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordSaved.
  ///
  /// In en, this message translates to:
  /// **'Password saved!'**
  String get passwordSaved;

  /// No description provided for @passwordSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save password'**
  String get passwordSaveFailed;

  /// No description provided for @savedPasswordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Passwords'**
  String get savedPasswordsTitle;

  /// No description provided for @savedPasswordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage your saved passwords'**
  String get savedPasswordsSubtitle;

  /// No description provided for @noSavedPasswords.
  ///
  /// In en, this message translates to:
  /// **'No saved passwords yet'**
  String get noSavedPasswords;

  /// No description provided for @generateOrAddPasswords.
  ///
  /// In en, this message translates to:
  /// **'Generate or add passwords to see them here'**
  String get generateOrAddPasswords;

  /// No description provided for @sortLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get sortLatest;

  /// No description provided for @sortLatestFirst.
  ///
  /// In en, this message translates to:
  /// **'Latest First'**
  String get sortLatestFirst;

  /// No description provided for @sortOldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get sortOldest;

  /// No description provided for @sortOldestFirst.
  ///
  /// In en, this message translates to:
  /// **'Oldest First'**
  String get sortOldestFirst;

  /// No description provided for @sortByPassword.
  ///
  /// In en, this message translates to:
  /// **'By Password'**
  String get sortByPassword;

  /// No description provided for @sortByPasswordAZ.
  ///
  /// In en, this message translates to:
  /// **'By Password (A-Z)'**
  String get sortByPasswordAZ;

  /// No description provided for @sortByNickname.
  ///
  /// In en, this message translates to:
  /// **'By Nickname'**
  String get sortByNickname;

  /// No description provided for @sortByNicknameAZ.
  ///
  /// In en, this message translates to:
  /// **'By Nickname (A-Z)'**
  String get sortByNicknameAZ;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @passwordCopied.
  ///
  /// In en, this message translates to:
  /// **'Password Copied!'**
  String get passwordCopied;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to Favorites!'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from Favorites!'**
  String get removedFromFavorites;

  /// No description provided for @deletePassword.
  ///
  /// In en, this message translates to:
  /// **'Delete Password'**
  String get deletePassword;

  /// No description provided for @confirmDeletePassword.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this password?'**
  String get confirmDeletePassword;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @passwordDeleted.
  ///
  /// In en, this message translates to:
  /// **'Password Deleted!'**
  String get passwordDeleted;

  /// No description provided for @length.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get length;

  /// No description provided for @editingPassword.
  ///
  /// In en, this message translates to:
  /// **'Editing password...'**
  String get editingPassword;

  /// No description provided for @tapToEditPassword.
  ///
  /// In en, this message translates to:
  /// **'Tap to edit password'**
  String get tapToEditPassword;

  /// No description provided for @generatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Generator'**
  String get generatorTitle;

  /// No description provided for @generatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create strong and secure passwords'**
  String get generatorSubtitle;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password Length'**
  String get passwordLength;

  /// No description provided for @generatePassword.
  ///
  /// In en, this message translates to:
  /// **'Generate Password'**
  String get generatePassword;

  /// No description provided for @generatedPassword.
  ///
  /// In en, this message translates to:
  /// **'Generated Password'**
  String get generatedPassword;

  /// No description provided for @nicknameOptional.
  ///
  /// In en, this message translates to:
  /// **'Nickname (optional)'**
  String get nicknameOptional;

  /// No description provided for @enterANickname.
  ///
  /// In en, this message translates to:
  /// **'Enter a nickname'**
  String get enterANickname;

  /// No description provided for @giveNicknameMeaning.
  ///
  /// In en, this message translates to:
  /// **'Give this password a memorable name'**
  String get giveNicknameMeaning;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
