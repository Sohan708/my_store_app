import 'package:flutter_riverpod/legacy.dart';
import 'package:my_store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  //constructor initializing woth the default user object
  //purpose: Mange the state of the user object allowing updates
  UserProvider()
    : super(
        User(
          id: "",
          fullName: "",
          email: "",
          state: "",
          city: "",
          locality: "",
          password: "",
          token: "",
        ),
      );

  //getter method to access the user object
  User? get user => state;

  //method to set user state from Json
  //purpose: Update the user state base on the String respresentation of user object
  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //Method to clear the user state
  void signOut() {
    state = null;
  }
}

//make the data accessible to the app
final userProvider = StateNotifierProvider<UserProvider, User?>(
  (ref) => UserProvider(),
);
