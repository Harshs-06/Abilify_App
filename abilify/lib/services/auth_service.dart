import 'local_auth_service.dart';

class AuthService {
  final LocalAuthService _auth = LocalAuthService();

  Future<void> init() async {
    await _auth.init();
  }

  Future<LocalUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email, password);
    } catch (e) {
      throw e.toString();
    }
  }
  
  Future<LocalUser> createUserWithEmailAndPassword(String email, String password, {
    String? displayName,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email, 
        password,
        displayName: displayName,
      );
    } catch (e) {
      throw e.toString();
    }
  }
  
  Future<void> resetPassword(String email, String newPassword, {String? currentPassword}) async {
    try {
      return await _auth.resetPassword(email, newPassword, currentPassword: currentPassword);
    } catch (e) {
      throw e.toString();
    }
  }
  
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await _auth.updateUserProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
    } catch (e) {
      throw e.toString();
    }
  }
  
  LocalUser? get currentUser => _auth.currentUser;
  
  bool get isAuthenticated => _auth.isAuthenticated;
} 