import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/service/view_model/splash_view_model.dart';

class SplashScreen extends StackedView<SplashViewModel> {
  const SplashScreen({super.key});

  @override
  SplashViewModel viewModelBuilder(BuildContext context) {
    return SplashViewModel();
  }

  @override
  void onViewModelReady(SplashViewModel viewModel) {
    viewModel.getInstance();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, SplashViewModel viewModel, Widget? child) {
    // return ViewModelStateOverlay<SplashViewModel>(
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.go('/login'),
                      child: Text('Next'),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (viewModel.version.isNotEmpty || viewModel.isBusy)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (viewModel.version.isNotEmpty)
                    Text(
                      'Version ${viewModel.version}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  if (viewModel.isBusy) SizedBox(height: 10),
                  if (viewModel.isBusy) CircularProgressIndicator(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
