part of 'product_bloc.dart';

abstract class ProductEvent {}

class GetProducttsEvent extends ProductEvent {}

class ImageDownloadAndStoreInfoLoacalyEvent extends ProductEvent {}

final class GetOfflineProductDetailsInDatabaseEvent extends ProductEvent {}
