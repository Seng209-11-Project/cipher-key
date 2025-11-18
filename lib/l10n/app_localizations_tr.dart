// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Şifre Oluşturucu Uygulaması';

  @override
  String get navGenerate => 'Oluştur';

  @override
  String get navSaved => 'Kaydedilenler';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSubtitle => 'Şifre yöneticinizi özelleştirin';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsSecurity => 'Güvenlik';

  @override
  String get settingsPasswordGeneration => 'Şifre Oluşturma';

  @override
  String get settingsDataManagement => 'Veri Yönetimi';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get selectPreferredLanguage => 'Terchih ettiğiniz dili seçin';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get switchToDarkTheme => 'Koyu temaya geç';

  @override
  String get switchToLightTheme => 'Açık temaya geç';

  @override
  String get requireFingerprint => 'Parmak İzi Gereksinimi';

  @override
  String get fingerprintDescription => 'Uygulama açılışında parmak izi doğrulaması iste';

  @override
  String get charTypeInstructions => 'Dahil edilecek karakter türlerini seçin';

  @override
  String get uppercase => 'Büyük Harfler (A-Z)';

  @override
  String get lowercase => 'Küçük Harfler (a-z)';

  @override
  String get numbers => 'Rakamlar (0-9)';

  @override
  String get symbols => 'Semboller (@#\$%...)';

  @override
  String get deleteAllPasswordsHeader => 'Tüm kayıtlı şifreleri kalıcı olarak sil';

  @override
  String get deleteAllPasswords => 'Tüm Şifreleri Sil';

  @override
  String get deleteAllPasswordsDialogTitle => 'Tüm Şifreler Silinsin mi?';

  @override
  String deleteAllPasswordsDialogContent(Object count) {
    return '$count kayıtlı şifre kalıcı olarak silinecek.';
  }

  @override
  String get cancel => 'İptal';

  @override
  String get deleteAll => 'Tümünü Sil';

  @override
  String get noPasswordsToDelete => 'Silinecek şifre yok';

  @override
  String get allPasswordsDeleted => 'Tüm şifreler silindi!';

  @override
  String get authFailed => 'Doğrulama Başarısız';

  @override
  String get atLeastOneOptionRequired => 'En az bir seçenek gerekli';

  @override
  String get addNewPassword => 'Yeni Şifre Ekle';

  @override
  String get nickname => 'Takma Ad';

  @override
  String get enterNickname => 'Bu şifre için bir takma ad girin';

  @override
  String get password => 'Şifre';

  @override
  String get enterPassword => 'Şifreyi girin';

  @override
  String get save => 'Kaydet';

  @override
  String get pleaseEnterPassword => 'Lütfen bir şifre girin';

  @override
  String get passwordSaved => 'Şifre kaydedildi!';

  @override
  String get passwordSaveFailed => 'Şifre kaydedilemedi';

  @override
  String get savedPasswordsTitle => 'Kaydedilen Şifreler';

  @override
  String get savedPasswordsSubtitle => 'Kayıtlı şifrelerinizi görüntüleyin ve yönetin';

  @override
  String get noSavedPasswords => 'Henüz kayıtlı şifre yok';

  @override
  String get generateOrAddPasswords => 'Görüntülemek için şifre oluşturun veya ekleyin';

  @override
  String get sortLatest => 'En Yeni';

  @override
  String get sortLatestFirst => 'Önce En Yeni';

  @override
  String get sortOldest => 'En Eski';

  @override
  String get sortOldestFirst => 'Önce En Eski';

  @override
  String get sortByPassword => 'Şifreye Göre';

  @override
  String get sortByPasswordAZ => 'Şifre (A-Z)';

  @override
  String get sortByNickname => 'Takma Ad\'a Göre';

  @override
  String get sortByNicknameAZ => 'Takma Ad (A-Z)';

  @override
  String get copy => 'Kopyala';

  @override
  String get passwordCopied => 'Şifre Kopyalandı!';

  @override
  String get addedToFavorites => 'Favorilere Eklendi!';

  @override
  String get removedFromFavorites => 'Favorilerden Çıkarıldı!';

  @override
  String get deletePassword => 'Şifreyi Sil';

  @override
  String get confirmDeletePassword => 'Bu şifreyi silmek istediğinize emin misiniz?';

  @override
  String get delete => 'Sil';

  @override
  String get passwordDeleted => 'Şifre Silindi!';

  @override
  String get length => 'Uzunluk';

  @override
  String get editingPassword => 'Şifre düzenleniyor...';

  @override
  String get tapToEditPassword => 'Düzenlemek için dokunun';

  @override
  String get generatorTitle => 'Şifre Oluşturucu';

  @override
  String get generatorSubtitle => 'Güçlü ve güvenli şifreler oluşturun';

  @override
  String get passwordLength => 'Şifre Uzunluğu';

  @override
  String get generatePassword => 'Şifre Oluştur';

  @override
  String get generatedPassword => 'Oluşturulan Şifre';

  @override
  String get nicknameOptional => 'Takma Ad (opsiyonel)';

  @override
  String get enterANickname => 'Bir takma ad girin';

  @override
  String get giveNicknameMeaning => 'Bu şifreye akılda kalıcı bir isim verin';
}
