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
    final either = await ProductRepo().getProducts();
    either.fold((error) => emit(ProductFetchErrorState(message: error.message)),
        (response) {
      List product = response;
      productsList = product.map((e) => ProductModel.fromJson(e)).toList();
      emit(ProductFetchSuccessState(productList: productsList));
    });
  }

  FutureOr<void> imageDownloadAndStoreInfoLoacalyEvent(
      ImageDownloadAndStoreInfoLoacalyEvent event,
      Emitter<ProductState> emit) async {
    final either = await ProductRepo().saveProductTodatabase(productsList);
    either.fold(
      (error) => emit(ProductFetchErrorState(message: error.message)),
      (response) {
        emit(ProductFetchSuccessState(productList: productsList));
      },
    );
  }

  FutureOr<void> getOfflineProductDetailsInDatabaseEvent(
      GetOfflineProductDetailsInDatabaseEvent event,
      Emitter<ProductState> emit) async {
    try {
      final List<ProductModel> productList =
          await ProductRepo().getLocalStorageProduct();
      emit(OfflineProductFetchSuccessState(productList: productList));
    } catch (e) {
      emit(OfflineProductFetchFailedState(message: e.toString()));
    }
  }
}
