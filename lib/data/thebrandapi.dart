import 'dart:convert';

import 'package:the_brand_demo/models/response.dart';
import 'package:http/http.dart' as http;

class TheBrandApi {
  Future<Response> fetchResponseData() async {
    final apiResponse = await http
        .get(Uri.parse("https://www.thebrand.ai/i/prompt?page=0&mode=home"));

    if (apiResponse.statusCode == 200) {
      // api call success so parse json data
      return Response.fromJson(jsonDecode(apiResponse.body));
    } else {
      // server error throw exception
      throw Exception("Failed to load api data");
    }
  }
}
