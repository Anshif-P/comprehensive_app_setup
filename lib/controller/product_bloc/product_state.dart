part of 'product_bloc.dart';

abstract class ProductState {}

final class ProductInitial extends ProductState {}

class ProductFetchSuccessState extends ProductState {
  List<ProductModel> productList;
  ProductFetchSuccessState({required this.productList});
}

class ProductFetchErrorState extends ProductState {
  String message;
  ProductFetchErrorState({required this.message});
}

class ProductFetchLoadingState extends ProductState {}

class ProductStoredLocalySuccessState extends ProductState {}

class OfflineProductFetchSuccessState extends ProductState {
  List<ProductModel> productList;
  OfflineProductFetchSuccessState({required this.productList});
}

class OfflineProductFetchFailedState extends ProductState {
  String message;
  OfflineProductFetchFailedState({required this.message});
}

class LocalProductNotFoundState extends ProductState {}
