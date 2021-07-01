import 'package:my_lms/data/models/user_model.dart';

class FirebaseRepo {
  static Future<User> loginWithEmailAndpswd(
      {required String email, required String password}) async {
    try {
      Future.delayed(Duration(seconds: 3));
      return User(
        uid: "200129001050",
        name: "Kasun Dulara",
        email: "$email",
        streamId: "engineeringtec",
      );
    } catch (e) {
      throw e;
    }
  }

  static Future<User> signUpNewUser({required User user}) async {
    try {
      Future.delayed(Duration(seconds: 3));
      return User(
        uid: "200129001050",
        name: "${user.name}",
        email: "${user.email}",
        streamId: "${user.streamId}",
      );
    } catch (e) {
      throw e;
    }
  }
}
