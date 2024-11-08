import 'dart:io';
import 'dart:typed_data';
import 'package:clone_instagram/features/auth/presentation/components/my_text_field.dart';
import 'package:clone_instagram/features/post/domain/entities/post.dart';
import 'package:clone_instagram/features/post/presentation/cubits/post_cubit.dart';
import 'package:clone_instagram/features/post/presentation/cubits/post_states.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:clone_instagram/features/auth/domain/entites/app_user.dart';
import 'package:clone_instagram/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  //mobile image pick
  PlatformFile? imagePickedFile;

  //web image pick
  Uint8List? webImage;

  //text controller -> caption
  final textController = TextEditingController();

  //Current user
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //get current user
  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

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

  //create & upload post
  void uploadPost() {
    //check if both image and caption are provider
    if (imagePickedFile == null || textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both image and caption are required"),
        ),
      );
    }

    //create a new post object
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser!.uid,
      userName: currentUser!.name,
      text: textController.text,
      imageUrl: '',
      timestamp: DateTime.now(),
      likes: [],
      comments: [],
    );

    //post cubit
    final postCubit = context.read<PostCubit>();

    //web upload
    if (kIsWeb) {
      postCubit.createPost(newPost, imageBytes: imagePickedFile?.bytes);
    }

    //mobile upload
    else {
      postCubit.createPost(newPost, imagePath: imagePickedFile?.path);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //BLOC CONSUMER -> builder + listener
    return BlocConsumer<PostCubit, PostStates>(
      builder: (context, state) {
        //loading or uploading ...
        if (state is PostsLoading || state is PostUploading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //build upload page
        return buildUploadPage();
      },
      //go to previous page when upload is done e posts are loaded
      listener: (context, state) {
        if (state is PostsLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildUploadPage() {
    //SCAFFOLD
    return Scaffold(
      //APP BAR
      appBar: AppBar(
        title: const Text("Create Post"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //upload button
          IconButton(
            onPressed: uploadPost,
            icon: Icon(
              Icons.upload,
            ),
          ),
        ],
      ),

      //BODY
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //image preview  for web
              if (kIsWeb && webImage != null) Image.memory(webImage!),

              //image preview for mobile
              if (!kIsWeb && imagePickedFile != null)
                Image.file(File(imagePickedFile!.path!)),

              //pick image button
              MaterialButton(
                onPressed: pickImage,
                color: Theme.of(context).colorScheme.tertiary,
                child: const Text("Pick Image"),
              ),

              MyTextField(
                controller: textController,
                hintText: "Caption",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
