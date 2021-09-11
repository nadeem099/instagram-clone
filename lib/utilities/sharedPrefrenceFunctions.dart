

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFunctions{
  static String sharedPreferenceLoggedInKey = "ISLOGGEDINKEY";
  static String sharedPreferenceUserIdKey = "USERIDKEY";  // TODO: not working
  static String sharedPreferenceUsernameKey = "USERNAMEKEY";
  static String sharedPreferenceEmailKey = "USEREMAILKEY";


  //saving data to sharedprefernce
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoogedIn) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return await _pref.setBool(sharedPreferenceLoggedInKey, isUserLoogedIn);
  }

  static Future<bool> saveUserIdSharedPreference(String id) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return await _pref.setString(sharedPreferenceUserIdKey, id);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return await _pref.setString(sharedPreferenceUsernameKey, userName);
  }

  static Future<bool> saveUserEmailIdSharedPreference(String emailId) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return await _pref.setString(sharedPreferenceEmailKey, emailId);
  }

  static Future<bool> saveUserLikedSharedPreference(bool isUserLiked, String sharePreferenceUserLikedId) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return await _pref.setBool(sharePreferenceUserLikedId, isUserLiked);
  }  

  static Future<bool> getuserLoggInSharedPreference() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return  _pref.getBool(sharedPreferenceLoggedInKey) == null ? false : _pref.getBool(sharedPreferenceLoggedInKey) as bool;
  }

  //TODO saved and fetched user ids are not same
  static Future<String> getuserUserIdSharedPreference() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(sharedPreferenceUserIdKey) == null ? "" : _pref.getString(sharedPreferenceUserIdKey) as String;
  }

  static Future<String> getuserUserNameSharedPreference() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(sharedPreferenceUsernameKey) == null ? "" : _pref.getString(sharedPreferenceLoggedInKey) as String;
  }

  static Future<String> getuserEmailIdSharedPreference() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(sharedPreferenceEmailKey) == null ? "" : _pref.getString(sharedPreferenceLoggedInKey) as String;
  }

  static Future<bool> getUserLikedSharedPreference(String sharePreferenceUserLikedId) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return  _pref.getBool(sharePreferenceUserLikedId) == null ? false : _pref.getBool(sharePreferenceUserLikedId) as bool;
  }

}