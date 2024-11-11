import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseReference {
  DatabaseReference ref = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://demoz-6f2fd-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref('groups');

  FirebaseReference._internalConstructor();

  static final FirebaseReference _firebasePreference =
      FirebaseReference._internalConstructor();

  static FirebaseReference get getInstance => _firebasePreference;
}
