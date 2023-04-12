// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

mixin AppConfig {
  static FirebaseAuth auth  = FirebaseAuth.instance;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
  static DatabaseReference sessionsRef = FirebaseDatabase.instance.reference().child("sessions");
  static DatabaseReference therapistsRef = FirebaseDatabase.instance.reference().child("therapists");
  static DatabaseReference bookingsRef = FirebaseDatabase.instance.reference().child("bookings");
  static DatabaseReference paymentsRef = FirebaseDatabase.instance.reference().child("payments");
  static DatabaseReference locationsRef = FirebaseDatabase.instance.reference().child("locations");
  static DatabaseReference reviewsRef = FirebaseDatabase.instance.reference().child("reviews");
}
