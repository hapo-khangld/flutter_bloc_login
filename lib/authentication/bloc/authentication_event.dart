part of 'authentication_bloc.dart';

/// AuthenEvent sẽ là đầu vào cho xác thực và sẽ được xử lý để phát ra các
/// trạng thái xác thực mới ở AuthenState
/// AuthenEvent sẽ có 2 event khác nhau gồm:
/// - AuthenticationStatusChanged: thông báo cho Bloc về một thay đổi đối với
/// người dùng.
/// - AuthenticationLogoutRequested: thông báo cho Bloc về yêu cầu đăng xuất.
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
