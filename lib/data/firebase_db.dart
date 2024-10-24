import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDb {
  late DatabaseReference ref;
  void init() async {
    FirebaseApp app = Firebase.app();
    final FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: app,
      databaseURL:
          "https://demoz-6f2fd-default-rtdb.asia-southeast1.firebasedatabase.app",
    );
    ref = database.ref();
    ref.set({"name": 'test'});
  }
}
