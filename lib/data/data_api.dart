import 'dart:convert';

import 'package:FlutterGalleryApp/models/auth/model.dart';
import 'package:FlutterGalleryApp/models/photo_list/model.dart';

import 'package:http/http.dart' as http;

/*
 async {
  const url = "$baseUrl/api/v1/login";

  var response = await http.post(url, body: {
    'user': '$username',
    'password': '$pwd',
  });

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return Login.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
*/

class DataProvider {
  static const String _appId = "150449"; //not used, just for info
  static String authToken = ""; //"F63Eugcwk6C8jy1RJ8v05x7G0lONfWkVBV5GqUe01CE";
  static const String _accessKey =
      '4fQl1RwrLQYej10AQ2cSl6gsBDEVs-1FSbNFPHc3Pwo'; //app access key from console
  static const String _secretKey =
      '_tAz9_ey9D1RplEEp8Nvau5VpTTVh4AtjGpUu-JLvTA'; //app secrey key from console
  static const String authUrl =
      'https://unsplash.com/oauth/authorize?client_id=$_accessKey&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=public+write_likes'; //authorize url from https://unsplash.com/oauth/applications/{your_app_id}

  static Future<Auth> doLogin({String oneTimeCode}) async {
    var response = await http.post('https://unsplash.com/oauth/token',
        headers: {
          'Content-Type': 'application/json',
        },
        body:
        '{"client_id":"$_accessKey","client_secret":"$_secretKey","redirect_uri":"urn:ietf:wg:oauth:2.0:oob","code":"$oneTimeCode","grant_type":"authorization_code"}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Auth.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<Photos> getPhoto(String id) async {
    var response = await http.get(
        'https://api.unsplash.com/photos/$id',
        headers: {'Authorization': 'Client-ID $_accessKey'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<PhotoList> searchPhotos(String keyword, int page, int pageSize) async {
    var response = await http.get(
        'https://api.unsplash.com/search/photos?query=$keyword&page=$page&per_page=$pageSize',
        headers: {'Authorization': 'Client-ID $_accessKey'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<PhotoList> getPhotos(int page, int perPage) async {
    var response = await http.get(
        'https://api.unsplash.com/photos?page=$page&per_page=$perPage',
        headers: {'Authorization': 'Client-ID $_accessKey'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<Photo> getRandomPhoto() async {
    var response = await http.get('https://api.unsplash.com/photos/random',
        headers: {'Authorization': 'Client-ID $_accessKey'});

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<bool> likePhoto(String photoId) async {
    var response = await http
        .post('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Client-ID $_accessKey',
    });

    print(response.body);
    print(response.reasonPhrase);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  static Future<bool> unlikePhoto(String photoId) async {
    var response = await http
        .delete('https://api.unsplash.com/photos/$photoId/like', headers: {
      'Authorization': 'Client-ID $_accessKey',
    });

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true; //returns 201 - Created
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}