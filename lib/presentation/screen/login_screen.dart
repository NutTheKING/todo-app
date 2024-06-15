import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/service/view_model/login_view_model.dart';

class LoginScreen extends StackedView<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  LoginViewModel viewModelBuilder(BuildContext context) {
    return LoginViewModel();
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    viewModel.getInstance();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    // return ViewModelStateOverlay<LoginViewModel>(
    return Scaffold(
        body: Center(
      child: Text('Next'),
    ));
  }
}
