import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_store_app/global_variables.dart';
import 'package:my_store_app/models/product.dart';

class ProductController {
  //Define a function that returns a future containing list of the product mosel objects
  Future<List<Product>> loadPopularProducts() async {
    //use a try block to handel any exception that maight occure in the http request proccess
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/popular-products"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      print(response.body);

      //check if the response status code is 200, which means the request was successful
      if (response.statusCode == 200) {
        //decode the response body into a list of dynamic objects
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //map each items in the lost to product model objects using which we are using the fromMap constructor
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        //throw an exception if the request was not successful
        throw Exception("Failed to load popular products");
      }
    } catch (e) {
      //throw an exception if an error occurred during the http request proccess
      throw Exception("Error loading popular products: $e");
    }
  }

  //load products by category function
  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/products-by-category/$category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        //decode the response body into a list of dynamic objects
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        //map each items in the lost to product model objects using which we are using the fromMap constructor
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        //throw an exception if the request was not successful
        throw Exception("Failed to load popular products");
      }
    } catch (e) {
      //throw an exception if an error occurred during the http request proccess
      throw Exception("Error loading popular products: $e");
    }
  }
}
