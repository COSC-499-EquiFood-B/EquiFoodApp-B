import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class EquiFoodAppFirebaseUser {
  EquiFoodAppFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

EquiFoodAppFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<EquiFoodAppFirebaseUser> equiFoodAppFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<EquiFoodAppFirebaseUser>(
      (user) {
        currentUser = EquiFoodAppFirebaseUser(user);
        return currentUser!;
      },
    );
