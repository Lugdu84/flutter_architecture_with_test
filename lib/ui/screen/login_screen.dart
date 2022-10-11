import 'package:flutter/material.dart';

abstract class ILoginViewModel extends ChangeNotifier {
  String? get emailErrorMessage;
  String? get passwordErrorMessage;
  bool get isLoading;
  String? get errorMessage;

  void emailChanged(String newEmail);
  void passwordChanged(String newPassword);
  void loginUser();
}

class LoginScreen extends StatelessWidget {
  final ILoginViewModel _loginViewModel;
  const LoginScreen(this._loginViewModel, {Key? key}) : super(key: key);

  _loggedInButtonPressed() {
    _loginViewModel.loginUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedBuilder(
            animation: _loginViewModel,
            builder: (context, child) {
              final errorMessage = _loginViewModel.errorMessage;
              return Column(
                children: [
                  TextFormField(
                    onChanged: _loginViewModel.emailChanged,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [
                      AutofillHints.username,
                      AutofillHints.email
                    ],
                    decoration: InputDecoration(
                        labelText: "Email",
                        errorText: _loginViewModel.emailErrorMessage),
                  ),
                  TextFormField(
                    onChanged: _loginViewModel.passwordChanged,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                        labelText: "Password",
                        errorText: _loginViewModel.passwordErrorMessage),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: (_loginViewModel.isLoading)
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _loggedInButtonPressed,
                                child: const Text("Sign In"),
                              ),
                      )),
                  if (errorMessage != null) Text(errorMessage),
                ],
              );
            }),
      ),
    );
  }
}
