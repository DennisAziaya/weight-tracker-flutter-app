import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  AuthProvider();

  late String _userId;
  late String _token;
  DateTime _expiryDate = DateTime.now();

  bool get isUserAuthenticated {
    return token != "";
  }

  String get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return "";
  }

  String apiKey = '';
  String baseUrl = "https://identitytoolkit.googleapis.com/v1/accounts:";

  Future<void> signUpUser(String email, String password) async {
    try {
      final signUpUrl = Uri.parse(baseUrl + "signUp?key=$apiKey");

      final http.Response response = await http.post(signUpUrl,
          headers: {
            HttpHeaders.contentTypeHeader: "application/jason",
            HttpHeaders.acceptHeader: "application/jason"
          },
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));

      final rs = json.decode(response.body);
      print(rs);

      if (rs["error"] != null) {
        if (rs['error']['message'] == "EMAIL_EXISTS") {
          throw Exception("User with this email already exist");
        }
      }

      _token = rs['idToken'];
      _userId = rs['localId'];

      final _tokenDuration = int.parse(rs['expiresIn']);
      _expiryDate = DateTime.now().add(Duration(seconds: _tokenDuration));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signInUser(String email, String password) async {
    final loginUrl = Uri.parse(baseUrl + "signInWithPassword?key=$apiKey");

    try {
      final http.Response response = await http.post(loginUrl,
          headers: {
            HttpHeaders.contentTypeHeader: "application/jason",
            HttpHeaders.acceptHeader: "application/jason",
          },
          body: jsonEncode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));

      final rs = json.decode(response.body);
      print(rs);

      if (rs["error"] != null) {
        if (rs["error"]["message"] == "INVALID_PASSWORD") {
          throw Exception("You entered an invalid Password");
        } else if (rs["error"]["message"] == "EMAIL_NOT_FOUND") {
          throw Exception("No user exits with such email");
        }
      }

      _token = rs['idToken'];
      _userId = rs['localId'];

      final _tokenDuration = int.parse(rs['expiresIn']);
      _expiryDate = DateTime.now().add(Duration(seconds: _tokenDuration));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    _token = "";
    notifyListeners();
  }
}
