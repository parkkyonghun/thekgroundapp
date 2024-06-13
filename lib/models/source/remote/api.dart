
import 'package:dio/dio.dart';



abstract class Api {
  //interface is depend on your api endpoints, your needs...etc
  Api(String appBaseUrl);

  loadProductList({required int page}) {}

  loadProductById({required BigInt id}) {}
}

//Implementation depend on your api documentation
class ApiImpl implements Api {
  final Dio dio;
  final String appBaseUrl;

  ApiImpl(this.appBaseUrl) : dio = Dio(BaseOptions(baseUrl: appBaseUrl));


  @override
  loadProductById({required BigInt id}) {
    // TODO: implement loadProductById
    throw UnimplementedError();
  }

  @override
  loadProductList({required int page}) {
    // TODO: implement loadProductList
    throw UnimplementedError();
  }
}


