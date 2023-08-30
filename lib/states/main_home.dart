import 'package:firstproj/states/add_item.dart';
import 'package:firstproj/utility/app_controller.dart';
import 'package:firstproj/utility/app_dialog.dart';
import 'package:firstproj/utility/app_service.dart';
import 'package:firstproj/widgets/widget_button.dart';
import 'package:firstproj/widgets/widget_form.dart';
import 'package:firstproj/widgets/widget_icon_button.dart';
import 'package:firstproj/widgets/widget_image_network.dart';
import 'package:firstproj/widgets/widget_text.dart';
import 'package:firstproj/widgets/widget_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    AppService().readAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('##ProductModels --> ${appController.productsModel.length}');
          return Scaffold(
            appBar: AppBar(
              title: WidgetText(data: 'Main Home'),
            ),
            floatingActionButton: WidgetButton(
              label: 'Add Item',
              pressFunc: () {
                Get.to(const AddItem())!.then((value) {
                  print('##Back');
                  appController.files.clear();
                  AppService().readAllProduct();
                });
              },
            ),
            body: appController.productsModel.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: appController.productsModel.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        AppDialog(context: context).normalDialog(
                          title: appController.productsModel[index].name,
                          iconWidget: WidgetImageNetwork(
                            urlImage:
                                appController.productsModel[index].urlImage,
                            size: 100,
                          ),
                          firstButton: WidgetTextButton(
                            label: 'Edit',
                            pressFunc: () {},
                          ),
                          secondButton: WidgetTextButton(
                            label: 'Delete',
                            pressFunc: () {
                              print(
                                  '##delete at id --> ${appController.productsModel[index].id}');
                              AppService()
                                  .deleteProduct(
                                      productsModel:
                                          appController.productsModel[index])
                                  .then((value) {
                                Get.back();
                              });
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: WidgetImageNetwork(
                                  urlImage: appController
                                      .productsModel[index].urlImage,
                                  size: 100,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      WidgetText(
                                        data: appController
                                            .productsModel[index].name,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      WidgetIconButton(
                                        iconData: Icons.edit,
                                        pressFunc: () {
                                          AppDialog(context: context)
                                              .normalDialog(
                                                  title: appController
                                                      .productsModel[index]
                                                      .name,
                                                  iconWidget:
                                                      WidgetImageNetwork(
                                                    urlImage: appController
                                                        .productsModel[index]
                                                        .urlImage,
                                                    size: 100,
                                                  ),
                                                  contentWidget: WidgetForm(
                                                    textEditingController:
                                                        textEditingController,
                                                  ),
                                                  secondButton:
                                                      WidgetTextButton(
                                                    label: 'Edit',
                                                    pressFunc: () {
                                                      if (textEditingController
                                                          .text.isNotEmpty) {
                                                        print(
                                                            '##New Name --> ${textEditingController.text}');

                                                        AppService()
                                                            .editName(
                                                                productsModel:
                                                                    appController
                                                                            .productsModel[
                                                                        index],
                                                                name:
                                                                    textEditingController
                                                                        .text)
                                                            .then((value) {
                                                              textEditingController.text = '';
                                                              Get.back();
                                                            });
                                                      }
                                                    },
                                                  ));
                                        },
                                      )
                                    ],
                                  ),
                                  WidgetText(
                                      data: appController
                                          .productsModel[index].detail),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
