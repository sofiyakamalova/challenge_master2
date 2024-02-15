import 'dart:convert';

import 'package:http/http.dart' as http;

class ChallengeModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  ChallengeModel({this.userId, this.id, this.title, this.completed});

  ChallengeModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}

Future<List<ChallengeModel>> getChallengesList() async {
  const url = 'https://jsonplaceholder.typicode.com/todos';
  final Uri uri = Uri.parse(url);
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<ChallengeModel> challenges =
          jsonData.map((item) => ChallengeModel.fromJson(item)).toList();
      return challenges;
    } else {
      throw Exception('Failed to load challenges');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
