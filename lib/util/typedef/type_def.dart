import 'package:either_dart/either.dart';
import '../app_exception/app_exception.dart';

typedef EitherResponse<T> = Future<Either<AppException, T>>;
