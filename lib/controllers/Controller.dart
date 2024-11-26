import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:pas1_mobile_11pplg1_25/utility/teamsModel.dart';
import 'package:sqflite/sqflite.dart';
import '../utility/Models.dart';

class MyController extends GetxController{
  var baseURL = 'https://mediadwi.com';
  var registerResponse;
  var index = 0.obs;
  var title = "Home".obs;
  var margin = const EdgeInsets.fromLTRB(50000, 5, 5, 0).obs;
  var logInResponse = const ResponseModel(status: false, message: '', token: '').obs;
  var textSize = 15.0.obs;
  var searchParam = "".obs;
  RxList<teamsModel> returnData = <teamsModel>[].obs;
  RxList<teamsModel> likedData = <teamsModel>[].obs;
  RxList<teamsModel> fullList = <teamsModel>[].obs;
  var isLoading = true.obs;
  static Database? _db;
  var imagePath = "https://i1.sndcdn.com/avatars-j3SRoUzaLbJxPNDz-38FaEg-t500x500.jpg".obs;
  var backgroundPath = "https://i1.sndcdn.com/visuals-001422203943-o29q4e-t2480x520.jpg".obs;

  //region ApiPost
  Future<ResponseModel> logIn(String username, String password) async{

    final response = await http.post(
        Uri.parse('$baseURL/api/latihan/login'),
        body: RequestModel(username: username, password: password).toJson()
    );
    if (response.statusCode == 200) {
      logInResponse = ResponseModel.fromJson(jsonDecode(response.body)).obs;
      return ResponseModel.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to login');
  }
  Future<ResponseModel> register(String username, String password, String fullName, String email) async{
    final response = await http.post(
        Uri.parse('$baseURL/api/latihan/register-user'),
        body: RequestModel.register(
            username: username,
            password: password,
            fullName: fullName,
            email: email
        ).toJson()
    );

    if (response.statusCode == 200) {
      registerResponse = ResponseModel.registerFromJson(jsonDecode(response.body)).obs;
      return ResponseModel.registerFromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to register');
  }
  //endregion

  //region ApiGet
  Future fetchFull() async {
    print('fetching full');
    try {
      var metars = await getResponse();
      fullList.assignAll(metars);
      isLoading = true.obs;
      update();
    } catch(e){
      rethrow;
    }finally{
      isLoading = false.obs;
      update();
    }
  }
  Future<List<teamsModel>> getResponse() async{
    final response = await http.get(
        Uri.parse('https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?l=English%20Premier%20League')
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> _data = data['teams'];
      return _data.map((json) => teamsModel.fromMap(json)).toList();
    }
    throw Exception('Failed to login');
  }
  //endregion

  //region Utility
  void changeSearch(String text){
    searchParam.value = text;
  }
  void changeTab(int index, double width) {
    this.index.value = index;
    switch(index){
      case(0):
        title = "Home".obs;
        margin = const EdgeInsets.fromLTRB(10, 5, 5, 0).obs;
        break;
      case(1):
        title = "Favorite".obs;
        margin = EdgeInsets.fromLTRB(width, 5, 5, 0).obs;
        break;
      case(2):
        title = "Profile".obs;
        margin = EdgeInsets.fromLTRB(width, 5, 5, 0).obs;
        break;
    }
  }

  RxList<teamsModel> get search => getSearch(searchParam.value);
  RxList<teamsModel> getSearch(String text) {
    RxList<teamsModel> _datas = fullList;
    Rx<List<teamsModel>> temp = Rx<List<teamsModel>>([]);
    for(int i = 0; i < _datas.length; i++){
      if(_datas[i].strTeam.toLowerCase().contains(text.toLowerCase())){
        temp.value.add(_datas[i]);
      }
    }
    return temp.value.obs;
  }
  //endregion

  //region local database
  Future<Database?> get db async {
    _db ??= await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    print('creating db');
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'liked_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE liked(
            idTeam INTEGER PRIMARY KEY AUTOINCREMENT,
            strTeam TEXT,
            strTeamShort TEXT,
            strDescriptionEN TEXT,
            strBadge TEXT
          )
        ''');
      },
    );
  }

  // Insert Task
  Future<int> addLiked(teamsModel team) async {
    print('adding liked');
    likedData.add(team);
    var dbClient = await db;
    int result = await dbClient!.insert('liked', team.toMap());
    loadLiked();
    update();
    return result;
  }

  // Remove Task
  Future<int> removeLiked(teamsModel team) async {
    print('removing liked');
    likedData.remove(team);
    var dbClient = await db;
    int result = await dbClient!.delete('liked', where: 'idTeam = ${team.idTeam}');
    loadLiked();
    update();
    return result;
  }

  // Load Tasks
  Future<void> loadLiked() async {
    print('loading task');
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('liked');
    likedData.assignAll(queryResult.map((data) => teamsModel.fromMap(data)).toList());
    update();
  }

  //Check If Liked
  bool checkLiked(teamsModel team) {
    print('checking liked');
    loadLiked();
    bool result = false;
    for (var data in likedData) {
      if(data.idTeam == team.idTeam){
        result = true;
        break;
      }
    }
    update();
    return result;
  }
  //endregion
}