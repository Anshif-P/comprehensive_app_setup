import 'package:finfresh_machin_task/model/product_model.dart';
import 'package:finfresh_machin_task/network/api/api_service.dart';
import 'package:finfresh_machin_task/network/local_data_base/local_storage.dart';
import 'package:finfresh_machin_task/util/typedef/type_def.dart';
import '../util/app_url/app_url.dart';

class ProductRepo {
  EitherResponse getProducts() async =>
      await Api.getApi(Urls.baseUrl + Urls.getProduct);

  EitherResponse saveProductTodatabase(List<ProductModel> product) async =>
      await Api.saveProductsToDatabase(
        product,
      );

  Future<List<ProductModel>> getLocalStorageProduct() async =>
      await DatabaseHelper.instance.getProducts();
}
