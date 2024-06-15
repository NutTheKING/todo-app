import 'package:stacked/stacked.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo_app/constant/app_router.dart';
import 'package:todo_app/service/local_service.dart';

class SplashViewModel extends BaseViewModel {
  late LocalService _localService;

  String version = '';

  getInstance() async {
    setBusy(true);
    _localService = LocalService();
    await _localService.getInstance();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = 'v${packageInfo.version}';
    splashFunction();
    setInitialised(true);
    notifyListeners();
  }

  splashFunction() async {
    await Future.delayed(const Duration(seconds: 3));
    router.go('/login');
    notifyListeners();
  }
}
