import 'package:firstproj/utility/app_constant.dart';
import 'package:firstproj/utility/app_controller.dart';
import 'package:firstproj/utility/app_service.dart';
import 'package:firstproj/utility/app_snackbar.dart';
import 'package:firstproj/widgets/widget_button.dart';
import 'package:firstproj/widgets/widget_form.dart';
import 'package:firstproj/widgets/widget_icon_button.dart';
import 'package:firstproj/widgets/widget_image.dart';
import 'package:firstproj/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppContant().radienBox(context: context),
        child: ListView(
          children: [
            headwidget(context),
            formUser(),
            formPassword(),
            buttonLogin(),
          ],
        ),
      ),
    );
  }

  Row buttonLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: 250,
          child: WidgetButton(
            label: 'Login',
            pressFunc: () {
              if ((userController.text.isEmpty) ||
                  (passwordController.text.isEmpty)) {
                AppSnackBar(
                        context: context,
                        title: 'Have Space',
                        message: 'Please Fill Every Blank')
                    .errorSnackBar();
              } else {
                AppService().checkAuthen(
                    user: userController.text,
                    password: passwordController.text,
                    context: context);
              }
            },
          ),
        ),
      ],
    );
  }

  Row formPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => WidgetForm(
            textEditingController: passwordController,
            obsecu: appController.redEye.value,
            hint: 'Password',
            suffixWidget: WidgetIconButton(
              iconData: appController.redEye.value
                  ? Icons.visibility
                  : Icons.visibility_outlined,
              pressFunc: () {
                appController.redEye.value = !appController.redEye.value;
              },
            ),
          ),
        ),
      ],
    );
  }

  Row formUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          textEditingController: userController,
          hint: 'Username',
          suffixWidget: Icon(Icons.person_outlined),
        ),
      ],
    );
  }

  Row headwidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 100),
          child: Row(
            children: [
              const WidgetImage(
                size: 36,
              ),
              const SizedBox(
                width: 8,
              ),
              WidgetText(
                data: 'First Project',
                textStyle: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
