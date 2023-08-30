import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:firstproj/models/products_model.dart';
import 'package:firstproj/models/user_model.dart';
import 'package:firstproj/states/main_home.dart';
import 'package:firstproj/utility/app_controller.dart';
import 'package:firstproj/utility/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> editName({required ProductsModel productsModel ,required String name}) async {
    String urlApi = 'https://www.androidthai.in.th/fluttertraining/KLao/editName.php?isAdd=true&id=${productsModel.id}&name=$name';
    await dio.Dio().get(urlApi).then((value) {
      readAllProduct();
    });
  }

  Future<void> deleteProduct({required ProductsModel productsModel}) async {
    String urlApi = 'https://www.androidthai.in.th/fluttertraining/KLao/deleteWhereId.php?isAdd=true&id=${productsModel.id}';
    await dio.Dio().get(urlApi).then((value) {
      readAllProduct();

    });
  }

  Future<void> readAllProduct() async {
    if (appController.productsModel.isNotEmpty) {
      appController.productsModel.clear();
    }

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/KLao/getAllProduct.php';
    await dio.Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        ProductsModel productsModel = ProductsModel.fromMap(element);
        appController.productsModel.add(productsModel);
      }
    });
  }

  Future<void> processUploadAndInserdata(
      {required String name, required String detail}) async {
    String nameFile = basename(appController.files.last.path);
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/KLao/saveFile.php';
    print('NameFile --> $nameFile');

    Map<String, dynamic> map = {};
    map['file'] = await dio.MultipartFile.fromFile(
        appController.files.last.path,
        filename: nameFile);
    dio.FormData data = dio.FormData.fromMap(map);
    await dio.Dio().post(urlApi, data: data).then((value) async {
      String urlImage =
          'https://www.androidthai.in.th/fluttertraining/KLao/upload/$nameFile';
      print('urlImage --> $urlImage');

      String urlInsert =
          'https://www.androidthai.in.th/fluttertraining/KLao/insertProduct.php?isAdd=true&name=$name&detail=$detail&urlImage=$urlImage';

      await dio.Dio().get(urlInsert).then((value) {
        Get.back();
      });
    });
  }

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (result != null) {
      File file = File(result.path);
      appController.files.add(file);
    }
  }

  Future<void> checkAuthen(
      {required String user,
      required String password,
      required BuildContext context}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/KLao/getUserWhereUser.php?isAdd=true&user=$user';

    await dio.Dio().get(urlApi).then((value) {
      print('## value --> $value');

      if (value.toString() == 'null') {
        AppSnackBar(
                context: context,
                title: 'User invalid',
                message: 'No $user in my database')
            .errorSnackBar();
      } else {
        var result = json.decode(value.data);
        print('## result --> $result');
        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);
          if (password == userModel.password) {
            //Authen success
            AppSnackBar(
                    context: context,
                    title: 'Success',
                    message: 'Welcome ${userModel.name} to Application')
                .normalSnackBar();

            Get.offAll(const MainHome());
          } else {
            AppSnackBar(
                    context: context,
                    title: 'Password not found',
                    message: 'Please try')
                .errorSnackBar();
          }
        }
      }
    });
  }
}
