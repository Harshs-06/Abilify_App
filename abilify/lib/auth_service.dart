import 'services/local_auth_service.dart';

class AuthService {
  final LocalAuthService _auth = LocalAuthService();

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
  
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  LocalUser? get currentUser => _auth.currentUser;
  
  bool get isAuthenticated => _auth.isAuthenticated;
}

