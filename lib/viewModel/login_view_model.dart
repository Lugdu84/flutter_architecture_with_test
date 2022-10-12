import 'package:flutter_architecture/view/login_screen.dart';

class LoginViewModel extends ILoginViewModel {
  bool _isLoading = false;
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  String? _email;
  String? _password;

  @override
  String? get emailErrorMessage => _emailErrorMessage;
  @override
  String? get passwordErrorMessage => _passwordErrorMessage;
  @override
  bool get isLoading => _isLoading;
  @override
  String? get errorMessage => _errorMessage;

  static const errorMinCaracInPassword =
      "Le mot de passe doit comporter au moins 6 caractères";
  static const errorPassworMustNotBeEmpty = "Le mot de passe est obligatoire";
  static const emailNotValid = "Email invalide";

  bool get _minimalInputValid =>
      _email != null &&
      _password != null &&
      _emailErrorMessage == null &&
      _passwordErrorMessage == null;

  @override
  void emailChanged(String newEmail) {
    _email = newEmail;
    _emailErrorMessage = null;
  }

  @override
  void passwordChanged(String newPassword) {
    _password = newPassword;
    _passwordErrorMessage = null;
  }

  @override
  void loginUser() async {
    final email = _email;
    final password = _password;

    if (email != null && password != null) {
      if (!email.contains("@")) {
        _emailErrorMessage = LoginViewModel.emailNotValid;
        notifyListeners();
      }
      if (password.isEmpty) {
        _passwordErrorMessage = LoginViewModel.errorPassworMustNotBeEmpty;
        notifyListeners();
      } else if (password.isNotEmpty && password.length < 7) {
        _passwordErrorMessage = LoginViewModel.errorMinCaracInPassword;
        notifyListeners();
      }
      if (_minimalInputValid) {
        _isLoading = true;
        notifyListeners();
        await Future.delayed(const Duration(seconds: 2));
        _isLoading = false;

        _errorMessage = password == "azertys"
            ? "Bienvenue $email"
            : "Impossible de retrouver votre compte";
        notifyListeners();
      }
    }
  }
}
