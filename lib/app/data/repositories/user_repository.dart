import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_manager/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider _provider;

  UserRepository._(this._provider);
  static final UserRepository instance =
      UserRepository._(UserProvider('users'));

  User? get currentUser {
    return _provider.currentUser;
  }

  bool get isLoggedIn => currentUser != null;

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
  }) get authenticateWithPhoneNumber => _provider.authenticateWithPhoneNumber;

  Future<UserCredential> Function(AuthCredential)
      get authenticateWithCredentials => _provider.authenticateWithCredentials;

  Future<UserCredential> authenticateWithGoogle() async {
    return await _provider.authenticateWithGoogle();
  }

  Future<List<String>> fetchAllProjectPriorities() async {
    return _provider.fetchAllProjectPriorities();
  }

  Future<List<String>> fetchAllTaskPriorities() async {
    return _provider.fetchAllTaskPriorities();
  }

  Future<List<String>> fetchAllProjectStatuses() async {
    return _provider.fetchAllProjectStatuses();
  }

  Future<List<String>> fetchAllTaskStatuses() async {
    return _provider.fetchAllTaskStatuses();
  }

  Future<void> saveProjectPriorities(List<String> priorities) async {
    return _provider.saveProjectPriorities(priorities);
  }

  Future<void> saveTaskPriorities(List<String> priorities) async {
    return _provider.saveTaskPriorities(priorities);
  }

  Future<void> saveProjectStatuses(List<String> priorities) async {
    return _provider.saveProjectStatuses(priorities);
  }

  Future<void> saveTaskStatuses(List<String> statuses) async {
    return _provider.saveTaskStatuses(statuses);
  }

  Future<void> updateDisplayName(String displayName) async {
    return _provider.updateDisplayName(displayName);
  }

  Future<String?> updatePhotoUrl() async {
    return _provider.updatePhotoUrl();
  }

  Future<void> signOut() async {
    return _provider.signOut();
  }
}
