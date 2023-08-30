import 'package:firstproj/utility/app_controller.dart';
import 'package:firstproj/utility/app_dialog.dart';
import 'package:firstproj/utility/app_service.dart';
import 'package:firstproj/utility/app_snackbar.dart';
import 'package:firstproj/widgets/widget_button.dart';
import 'package:firstproj/widgets/widget_form.dart';
import 'package:firstproj/widgets/widget_image.dart';
import 'package:firstproj/widgets/widget_image_file.dart';
import 'package:firstproj/widgets/widget_text.dart';
import 'package:firstproj/widgets/widget_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  AppController appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: WidgetText(data: 'Add New Item'),
      ),
      body: ListView(
        children: [
          Obx(() {
            return appController.files.isEmpty
                ? WidgetImage(
                    path: 'images/img.png',
                    size: 200,
                    tapFunc: () {
                      print('## You tap');
                      AppDialog(context: context).normalDialog(
                          title: 'Take Photo',
                          iconWidget: WidgetImage(
                            path: 'images/img.png',
                            size: 100,
                          ),
                          firstButton: WidgetTextButton(
                            label: 'Camera',
                            pressFunc: () {
                              Get.back();
                              AppService().processTakePhoto(
                                  imageSource: ImageSource.camera);
                            },
                          ),
                          secondButton: WidgetTextButton(
                            label: 'Gallery',
                            pressFunc: () {
                              Get.back();
                              AppService().processTakePhoto(
                                  imageSource: ImageSource.gallery);
                            },
                          ));
                    },
                  )
                : WidgetImageFile(
                    file: appController.files.last,
                    size: 200,
                  );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Name : '),
                textEditingController: nameController,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Detail : '),
                textEditingController: detailController,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetButton(
                label: 'Add New Item',
                pressFunc: () {
                  if (appController.files.isEmpty) {
                    AppSnackBar(
                            context: context,
                            title: 'No image',
                            message: 'Please Select Photo')
                        .errorSnackBar();
                  } else if ((nameController.text.isEmpty) ||
                      (detailController.text.isEmpty)) {
                    AppSnackBar(
                            context: context,
                            title: 'Have Space',
                            message: 'Fill Every Blank')
                        .errorSnackBar();
                  } else {

                    AppService().processUploadAndInserdata(name: nameController.text, detail:detailController.text);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
