import 'package:user_repository/models/models.dart';
import 'package:uuid/uuid.dart';

/// Trong ví dụ này, UserRepository hiển thị một phương thức duy nhất là
/// getUser() và sẽ truy xuất người dùng hiện tại. Còn trong thực tế, đây
/// sẽ là nơi truy vấn người dùng hiện tại từ Backend.
class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4()),
    );
  }
}
