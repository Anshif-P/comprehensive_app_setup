import 'dart:io';
import 'package:finfresh_machin_task/controller/user_bloc/user_bloc.dart';
import 'package:finfresh_machin_task/util/snack_bar/snack_bar.dart';
import 'package:finfresh_machin_task/util/validation/form_validation.dart';
import 'package:finfresh_machin_task/widgets/profile_widgets/buttom_widget.dart';
import 'package:finfresh_machin_task/widgets/profile_widgets/text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserDetailsFromDatabaseEvent());
  }

  String imagePath = '';

  int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is GetUserDetailsSuccessState) {
                    userId = state.userDetails.id;
                    imagePath = state.userDetails.imagePath!;
                    print('GetUserSuccessStat  ${state.userDetails.imagePath}');

                    return CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            FileImage(File(state.userDetails.imagePath!)));
                  }
                  if (state is ImageUpdateSuccessState) {
                    return CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(File(state.imagePath)));
                  }
                  return const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/download.jpg'),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 35,
            ),
            ButtonWidget(
                onpressFunction: () {
                  if (imagePath != '') {
                    print('validation ok ');
                    context.read<UserBloc>().add(AddUserDetailsToDatabase(
                        imagePath: imagePath, userId: userId));
                    print(' image $imagePath');
                  } else {
                    CustomSnackBar.showSnackBar(context, 'Add Image');
                  }
                },
                text: 'Update',
                colorCheck: true),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imagePath = pickedImage.path;
      print('image path is available ');

      context.read<UserBloc>().add(UpdateImageEvent(imagePath: imagePath));
    }
  }
}
