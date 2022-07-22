import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/splash/view/splash_page.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'home/view/home_page.dart';
import 'login/view/login_page.dart';

/// App.dart được chia thành 2 phần là App và AppView.
/// App sẽ chịu trách nhiệm tạo/cung cấp AuthenticationBloc.
/// AppView sẽ chịu trách nhiệm tiêu thụ.
/// Việc này cho phép chúng ta dễ dang kiểm tra cả app và AppView sau này.
class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override

  /// RepositoryProvider được sử dụng để cung cấp phiên bản duy nhất
  /// của AuthenticationRepository cho toàn bộ ứng dụng.
  /// Điêu này sẽ có ích cho sau này.
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

/// AppView sẽ là một StatefulWidget vì nó duy trì GlobalKey và được sử dụng để truy
/// cập NavigatorState.
/// Theo mặc định, appView sẽ hiển thị SplashPage - và sử dụng BlocListener để
/// điều hướng đến các screen khác nhau dựa theo thay đổi trong AuthenticationState.
class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
