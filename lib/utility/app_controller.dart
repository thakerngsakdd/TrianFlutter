import 'dart:io';

import 'package:firstproj/models/products_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;
  RxList <File> files = <File>[].obs;
  RxList <ProductsModel> productsModel = <ProductsModel>[].obs;
}
