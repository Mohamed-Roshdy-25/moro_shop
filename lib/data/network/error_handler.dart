import 'package:dio/dio.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      failure = _handleError(error);
    }
    else{
      failure = DataSource.unKnown.getFailure();
    }
  }

  Failure _handleError(DioError error){
    switch(error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.recieveTimeout.getFailure();
      case DioErrorType.badCertificate:
        return DataSource.badCertificate.getFailure();
      case DioErrorType.badResponse:
        if(error.response != null && error.response?.statusMessage != null&& error.response?.statusCode != null){
          return Failure(false, error.response?.statusMessage??AppStrings.unKnownError);
        }else{
          return DataSource.unKnown.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.connectionError:
        return DataSource.connectionError.getFailure();
      case DioErrorType.unknown:
        return DataSource.unKnown.getFailure();
    }
  }
}

enum DataSource {
  connectionTimeout,
  recieveTimeout,
  sendTimeout,
  badCertificate,
  connectionError,
  cancel,
  cacheError,
  noInternetConnection,
  unKnown,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.connectionTimeout:
        return Failure(
            false, ResponseMessage.connectionTimeout);
      case DataSource.cancel:
        return Failure(false, ResponseMessage.cancel);
      case DataSource.recieveTimeout:
        return Failure(
            false, ResponseMessage.recieveTimeout);
      case DataSource.sendTimeout:
        return Failure(false, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(false, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(false,
            ResponseMessage.noInternetConnection);
      case DataSource.unKnown:
        return Failure(false, ResponseMessage.unKnown);
      case DataSource.badCertificate:
        return Failure(false, ResponseMessage.badCertificate);
      case DataSource.connectionError:
        return Failure(false, ResponseMessage.badCertificate);
    }
  }
}

class ResponseMessage{
  static const String connectionTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.requestCanceled;
  static const String recieveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String unKnown = AppStrings.unKnownError;
  static const String badCertificate = AppStrings.badCertificate;
  static const String connectionError = AppStrings.connectionError;
}