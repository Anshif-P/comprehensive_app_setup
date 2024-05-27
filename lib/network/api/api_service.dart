import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:finfresh_machin_task/model/product_model.dart';
import '../../util/app_exception/app_exception.dart';
import '../../util/typedef/type_def.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../local_data_base/local_storage.dart';

class Api {
  static final Map<String, String> _header = {
    'Content-Type': 'application/json',
    'usertoken': ''
  };

  static EitherResponse getApi(String url, [String? token]) async {
    final uri = Uri.parse(url);
    if (token != null) {
      _header['usertoken'] = token;
    }
    try {
      final response = await http.get(uri, headers: _header);
      final fetchedData = _getResponse(response);
      return Right(fetchedData);
    } on SocketException {
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOutException());
    } catch (e) {
      return Left(BadRequestException());
    }
  }

  static dynamic _getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException();
      default:
        throw BadRequestException();
    }
  }

  static Future<String> downloadAndSaveImage(
      String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/$fileName';
      final file = File(imagePath);
      await file.writeAsBytes(response.bodyBytes);
      return imagePath;
    } catch (e) {
      throw BadRequestException();
    }
  }

  static EitherResponse saveProductsToDatabase(
      List<ProductModel> products) async {
    final List<ProductModel> savedProducts = [];
    for (var product in products) {
      try {
        final imagePath =
            await downloadAndSaveImage(product.image, '${product.id}.jpg');
        product.localImagePath = imagePath;

        await DatabaseHelper.instance.insertProduct(product);
        savedProducts.add(product);
      } catch (e) {
        // Log the error but continue processing other products
      }
    }
    return savedProducts.isNotEmpty
        ? Right(savedProducts)
        : Left(BadRequestException());
  }
}
