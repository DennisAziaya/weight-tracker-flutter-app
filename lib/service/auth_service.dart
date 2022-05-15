// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// class AuthService {
//   late String _userId;
//   late String _token;
//   // late DateTime _expiryDate;
//
//   //late String token;
//   //
//   //AuthService(_token);
//
//   String apiKey = 'AIzaSyD7m2ahUwZ5QbqRhD8IlV8BgOebYT7ZfPM';
//
//   String baseUrl = "https://identitytoolkit.googleapis.com/v1/accounts:";
//
//   Future<void> signUpUser(String email, String password) async {
//     try {
//       final signUpUrl = Uri.parse(baseUrl + "signUp?key=[$apiKey]");
//
//       final http.Response response = await http.post(signUpUrl,
//           headers: {
//             HttpHeaders.contentTypeHeader: "application/jason",
//             HttpHeaders.acceptHeader: "application/jason"
//           },
//           body: json.encode({
//             "email": email,
//             "password": password,
//             "returnSecureToken": true
//           }));
//       print(jsonDecode(response.body));
//     } catch (error) {
//       print(error);
//     }
//
//     // return response.body;
//   }
//
//   Future<void> signInUser(String email, String password) async {
//     final loginUrl = Uri.parse(baseUrl + "signInWithCustomToken?key=[apiKey]");
//
//     try {
//       final http.Response response = await http.post(loginUrl,
//           headers: {
//             HttpHeaders.contentTypeHeader: "application/jason",
//             HttpHeaders.acceptHeader: "application/jason",
//             //HttpHeaders.authorizationHeader: "Bearer $_token"
//           },
//           body: jsonEncode({
//             "email": email,
//             "password": password,
//           }));
//
//       final responseData = json.decode(response.body);
//       String errorMessage = responseData['detail'];
//
//       if (response.statusCode != 200) {
//         throw HttpException(errorMessage);
//       } else {
//         _token = responseData['access'];
//         _userId = responseData['id'];
//       }
//
//       // if(responseData['error'] != null ){
//       //   throw HttpException(errorMessage);
//       // }
//
//     } catch (error) {
//       throw error;
//     }
//
//     // return response.body;
//   }
// }
