import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finfresh_machin_task/model/product_model.dart';
import 'package:finfresh_machin_task/repositories/product_repo.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProducttsEvent>(getProducttsEvent);
    on<ImageDownloadAndStoreInfoLoacalyEvent>(
        imageDownloadAndStoreInfoLoacalyEvent);
    on<GetOfflineProductDetailsInDatabaseEvent>(
        getOfflineProductDetailsInDatabaseEvent);
  }
  List<ProductModel> productsList = [];

  Future<FutureOr<void>> getProducttsEvent(
      GetProducttsEvent event, Emitter<ProductState> emit) async {
    emit(ProductFetchLoadingState());
    final either = await ProductRepo().getProducts();
    either.fold((error) => emit(ProductFetchErrorState(message: error.message)),
        (response) {
      List product = response;
      productsList = product.map((e) => ProductModel.fromJson(e)).toList();
      print('GetProductBloc ______________-- $productsList');
      emit(ProductFetchSuccessState(productList: productsList));
      add(ImageDownloadAndStoreInfoLoacalyEvent());
    });
  }

  FutureOr<void> imageDownloadAndStoreInfoLoacalyEvent(
      ImageDownloadAndStoreInfoLoacalyEvent event,
      Emitter<ProductState> emit) async {
    print('this is in side the imagedownload bloc--------------------------- ');
    print('products url to download ${productsList[0].image}');
    final either = await ProductRepo().saveProductTodatabase(productsList);
    either.fold(
      (error) => emit(ProductFetchErrorState(message: error.message)),
      (response) {
        print(
            'imageDownloadAndstoreInfoLocalybloc  ______________-- $response');

        emit(ProductFetchSuccessState(productList: response));
      },
    );
  }

  FutureOr<void> getOfflineProductDetailsInDatabaseEvent(
      GetOfflineProductDetailsInDatabaseEvent event,
      Emitter<ProductState> emit) async {
    emit(ProductFetchLoadingState());
    try {
      final List<ProductModel> localProductsList =
          await ProductRepo().getLocalStorageProduct();
      print('product List in bloc ${localProductsList.length}');
      if (localProductsList.isEmpty) {
        print('is empty ');
        emit(LocalProductNotFoundState());
      } else {
        print('is not empty');
        print('new local data ${localProductsList.length}');
        emit(OfflineProductFetchSuccessState(productList: localProductsList));
      }
    } catch (e) {
      print('is error $e');
      emit(OfflineProductFetchFailedState(message: e.toString()));
    }
  }
}
