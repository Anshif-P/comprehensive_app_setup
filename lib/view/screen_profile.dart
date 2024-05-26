import 'package:finfresh_machin_task/util/validation/form_validation.dart';
import 'package:finfresh_machin_task/widgets/profile_widgets/buttom_widget.dart';
import 'package:finfresh_machin_task/widgets/profile_widgets/text_feild_widget.dart';
import 'package:flutter/material.dart';

class ScreenProfile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              hintText: 'Enter Name',
              controller: nameController,
              icon: Icons.person,
              validator: (value) => Validations.emtyValidation(value),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              hintText: 'Enter Age',
              controller: nameController,
              icon: Icons.person,
              validator: (value) => Validations.emtyValidation(value),
            ),
            const SizedBox(
              height: 35,
            ),
            ButtonWidget(
                onpressFunction: () {}, text: 'Update', colorCheck: true),
          ],
        ),
      ),
    );
  }
}
