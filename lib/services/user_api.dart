import 'dart:convert';
import 'dart:html';

import 'package:apicalls/model/user.dart';
import 'package:apicalls/model/user_dob.dart';
import 'package:apicalls/model/user_location.dart';
import 'package:apicalls/model/user_name.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> fetchUsers() async {
    print("fetch users called");
    final url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      final date = e['dob']['date'];
      final dob = UserDob(
        age: e['dob']['age'],
        date: DateTime.parse(date),
      );
      final coordinates = LocationCoordinate(
          latitude: e['location']['coordinates']['latitude'],
          longitude: e['location']['coordinates']['longitude']);

      final street = LocationStreet(
        name: e['location']['street']['name'],
        number: e['location']['street']['number'],
      );
      final timezone = LocationTimezone(
          offset: e['location']['timezone']['offset'],
          description: e['location']['timezone']['description']);
      final location = UserLocation(
        city: e['location']['city'],
        coordinates: coordinates,
        country: e['location']['country'],
        postcode: e['location']['postcode'].toString(),
        state: e['location']['state'],
        street: street,
        timezone: timezone,
      );
      return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        nat: e['nat'],
        phone: e['phone'],
        name: name,
        dob: dob,
        location: location,
      );
    }).toList();
    return users;
  }
}
