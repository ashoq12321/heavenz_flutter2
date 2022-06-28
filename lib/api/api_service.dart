import 'dart:convert';
import 'dart:io';
import 'package:heavenz/models/swipe_list.dart';
import 'package:heavenz/models/user_images.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/models/signin_model.dart';
import 'package:heavenz/models/signup_model.dart';
import 'package:heavenz/models/token_model.dart';
import 'package:heavenz/models/user.dart';
import 'package:heavenz/models/user_settings.dart';
import 'package:heavenz/screens/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class APIService {
  static String base_url =
      /*'http://174.138.34.183:3000'*/ 'http://192.168.43.177:3000' /*'http://10.0.2.2:3000'*/ /*'http://127.0.0.1:3000'*/;

  String x_api_key = 'c4w2-gba0-bG9s-OnNlY3-VyKU';

  final SecureStorage secureStorage = SecureStorage();

  /*Future<String> login(LoginRequestModel loginRequestModel) async {
    final response = await http.post(Uri.parse(base_url + 'signin'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: loginRequestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      String token = response.body.toString();
      //print("token  $token");
      return token; //LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      return "error"; //Exception("Something went wrong");
    }
  }*/

  /*
   Future<List<Doctor>> getDoctors() async {
    final response = await http.get(baseUrl, headers: _header);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Doctor>.from(data['data'].map((item) => Doctor.fromJson(item)));
    } else {
      throw Exception("Failed");
    }
  }
  */

  Future<bool?> signup(SignupModel signupModel, context) async {
    print("signup api fun called");
    try {
      print("signup api try called");
      final response = await http.post(Uri.parse(base_url + '/user/register'),
          headers: {
            "Accept": "application/json",
            'X-API-KEY': x_api_key,
            /*"Access-Control-Allow-Origin": "*"*/
          },
          body: signupModel.toJson());

      print("\n\nbody ${signupModel.toJson().toString()}");

      print("response.statusCode ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 400) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return data['success'];
        } else {
          showInSnackBar(data['message'].toString(), context);
          //return null;
        }
      } else {
        print("response.statusCode ${response.statusCode}");
        throw Exception();
      }
    } /*on SocketException {
      print("No Internet");
      showInSnackBar("No Internet connection", context);
    }*/
    on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("ex $ex");
      showInSnackBar("Something went wrong", context);
    }
    return null;
  }

  Future<TokenModel?> signin(SigninModel signinModel, context) async {
    try {
      final response = await http.post(Uri.parse(base_url + '/user/login'),
          headers: {
            "Accept": "application/json",
            'X-API-KEY': x_api_key,
            /*"Access-Control-Allow-Origin": "*"*/
          },
          body: signinModel.toJson());

      if (response.statusCode == 200 ||
          response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return TokenModel.fromJson(json.decode(response.body));
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else {
        throw Exception();
      }
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      showInSnackBar("Something went wrong", context);
    }
    return null;
  }

  Future<bool?> signout(context, bool allowTokenToRefresh) async {
    print("allowTokenToRefresh : " + allowTokenToRefresh.toString());

    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    print("tokenn : " + token);
    try {
      final response = await http.post(
        Uri.parse(base_url + '/user/logout'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
          'X-API-KEY': x_api_key,
        },
      );
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200)
        return true;
      else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        print("refreshToken : " + refreshToken);

        var jsonReq = {"token": refreshToken};

        try {
          print("refreshTokenTry : ");
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);
          print("refreshTokenTry response.statusCode : " +
              response2.statusCode.toString());
          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return signout(context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      showInSnackBar("Something went wrong", context);
    }
    return false;
  }

  Future<bool?> updateUser(User user, context, bool allowTokenToRefresh) async {
    print("allowTokenToRefresh : " + allowTokenToRefresh.toString());
    print("user : " + user.first_name.toString());
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    print("tokenn : " + token);
    print("base_url : " + base_url);
    try {
      final response = await http.put(Uri.parse(base_url + '/user/update'),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
            'X-API-KEY': x_api_key,
          },
          body: user.toJson());
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);

        if (data['success'] && data['tokenUpdated']) {
          secureStorage.writeSecureData(
              'accessToken', data['accessToken'].toString());
          secureStorage.writeSecureData(
              'refreshToken', data['refreshToken'].toString());
          print("tokens : " +
              data['accessToken'].toString() +
              "\n\n " +
              data['refreshToken'].toString());
          return true;
        } else if (data['success'] && !data['tokenUpdated']) {
          return true;
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        print("refreshToken : " + refreshToken);

        var jsonReq = {"token": refreshToken};

        try {
          print("refreshTokenTry : ");
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);
          print("refreshTokenTry response.statusCode : " +
              response2.statusCode.toString());
          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return updateUser(user, context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("sssssssssssssss" + ex.toString());
      showInSnackBar("Something went wrong", context);
    }
    return false;
  }

  Future<User?> getUserDetails(
      BuildContext context, bool basic_detail, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    String url = basic_detail ? base_url + '/user/' : base_url + '/user/get';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
          'X-API-KEY': x_api_key,
        },
      );
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 404) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          print("response.statusCode : " + response.statusCode.toString());
          print(" User.fromJson(data['data']) : " +
              User.fromJson(data['data']).toString());
          return User.fromJson(data['data']);
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        var jsonReq = {"token": refreshToken};

        try {
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);

          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return getUserDetails(context, basic_detail, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
      /*} on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);*/
    } catch (ex) {
      showInSnackBar("Something went wrong", context);
      return null;
    }
    return null;
  }

  Future<bool?> updateUserSettings(
      UserSettings userSettings /*List<UserSettingModel> userSettingsList*/,
      context,
      bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    print("userSettings.toJson() : " + userSettings.toJson().toString());

    try {
      final response =
          await http.put(Uri.parse(base_url + '/userSetting/update'),
              headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                'Authorization': 'Bearer $token',
                'X-API-KEY': x_api_key,
              },
              body: json.encode(userSettings.toJson()['data']));

      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return true;
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        print("refreshToken : " + refreshToken);

        var jsonReq = {"token": refreshToken};

        try {
          print("refreshTokenTry : ");
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);
          print("refreshTokenTry response.statusCode : " +
              response2.statusCode.toString());
          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return updateUserSettings(
                  userSettings /*userSettingsList*/, context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("sssssssssssssss" + ex.toString());
      showInSnackBar("Something went wrong", context);
    }
    return false;
  }

  Future<UserSettings?> getUserSettings(
      BuildContext context, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();
    try {
      final response = await http.get(
        Uri.parse(base_url + '/userSetting/get'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
          'X-API-KEY': x_api_key,
        },
      );
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 404) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          print("response.statusCode : " + response.statusCode.toString());

          return UserSettings.fromJson(data);
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        var jsonReq = {"token": refreshToken};

        try {
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);

          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return getUserSettings(context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("exxxx : ${ex.toString()}");
      showInSnackBar("Something went wrong", context);
    }
    return null;
  }

  Future<bool?> uploadImageFiles(bool videoUploaded, List<String> files,
      BuildContext context, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    print("token : $token");

    try {
      // string to uri
      var uri = Uri.parse(base_url + '/image/save');

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      print("files length: ${files.length}");

      for (var file in files) {
        var multipartFileSign = await http.MultipartFile.fromPath('file', file);

        request.files.add(multipartFileSign);
      }
      print("\nrequest.files len : ${request.files.length}");

      Map<String, String> headers = {
        'X-API-KEY': x_api_key,
        'Authorization': 'Bearer $token',
      };

      //add headers
      request.headers.addAll(headers);

      //adding params
      if (videoUploaded)
        request.fields['video_available'] = true.toString();
      else
        request.fields['video_available'] = false.toString();

      // request.fields['firstName'] = 'abc';
      // request.fields['lastName'] = 'efg';

      // send
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        print(response.reasonPhrase);
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        print("refreshToken : " + refreshToken);

        var jsonReq = {"token": refreshToken};

        try {
          print("refreshTokenTry : ");
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);
          print("refreshTokenTry response.statusCode : " +
              response2.statusCode.toString());
          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return uploadImageFiles(videoUploaded, files, context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("sssssssssssssss" + ex.toString());
      showInSnackBar("Something went wrong", context);
    }
    return false;
  }

  Future<UserImages?> getUserImages(
      BuildContext context, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    try {
      final response = await http.get(
        Uri.parse(base_url + '/image/get'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
          'X-API-KEY': x_api_key,
        },
      );
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 404) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return UserImages.fromJson(data);
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        var jsonReq = {"token": refreshToken};

        try {
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);

          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return getUserImages(context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("exxxx : ${ex.toString()}");
      showInSnackBar("Something went wrong", context);
    }
    return null;
  }

  Future<SwipeList?> getMatches(BuildContext context, String category,
      int swipeScreenOffset, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    print("category : $category \nswipeScreenOffset : $swipeScreenOffset");
    /*var jsonReqBody = {
      "category": category,
      "offset": swipeScreenOffset.toString(),
    };*/

    try {
      final response = await http.get(
        Uri.parse(base_url +
            '/matches/' +
            category +
            "/" +
            swipeScreenOffset.toString()),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
          'X-API-KEY': x_api_key,
        },
        //body: jsonReqBody
      );
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 404) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          print("response.statusCode : " + response.statusCode.toString());

          return SwipeList.fromJson(data);
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        var jsonReq = {"token": refreshToken};

        try {
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);

          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return getMatches(context, category, swipeScreenOffset, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("exxxx : ${ex.toString()}");
      showInSnackBar("Something went wrong", context);
    }
    return null;
  }

  Future<UserImages?> getImagesById(
      BuildContext context, int user_id, bool allowTokenToRefresh) async {
    try {
      final response = await http.get(
        Uri.parse(base_url + '/image/' + user_id.toString()),
        headers: {
          "Accept": "application/json",
          'X-API-KEY': x_api_key,
        },
      );
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 404) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return UserImages.fromJson(data);
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        var jsonReq = {"token": refreshToken};

        try {
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);

          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);
              return getImagesById(context, user_id, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("exxxx : ${ex.toString()}");
      showInSnackBar("Something went wrong", context);
    }
    return null;
  }

  Future<bool?> likeUser(
      int user_id, String category, context, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    var jsonReqBody = {"category": category, "user_id": user_id.toString()};

    try {
      final response = await http.post(Uri.parse(base_url + '/user/like'),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
            'X-API-KEY': x_api_key,
          },
          body: jsonReqBody);

      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return true;
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        print("refreshToken : " + refreshToken);

        var jsonReq = {"token": refreshToken};

        try {
          print("refreshTokenTry : ");
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);
          print("refreshTokenTry response.statusCode : " +
              response2.statusCode.toString());
          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);

              return likeUser(user_id, category, context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("sssssssssssssss" + ex.toString());
      showInSnackBar("Something went wrong", context);
    }
    return false;
  }

  Future<bool?> dislikeUser(
      int user_id, String category, context, bool allowTokenToRefresh) async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    String token = token_str.toString();

    var jsonReqBody = {"category": category, "user_id": user_id.toString()};

    try {
      final response = await http.post(Uri.parse(base_url + '/user/dislike'),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
            'X-API-KEY': x_api_key,
          },
          body: jsonReqBody);
      print("response.statusCode : " + response.statusCode.toString());

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);

        if (data['success']) {
          return true;
        } else {
          showInSnackBar(data['message'].toString(), context);
        }
      } else if (response.statusCode == 401 && allowTokenToRefresh) {
        var refresh_token_str =
            (await secureStorage.readSecureData("refreshToken"));

        String refreshToken = refresh_token_str.toString();

        print("refreshToken : " + refreshToken);

        var jsonReq = {"token": refreshToken};

        try {
          print("refreshTokenTry : ");
          final response2 = await http.post(Uri.parse(base_url + '/user/token'),
              headers: {
                "Accept": "application/json",
                'X-API-KEY': x_api_key,
              },
              body: jsonReq);
          print("refreshTokenTry response.statusCode : " +
              response2.statusCode.toString());
          if (response2.statusCode == 200) {
            dynamic data = json.decode(response2.body);

            if (data['success'] && data['accessToken'] != null) {
              String newAccessToken = data['accessToken'].toString();
              secureStorage.writeSecureData('accessToken', newAccessToken);
              print("newAccessToken : " + newAccessToken);

              return dislikeUser(user_id, category, context, false);
            } else {
              throw Exception();
            }
          } else {
            throw Exception();
          }
        } catch (ex) {
          throw Exception();
        }
      } else
        throw Exception();
    } on SocketException {
      showInSnackBar("No Internet connection", context);
    } on HttpException {
      showInSnackBar("Couldn't find item", context);
    } on FormatException {
      showInSnackBar("Bad request format", context);
    } catch (ex) {
      print("sssssssssssssss" + ex.toString());
      showInSnackBar("Something went wrong", context);
    }
    return false;
  }
}
