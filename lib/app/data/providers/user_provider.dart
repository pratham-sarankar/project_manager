import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider {
  UserProvider(this.collectionName);

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  final String collectionName;

  Future<void> Function({
    String? phoneNumber,
    PhoneMultiFactorInfo? multiFactorInfo,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    String? autoRetrievedSmsCodeForTesting,
    Duration timeout,
    int? forceResendingToken,
    MultiFactorSession? multiFactorSession,
  }) get authenticateWithPhoneNumber => FirebaseAuth.instance.verifyPhoneNumber;

  Future<UserCredential> Function(AuthCredential)
      get authenticateWithCredentials =>
          FirebaseAuth.instance.signInWithCredential;

  Future<UserCredential> authenticateWithGoogle() async {
    var account = await GoogleSignIn().signIn();
    var auth = await account?.authentication;
    var credentials = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    return await authenticateWithCredentials(credentials);
  }

  Future<List<String>> fetchAllProjectPriorities() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    if (!document.exists) {
      return [];
    }
    return List<String>.from(document.data()?['project_priorities'] ?? []);
  }

  Future<List<String>> fetchAllTaskPriorities() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    if (!document.exists) {
      return [];
    }
    return List<String>.from(document.data()?['task_priorities'] ?? []);
  }

  Future<List<String>> fetchAllProjectStatuses() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    if (!document.exists) {
      return [];
    }
    return List<String>.from(document.data()?['project_statuses'] ?? []);
  }

  Future<List<String>> fetchAllTaskStatuses() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    if (!document.exists) {
      return [];
    }
    return List<String>.from(document.data()?['task_statuses'] ?? []);
  }

  Future<void> saveProjectPriorities(List<String> priorities) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    await document.reference.update({
      "project_priorities": priorities,
    });
    return;
  }

  Future<void> saveTaskPriorities(List<String> priorities) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    await document.reference.update({
      "task_priorities": priorities,
    });
    return;
  }

  Future<void> saveProjectStatuses(List<String> statuses) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    await document.reference.update({
      "project_statuses": statuses,
    });
    return;
  }

  Future<void> saveTaskStatuses(List<String> statuses) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get();
    await document.reference.update({
      "task_statuses": statuses,
    });
    return;
  }

  Future<void> updateDisplayName(String displayName) async {
    return await FirebaseAuth.instance.currentUser
        ?.updateDisplayName(displayName);
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  Future<String?> uploadPhotoToFirebase(XFile? file) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (file == null) {
      return null;
    }
    Reference ref = FirebaseStorage.instance.ref(uid).child(file.name);
    await ref.putFile(File(file.path));
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<String?> updatePhotoUrl() async {
    XFile? file = await pickImage();
    String? url = await uploadPhotoToFirebase(file);
    if (url == null) {
      return null;
    }
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
    return url;
  }

  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return;
  }
}
