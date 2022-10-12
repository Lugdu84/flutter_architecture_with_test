import 'package:flutter_architecture/viewModel/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('test first values for LoginViewModel', () {
    final loginVM = LoginViewModel();
    expect(loginVM.emailErrorMessage, null);
    expect(loginVM.passwordErrorMessage, null);
    expect(loginVM.isLoading, false);
    expect(loginVM.errorMessage, null);
  });

  test('test email valid or not', () {
    final loginVM = LoginViewModel();
    loginVM.passwordChanged("test");
    loginVM.emailChanged("test");
    loginVM.loginUser();
    expect(loginVM.emailErrorMessage, LoginViewModel.emailNotValid);
    loginVM.emailChanged("");
    loginVM.loginUser();
    expect(loginVM.emailErrorMessage, LoginViewModel.emailNotValid);
    loginVM.emailChanged("sheldon@co.io");
    loginVM.loginUser();
    expect(loginVM.emailErrorMessage, null);
  });

  test('test valid password or not', () {
    final loginVM = LoginViewModel();
    loginVM.emailChanged("test");
    loginVM.passwordChanged("");
    loginVM.loginUser();
    expect(loginVM.passwordErrorMessage,
        LoginViewModel.errorPassworMustNotBeEmpty);
    loginVM.passwordChanged("e");
    loginVM.loginUser();
    expect(
        loginVM.passwordErrorMessage, LoginViewModel.errorMinCaracInPassword);
    loginVM.passwordChanged("azerty");
    loginVM.loginUser();
    expect(
        loginVM.passwordErrorMessage, LoginViewModel.errorMinCaracInPassword);
    loginVM.passwordChanged("azertys");
    loginVM.loginUser();
    expect(loginVM.passwordErrorMessage, null);
  });
}
