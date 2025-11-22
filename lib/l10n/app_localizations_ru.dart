// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Приложение для создания паролей';

  @override
  String get authenticateButton => 'Аутентификация';

  @override
  String get navGenerate => 'Создать';

  @override
  String get navSaved => 'Сохранённые';

  @override
  String get navSettings => 'Настройки';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsSubtitle => 'Настройте свой менеджер паролей';

  @override
  String get settingsAppearance => 'Внешний вид';

  @override
  String get settingsSecurity => 'Безопасность';

  @override
  String get settingsPasswordGeneration => 'Генерация паролей';

  @override
  String get settingsDataManagement => 'Управление данными';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get selectPreferredLanguage => 'Выберите предпочитаемый язык';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get switchToDarkTheme => 'Переключиться на тёмную тему';

  @override
  String get switchToLightTheme => 'Переключиться на светлую тему';

  @override
  String get requireFingerprint => 'Требовать отпечаток пальца';

  @override
  String get fingerprintDescription => 'Запрашивать подтверждение отпечатком при запуске приложения';

  @override
  String get charTypeInstructions => 'Выберите типы символов';

  @override
  String get uppercase => 'Заглавные буквы (A-Z)';

  @override
  String get lowercase => 'Строчные буквы (a-z)';

  @override
  String get numbers => 'Цифры (0-9)';

  @override
  String get symbols => 'Символы (@#\$%...)';

  @override
  String get deleteAllPasswordsHeader => 'Удалить все сохранённые пароли навсегда';

  @override
  String get deleteAllPasswords => 'Удалить все пароли';

  @override
  String get deleteAllPasswordsDialogTitle => 'Удалить все пароли?';

  @override
  String deleteAllPasswordsDialogContent(Object count) {
    return '$count сохранённых паролей будет удалено навсегда.';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get deleteAll => 'Удалить всё';

  @override
  String get noPasswordsToDelete => 'Нет паролей для удаления';

  @override
  String get allPasswordsDeleted => 'Все пароли удалены!';

  @override
  String get authFailed => 'Ошибка аутентификации';

  @override
  String get atLeastOneOptionRequired => 'Требуется хотя бы один параметр';

  @override
  String get addNewPassword => 'Добавить новый пароль';

  @override
  String get nickname => 'Название';

  @override
  String get enterNickname => 'Введите название для этого пароля';

  @override
  String get password => 'Пароль';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get save => 'Сохранить';

  @override
  String get pleaseEnterPassword => 'Пожалуйста, введите пароль';

  @override
  String get passwordSaved => 'Пароль сохранён!';

  @override
  String get passwordSaveFailed => 'Не удалось сохранить пароль';

  @override
  String get savedPasswordsTitle => 'Сохранённые пароли';

  @override
  String get savedPasswordsSubtitle => 'Просматривайте и управляйте сохранёнными паролями';

  @override
  String get noSavedPasswords => 'Пока нет сохранённых паролей';

  @override
  String get generateOrAddPasswords => 'Создайте или добавьте пароль, чтобы увидеть список';

  @override
  String get sortLatest => 'Самые новые';

  @override
  String get sortLatestFirst => 'Сначала новые';

  @override
  String get sortOldest => 'Самые старые';

  @override
  String get sortOldestFirst => 'Сначала старые';

  @override
  String get sortByPassword => 'По паролю';

  @override
  String get sortByPasswordAZ => 'Пароль (A-Z)';

  @override
  String get sortByNickname => 'По названию';

  @override
  String get sortByNicknameAZ => 'Название (A-Z)';

  @override
  String get copy => 'Копировать';

  @override
  String get passwordCopied => 'Пароль скопирован!';

  @override
  String get addedToFavorites => 'Добавлено в избранное!';

  @override
  String get removedFromFavorites => 'Удалено из избранного!';

  @override
  String get deletePassword => 'Удалить пароль';

  @override
  String get confirmDeletePassword => 'Вы уверены, что хотите удалить этот пароль?';

  @override
  String get delete => 'Удалить';

  @override
  String get passwordDeleted => 'Пароль удалён!';

  @override
  String get length => 'Длина';

  @override
  String get editingPassword => 'Редактирование пароля...';

  @override
  String get tapToEditPassword => 'Нажмите, чтобы редактировать';

  @override
  String get generatorTitle => 'Генератор паролей';

  @override
  String get generatorSubtitle => 'Создавайте надёжные и безопасные пароли';

  @override
  String get passwordLength => 'Длина пароля';

  @override
  String get generatePassword => 'Создать пароль';

  @override
  String get generatedPassword => 'Созданный пароль';

  @override
  String get nicknameOptional => 'Название (необязательно)';

  @override
  String get enterANickname => 'Введите название';

  @override
  String get giveNicknameMeaning => 'Дайте этому паролю запоминающееся имя';
}
