import 'dart:async';

/// AuthenticationRepository hiển thị một luồng các bản cập nhật cho
/// AuthenticationStatus sẽ được sử dụng để thông báo cho ứng dụng khi người
/// dùng đăng nhập hoặc dăng xuất.
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  /// Vì ta đan duy trì StreamController, nên cần phải sử dụng dispose()
  /// ddeer xử lý khi bộ điều khiển không cần thiết nữa.
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({
    required String userName,
    required String passWord,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
