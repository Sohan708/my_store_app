import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_store_app/global_variables.dart';
import 'package:my_store_app/models/banner_model.dart';

class BannerController {
  //fetch banner
  Future<List<BannerModel>> loadBanners() async {
    try {
      //fetch banners from api
      http.Response response = await http.get(
        Uri.parse("$uri/api/banner"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners = data
            .map((banner) => BannerModel.fromJson(banner))
            .toList();
        return banners;
      } else {
        //throw an exception if the sever response is not 200
        throw Exception("Failed to fetch banners");
      }
    } catch (e) {
      throw Exception("Error loading banners: $e");
    }
  }
}
