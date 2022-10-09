import 'auth_provider.dart';
import 'auth_user.dart';

class AuthService implements AuthProvider {
  final AuthService provider;
  const AuthService(this.provider);
  
  @override
  Future<AuthUser> createUser({required String email, required String password,}) => provider.createUser(email: email, password: password,)
  
  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();
  
  @override
  Future<AuthUser> login({required String email, required String password,}) {
    // TODO: implement login
    throw UnimplementedError();
  }
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }
}
