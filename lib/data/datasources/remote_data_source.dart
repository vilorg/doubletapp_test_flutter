import 'dart:convert';

import 'package:doubletapp_habits/core/error/exception.dart';
import 'package:doubletapp_habits/data/models/habbit_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  /// Calls the https://droid-test-server.doubletapp.ru/api/habit endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<HabbitModel>> getHabbits(String token);

  /// Calls the https://droid-test-server.doubletapp.ru/api/habit endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> saveHabbit(HabbitModel habbit, String token);

  /// Calls the https://droid-test-server.doubletapp.ru/api/habit_done endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> doneHabbit(String uid, int date, String token);

  /// Calls the https://droid-test-server.doubletapp.ru/api/habit endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> deleteHabbit(String uid, String token);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<HabbitModel>> getHabbits(String token) async {
    String uri = "https://droid-test-server.doubletapp.ru/api/habit";
    debugPrint(uri);
    final response = await client.get(
      Uri.parse(uri),
      headers: {"Authorization": token},
    );
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      final habbitsJson = json.decode(utf8.decode(response.bodyBytes));
      return await habbitsJson
          .map<HabbitModel>((data) => HabbitModel.fromMap(data))
          .toList();
    } else if (response.statusCode == 401) {
      throw ServerUnauthException();
    } else if (response.statusCode == 500) {
      final message = json.decode(utf8.decode(response.bodyBytes));
      debugPrint(message['message']);
      throw ServerBadRequestException(message: message['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> saveHabbit(HabbitModel habbit, String token) async {
    String uri = "https://droid-test-server.doubletapp.ru/api/habit";
    debugPrint(uri);
    final response = await client.put(
      Uri.parse(uri),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: habbit.toJson(),
    );
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      final habbitJson = json.decode(utf8.decode(response.bodyBytes));
      return habbitJson["uid"];
    } else if (response.statusCode == 401) {
      throw ServerUnauthException();
    } else if (response.statusCode == 500 || response.statusCode == 400) {
      final message = json.decode(utf8.decode(response.bodyBytes));
      debugPrint(message['message']);
      throw ServerBadRequestException(message: message['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> doneHabbit(String uid, int date, String token) async {
    String uri = "https://droid-test-server.doubletapp.ru/api/habit_done";
    debugPrint(uri);
    final response = await client.post(
      Uri.parse(uri),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: json.encode({"date": date, "habit_uid": uid}),
    );
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw ServerUnauthException();
    } else if (response.statusCode == 500 || response.statusCode == 400) {
      final message = json.decode(utf8.decode(response.bodyBytes));
      debugPrint(message['message']);
      throw ServerBadRequestException(message: message['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteHabbit(String uid, String token) async {
    String uri = "https://droid-test-server.doubletapp.ru/api/habit";
    debugPrint(uri);
    final response = await client.delete(
      Uri.parse(uri),
      headers: {"Content-Type": "application/json", "Authorization": token},
      body: json.encode({"uid": uid}),
    );
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw ServerUnauthException();
    } else if (response.statusCode == 500 || response.statusCode == 400) {
      final message = json.decode(utf8.decode(response.bodyBytes));
      debugPrint(message['message']);
      throw ServerBadRequestException(message: message['message']);
    } else {
      throw ServerException();
    }
  }
}
