part of 'authentication_bloc.dart';

/// AuthenticationState sẽ là đầu ra của AuthenticationBloc và sẽ được
/// sử dụng bời tầng Presentation Layer.
/// AuthenticationState sẽ có 3 thuộc tính cần khởi tạo:
/// - AuthenticationState.unknown(): trạng thái mặc định cho biết rằng Bloc vẫn chưa
/// biết liệu người dùng đã được xác thực hay chưa.
/// - AuthenticationState.authen(): trạng thái xác định rằng việc người dùng dã được
/// xác thực.
/// - AuthenticationState,unAuthen(): trạng thái xác định rằng người dùng chưa dược
/// xác thực.
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}

// class AuthenticationInitial extends AuthenticationState {
//   const AuthenticationInitial(super.status, super.user);
//
//   @override
//   List<Object> get props => [];
// }
