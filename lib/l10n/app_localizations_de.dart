// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Passwort-Generator App';

  @override
  String get authenticateButton => 'Authentifizieren';

  @override
  String get navGenerate => 'Erstellen';

  @override
  String get navSaved => 'Gespeichert';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSubtitle => 'Passen Sie Ihren Passwortmanager an';

  @override
  String get settingsAppearance => 'Aussehen';

  @override
  String get settingsSecurity => 'Sicherheit';

  @override
  String get settingsPasswordGeneration => 'Passworterstellung';

  @override
  String get settingsDataManagement => 'Datenverwaltung';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get selectPreferredLanguage => 'Wählen Sie Ihre bevorzugte Sprache';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get switchToDarkTheme => 'Zum dunklen Thema wechseln';

  @override
  String get switchToLightTheme => 'Zum hellen Thema wechseln';

  @override
  String get requireFingerprint => 'Fingerabdruck erforderlich';

  @override
  String get fingerprintDescription => 'Beim Öffnen der App Fingerabdrucküberprüfung verlangen';

  @override
  String get charTypeInstructions => 'Wählen Sie die zu verwendenden Zeichenarten';

  @override
  String get uppercase => 'Großbuchstaben (A-Z)';

  @override
  String get lowercase => 'Kleinbuchstaben (a-z)';

  @override
  String get numbers => 'Zahlen (0-9)';

  @override
  String get symbols => 'Symbole (@#\$%...)';

  @override
  String get deleteAllPasswordsHeader => 'Alle gespeicherten Passwörter dauerhaft löschen';

  @override
  String get deleteAllPasswords => 'Alle Passwörter löschen';

  @override
  String get deleteAllPasswordsDialogTitle => 'Alle Passwörter löschen?';

  @override
  String deleteAllPasswordsDialogContent(Object count) {
    return '$count gespeicherte Passwörter werden dauerhaft gelöscht.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get deleteAll => 'Alles löschen';

  @override
  String get noPasswordsToDelete => 'Keine Passwörter zum Löschen vorhanden';

  @override
  String get allPasswordsDeleted => 'Alle Passwörter wurden gelöscht!';

  @override
  String get authFailed => 'Authentifizierung fehlgeschlagen';

  @override
  String get atLeastOneOptionRequired => 'Mindestens eine Option erforderlich';

  @override
  String get addNewPassword => 'Neues Passwort hinzufügen';

  @override
  String get nickname => 'Bezeichnung';

  @override
  String get enterNickname => 'Geben Sie eine Bezeichnung für dieses Passwort ein';

  @override
  String get password => 'Passwort';

  @override
  String get enterPassword => 'Geben Sie das Passwort ein';

  @override
  String get save => 'Speichern';

  @override
  String get pleaseEnterPassword => 'Bitte geben Sie ein Passwort ein';

  @override
  String get passwordSaved => 'Passwort gespeichert!';

  @override
  String get passwordSaveFailed => 'Passwort konnte nicht gespeichert werden';

  @override
  String get savedPasswordsTitle => 'Gespeicherte Passwörter';

  @override
  String get savedPasswordsSubtitle => 'Anzeigen und verwalten Sie Ihre gespeicherten Passwörter';

  @override
  String get noSavedPasswords => 'Noch keine gespeicherten Passwörter';

  @override
  String get generateOrAddPasswords => 'Erstellen oder hinzufügen, um Passwörter anzuzeigen';

  @override
  String get sortLatest => 'Neueste';

  @override
  String get sortLatestFirst => 'Neueste zuerst';

  @override
  String get sortOldest => 'Älteste';

  @override
  String get sortOldestFirst => 'Älteste zuerst';

  @override
  String get sortByPassword => 'Nach Passwort';

  @override
  String get sortByPasswordAZ => 'Passwort (A-Z)';

  @override
  String get sortByNickname => 'Nach Bezeichnung';

  @override
  String get sortByNicknameAZ => 'Bezeichnung (A-Z)';

  @override
  String get copy => 'Kopieren';

  @override
  String get passwordCopied => 'Passwort kopiert!';

  @override
  String get addedToFavorites => 'Zu Favoriten hinzugefügt!';

  @override
  String get removedFromFavorites => 'Aus Favoriten entfernt!';

  @override
  String get deletePassword => 'Passwort löschen';

  @override
  String get confirmDeletePassword => 'Sind Sie sicher, dass Sie dieses Passwort löschen möchten?';

  @override
  String get delete => 'Löschen';

  @override
  String get passwordDeleted => 'Passwort gelöscht!';

  @override
  String get length => 'Länge';

  @override
  String get editingPassword => 'Passwort wird bearbeitet...';

  @override
  String get tapToEditPassword => 'Zum Bearbeiten tippen';

  @override
  String get generatorTitle => 'Passwort-Generator';

  @override
  String get generatorSubtitle => 'Starke und sichere Passwörter erstellen';

  @override
  String get passwordLength => 'Password-Länge';

  @override
  String get generatePassword => 'Passwort erstellen';

  @override
  String get generatedPassword => 'Erstelltes Passwort';

  @override
  String get nicknameOptional => 'Bezeichnung (optional)';

  @override
  String get enterANickname => 'Geben Sie eine Bezeichnung ein';

  @override
  String get giveNicknameMeaning => 'Geben Sie diesem Passwort einen einprägsamen Namen';
}
