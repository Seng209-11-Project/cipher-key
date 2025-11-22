// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get appTitle => 'Şifrə Yaradıcı Tətbiqi';

  @override
  String get authenticateButton => 'Kimliyi Təsdiqlə';

  @override
  String get navGenerate => 'Yarat';

  @override
  String get navSaved => 'Saxlanılanlar';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSubtitle => 'Şifrə menecerinizi fərdiləşdirin';

  @override
  String get settingsAppearance => 'Görünüş';

  @override
  String get settingsSecurity => 'Təhlükəsizlik';

  @override
  String get settingsPasswordGeneration => 'Şifrə Yaratma';

  @override
  String get settingsDataManagement => 'Məlumat İdarəetməsi';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get selectPreferredLanguage => 'İstədiyiniz dili seçin';

  @override
  String get darkMode => 'Qaranlıq Mod';

  @override
  String get switchToDarkTheme => 'Tünd temaya keç';

  @override
  String get switchToLightTheme => 'Açıq temaya keç';

  @override
  String get requireFingerprint => 'Barmaq izi tələb et';

  @override
  String get fingerprintDescription => 'Tətbiq açıldıqda barmaq izi doğrulaması istə';

  @override
  String get charTypeInstructions => 'Daxil ediləcək simvol növlərini seçin';

  @override
  String get uppercase => 'Böyük Hərflər (A-Z)';

  @override
  String get lowercase => 'Kiçik Hərflər (a-z)';

  @override
  String get numbers => 'Rəqəmlər (0-9)';

  @override
  String get symbols => 'Simvollar (@#\$%...)';

  @override
  String get deleteAllPasswordsHeader => 'Bütün saxlanılmış şifrələri daimi sil';

  @override
  String get deleteAllPasswords => 'Bütün Şifrələri Sil';

  @override
  String get deleteAllPasswordsDialogTitle => 'Bütün şifrələr silinsin?';

  @override
  String deleteAllPasswordsDialogContent(Object count) {
    return '$count saxlanılmış şifrə daimi olaraq silinəcək.';
  }

  @override
  String get cancel => 'Ləğv et';

  @override
  String get deleteAll => 'Hamısını Sil';

  @override
  String get noPasswordsToDelete => 'Silinəcək şifrə yoxdur';

  @override
  String get allPasswordsDeleted => 'Bütün şifrələr silindi!';

  @override
  String get authFailed => 'Doğrulama uğursuz oldu';

  @override
  String get atLeastOneOptionRequired => 'Ən azı bir seçim tələb olunur';

  @override
  String get addNewPassword => 'Yeni Şifrə Əlavə Et';

  @override
  String get nickname => 'Ləqəb';

  @override
  String get enterNickname => 'Bu şifrə üçün ləqəb daxil edin';

  @override
  String get password => 'Şifrə';

  @override
  String get enterPassword => 'Şifrəni daxil edin';

  @override
  String get save => 'Yadda saxla';

  @override
  String get pleaseEnterPassword => 'Zəhmət olmasa şifrə daxil edin';

  @override
  String get passwordSaved => 'Şifrə saxlanıldı!';

  @override
  String get passwordSaveFailed => 'Şifrə saxlanıla bilmədi';

  @override
  String get savedPasswordsTitle => 'Saxlanılan Şifrələr';

  @override
  String get savedPasswordsSubtitle => 'Saxlanılan şifrələrinizi görün və idarə edin';

  @override
  String get noSavedPasswords => 'Hələ saxlanılan şifrə yoxdur';

  @override
  String get generateOrAddPasswords => 'Görmək üçün şifrə yaradın və ya əlavə edin';

  @override
  String get sortLatest => 'Ən Yeni';

  @override
  String get sortLatestFirst => 'Əvvəlcə ən yeni';

  @override
  String get sortOldest => 'Ən Köhnə';

  @override
  String get sortOldestFirst => 'Əvvəlcə ən köhnə';

  @override
  String get sortByPassword => 'Şifrə üzrə';

  @override
  String get sortByPasswordAZ => 'Şifrə (A-Z)';

  @override
  String get sortByNickname => 'Ləqəb üzrə';

  @override
  String get sortByNicknameAZ => 'Ləqəb (A-Z)';

  @override
  String get copy => 'Kopyala';

  @override
  String get passwordCopied => 'Şifrə kopyalandı!';

  @override
  String get addedToFavorites => 'Favorilərə əlavə olundu!';

  @override
  String get removedFromFavorites => 'Favorilərdən çıxarıldı!';

  @override
  String get deletePassword => 'Şifrəni Sil';

  @override
  String get confirmDeletePassword => 'Bu şifrəni silmək istədiyinizə əminsiniz?';

  @override
  String get delete => 'Sil';

  @override
  String get passwordDeleted => 'Şifrə silindi!';

  @override
  String get length => 'Uzunluq';

  @override
  String get editingPassword => 'Şifrə redaktə edilir...';

  @override
  String get tapToEditPassword => 'Düzəliş etmək üçün toxunun';

  @override
  String get generatorTitle => 'Şifrə Yaradıcı';

  @override
  String get generatorSubtitle => 'Güclü və təhlükəsiz şifrələr yaradın';

  @override
  String get passwordLength => 'Şifrə Uzunluğu';

  @override
  String get generatePassword => 'Şifrə Yarat';

  @override
  String get generatedPassword => 'Yaradılan Şifrə';

  @override
  String get nicknameOptional => 'Ləqəb (istəyə bağlı)';

  @override
  String get enterANickname => 'Bir ləqəb daxil edin';

  @override
  String get giveNicknameMeaning => 'Bu şifrə üçün yadda qalan bir ad verin';
}
