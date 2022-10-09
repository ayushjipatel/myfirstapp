//login exception
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}

//registration exception

class WeakPasswordAuthException implements Exception{}
class EmailAlreadyInUseAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}

//generic exceotin
class GenericAuthException implements Exception{}
class UserNotLoggedInAuthException implements Exception{}


