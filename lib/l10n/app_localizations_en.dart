// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Password Generator App';

  @override
  String get navGenerate => 'Generate';

  @override
  String get navSaved => 'Saved';

  @override
  String get navSettings => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle => 'Customize your password manager';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsSecurity => 'Security';

  @override
  String get settingsPasswordGeneration => 'Password Generation';

  @override
  String get settingsDataManagement => 'Data Management';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get selectPreferredLanguage => 'Select your preferred language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get switchToDarkTheme => 'Switch to dark theme';

  @override
  String get switchToLightTheme => 'Switch to light theme';

  @override
  String get requireFingerprint => 'Require Fingerprint';

  @override
  String get fingerprintDescription => 'Ask for fingerprint authentication on launch';

  @override
  String get charTypeInstructions => 'Choose which character types to include';

  @override
  String get uppercase => 'Uppercase Letters (A-Z)';

  @override
  String get lowercase => 'Lowercase Letters (a-z)';

  @override
  String get numbers => 'Numbers (0-9)';

  @override
  String get symbols => 'Symbols (@#\$%...)';

  @override
  String get deleteAllPasswordsHeader => 'Permanently delete all saved passwords';

  @override
  String get deleteAllPasswords => 'Delete All Passwords';

  @override
  String get deleteAllPasswordsDialogTitle => 'Delete All Passwords?';

  @override
  String deleteAllPasswordsDialogContent(Object count) {
    return 'This will permanently delete $count saved passwords.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get noPasswordsToDelete => 'No passwords to delete';

  @override
  String get allPasswordsDeleted => 'Deleted every password!';

  @override
  String get authFailed => 'Auth Failed';

  @override
  String get atLeastOneOptionRequired => 'At least one option required';

  @override
  String get addNewPassword => 'Add New Password';

  @override
  String get nickname => 'Nickname';

  @override
  String get enterNickname => 'Enter a nickname for this password';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter the password';

  @override
  String get save => 'Save';

  @override
  String get pleaseEnterPassword => 'Please enter a password';

  @override
  String get passwordSaved => 'Password saved!';

  @override
  String get passwordSaveFailed => 'Failed to save password';

  @override
  String get savedPasswordsTitle => 'Saved Passwords';

  @override
  String get savedPasswordsSubtitle => 'View and manage your saved passwords';

  @override
  String get noSavedPasswords => 'No saved passwords yet';

  @override
  String get generateOrAddPasswords => 'Generate or add passwords to see them here';

  @override
  String get sortLatest => 'Latest';

  @override
  String get sortLatestFirst => 'Latest First';

  @override
  String get sortOldest => 'Oldest';

  @override
  String get sortOldestFirst => 'Oldest First';

  @override
  String get sortByPassword => 'By Password';

  @override
  String get sortByPasswordAZ => 'By Password (A-Z)';

  @override
  String get sortByNickname => 'By Nickname';

  @override
  String get sortByNicknameAZ => 'By Nickname (A-Z)';

  @override
  String get copy => 'Copy';

  @override
  String get passwordCopied => 'Password Copied!';

  @override
  String get addedToFavorites => 'Added to Favorites!';

  @override
  String get removedFromFavorites => 'Removed from Favorites!';

  @override
  String get deletePassword => 'Delete Password';

  @override
  String get confirmDeletePassword => 'Are you sure you want to delete this password?';

  @override
  String get delete => 'Delete';

  @override
  String get passwordDeleted => 'Password Deleted!';

  @override
  String get length => 'Length';

  @override
  String get editingPassword => 'Editing password...';

  @override
  String get tapToEditPassword => 'Tap to edit password';

  @override
  String get generatorTitle => 'Password Generator';

  @override
  String get generatorSubtitle => 'Create strong and secure passwords';

  @override
  String get passwordLength => 'Password Length';

  @override
  String get generatePassword => 'Generate Password';

  @override
  String get generatedPassword => 'Generated Password';

  @override
  String get nicknameOptional => 'Nickname (optional)';

  @override
  String get enterANickname => 'Enter a nickname';

  @override
  String get giveNicknameMeaning => 'Give this password a memorable name';
}
