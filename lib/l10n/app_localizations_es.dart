// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación Generadora de Contraseñas';

  @override
  String get authenticateButton => 'Autenticar';

  @override
  String get navGenerate => 'Generar';

  @override
  String get navSaved => 'Guardadas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSubtitle => 'Personaliza tu gestor de contraseñas';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsSecurity => 'Seguridad';

  @override
  String get settingsPasswordGeneration => 'Generación de Contraseñas';

  @override
  String get settingsDataManagement => 'Gestión de Datos';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get selectPreferredLanguage => 'Selecciona tu idioma preferido';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get switchToDarkTheme => 'Cambiar al tema oscuro';

  @override
  String get switchToLightTheme => 'Cambiar al tema claro';

  @override
  String get requireFingerprint => 'Requiere huella digital';

  @override
  String get fingerprintDescription => 'Solicitar verificación de huella al abrir la aplicación';

  @override
  String get charTypeInstructions => 'Selecciona los tipos de caracteres a incluir';

  @override
  String get uppercase => 'Mayúsculas (A-Z)';

  @override
  String get lowercase => 'Minúsculas (a-z)';

  @override
  String get numbers => 'Números (0-9)';

  @override
  String get symbols => 'Símbolos (@#\$%...)';

  @override
  String get deleteAllPasswordsHeader => 'Eliminar permanentemente todas las contraseñas guardadas';

  @override
  String get deleteAllPasswords => 'Eliminar Todas';

  @override
  String get deleteAllPasswordsDialogTitle => '¿Eliminar todas las contraseñas?';

  @override
  String deleteAllPasswordsDialogContent(Object count) {
    return 'Se eliminarán permanentemente $count contraseñas guardadas.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteAll => 'Eliminar Todo';

  @override
  String get noPasswordsToDelete => 'No hay contraseñas para eliminar';

  @override
  String get allPasswordsDeleted => '¡Todas las contraseñas fueron eliminadas!';

  @override
  String get authFailed => 'Falló la autenticación';

  @override
  String get atLeastOneOptionRequired => 'Se requiere al menos una opción';

  @override
  String get addNewPassword => 'Agregar Nueva Contraseña';

  @override
  String get nickname => 'Alias';

  @override
  String get enterNickname => 'Ingrese un alias para esta contraseña';

  @override
  String get password => 'Contraseña';

  @override
  String get enterPassword => 'Ingrese la contraseña';

  @override
  String get save => 'Guardar';

  @override
  String get pleaseEnterPassword => 'Por favor ingrese una contraseña';

  @override
  String get passwordSaved => '¡Contraseña guardada!';

  @override
  String get passwordSaveFailed => 'No se pudo guardar la contraseña';

  @override
  String get savedPasswordsTitle => 'Contraseñas Guardadas';

  @override
  String get savedPasswordsSubtitle => 'Vea y administre sus contraseñas guardadas';

  @override
  String get noSavedPasswords => 'Aún no hay contraseñas guardadas';

  @override
  String get generateOrAddPasswords => 'Genere o agregue contraseñas para verlas';

  @override
  String get sortLatest => 'Más Nuevas';

  @override
  String get sortLatestFirst => 'Más nuevas primero';

  @override
  String get sortOldest => 'Más Antiguas';

  @override
  String get sortOldestFirst => 'Más antiguas primero';

  @override
  String get sortByPassword => 'Por contraseña';

  @override
  String get sortByPasswordAZ => 'Contraseña (A-Z)';

  @override
  String get sortByNickname => 'Por alias';

  @override
  String get sortByNicknameAZ => 'Alias (A-Z)';

  @override
  String get copy => 'Copiar';

  @override
  String get passwordCopied => '¡Contraseña copiada!';

  @override
  String get addedToFavorites => '¡Añadido a favoritos!';

  @override
  String get removedFromFavorites => 'Eliminado de favoritos';

  @override
  String get deletePassword => 'Eliminar contraseña';

  @override
  String get confirmDeletePassword => '¿Está seguro de que desea eliminar esta contraseña?';

  @override
  String get delete => 'Eliminar';

  @override
  String get passwordDeleted => '¡Contraseña eliminada!';

  @override
  String get length => 'Longitud';

  @override
  String get editingPassword => 'Editando contraseña...';

  @override
  String get tapToEditPassword => 'Toca para editar';

  @override
  String get generatorTitle => 'Generador de Contraseñas';

  @override
  String get generatorSubtitle => 'Cree contraseñas fuertes y seguras';

  @override
  String get passwordLength => 'Longitud de la contraseña';

  @override
  String get generatePassword => 'Generar contraseña';

  @override
  String get generatedPassword => 'Contraseña generada';

  @override
  String get nicknameOptional => 'Alias (opcional)';

  @override
  String get enterANickname => 'Ingrese un alias';

  @override
  String get giveNicknameMeaning => 'Déle un nombre memorable a esta contraseña';
}
