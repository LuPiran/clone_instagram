import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_instagram/features/auth/presentation/components/my_text_field.dart';
import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';
import 'package:clone_instagram/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:clone_instagram/features/profile/presentation/cubits/profile_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //mobile image pick
  PlatformFile? imagePickedFile;

  //web image pick
  Uint8List? webImage;

  //bio text controler
  final bioTextController = TextEditingController();

  //pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  //update profile button pressed
  void updateProfile() async {
    //profile cubit
    final profileCubit = context.read<ProfileCubit>();

    //prepare image e data
    final String uid = widget.user.uid;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebBytes = kIsWeb ? imagePickedFile?.bytes : null;
    final String? newBio =
        bioTextController.text.isNotEmpty ? bioTextController.text : null;

    //only update profile if there is something to update
    if (imagePickedFile != null || newBio != null) {
      profileCubit.updateProfile(
        uid: uid,
        newBio: newBio,
        imageMobilePath: imageMobilePath,
        imagesWebBytes: imageWebBytes,
      );
    }
    //nothing to update -> go to previous page
    else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        //profile loading ...
        if (state is ProfileLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Uploading..."),
                ],
              ),
            ),
          );
        } else {
          //edit form
          return buildEditPage();
        }
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //save button
          IconButton(
            onPressed: updateProfile,
            icon: Icon(
              Icons.upload,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //profile picture
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.hardEdge,
              child:
                  //display selected image for mobile
                  (!kIsWeb && imagePickedFile != null)
                      ? Image.file(
                          File(imagePickedFile!.path!),
                          fit: BoxFit.cover,
                        )
                      :
                      // display selected image for web
                      (kIsWeb && webImage != null)
                          ? Image.memory(
                              webImage!,
                              fit: BoxFit.cover,
                            )
                          :
                          //no image selected -> display existing profile pic
                          CachedNetworkImage(
                              imageUrl: widget.user.profileImageUrl,
                              //loading ...
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              //error -> failed to load
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 72,
                              ),
                              //loaded
                              imageBuilder: (context, imageProvider) =>
                                  Image(image: imageProvider),
                            ),
            ),
          ),

          const SizedBox(height: 25),

          //pick image button
          Center(
            child: MaterialButton(
              onPressed: pickImage,
              color: Theme.of(context).colorScheme.tertiary,
              child: const Text(
                "Pick Image",
              ),
            ),
          ),

          //bio
          const Text("Bio"),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: MyTextField(
              controller: bioTextController,
              hintText: widget.user.bio,
            ),
          ),
        ],
      ),
    );
  }
}
