import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
final Future<FirebaseApp> initializationFireBaseApp = Firebase.initializeApp();
final Future<FirebaseApp> initializationFireBaseWeb = Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSyC_rBK-OTKQwdqUSV5AglDA9AF_JdO_ZzM",
    appId: "1:1733982480:web:93a489afd6767163e78d95",
    messagingSenderId: "1733982480",
    projectId: "instagram-clone-8b5fa",
    storageBucket: "instagram-clone-8b5fa.appspot.com",
    // authDomain: "instagram-clone-8b5fa.firebaseapp.com",
    // measurementId: "G-GSTLY49NWN",
  ),
);
