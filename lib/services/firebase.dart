import 'package:firebase_database/firebase_database.dart';

DatabaseReference fireRef = FirebaseDatabase.instance.ref();

DatabaseReference exercisesRef = fireRef.child("exercises");

DatabaseReference composableRef = fireRef.child("composable");

DatabaseReference userRef = fireRef.child("users");

DatabaseReference bookmarksRef = fireRef.child("users-bookmark");