import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_instagram/features/auth/domain/entites/app_user.dart';
import 'package:clone_instagram/features/auth/presentation/components/my_text_field.dart';
import 'package:clone_instagram/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:clone_instagram/features/post/domain/entities/comment.dart';
import 'package:clone_instagram/features/post/domain/entities/post.dart';
import 'package:clone_instagram/features/post/presentation/components/comment_title.dart';
import 'package:clone_instagram/features/post/presentation/cubits/post_cubit.dart';
import 'package:clone_instagram/features/post/presentation/cubits/post_states.dart';
import 'package:clone_instagram/features/profile/domain/entites/profile_user.dart';
import 'package:clone_instagram/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:clone_instagram/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostTitle extends StatefulWidget {
  final Post post;
  final void Function()? onDeletePressed;

  const PostTitle({
    super.key,
    required this.post,
    required this.onDeletePressed,
  });

  @override
  State<PostTitle> createState() => _PostTitleState();
}

class _PostTitleState extends State<PostTitle> {
  //cubits
  late final postCubit = context.read<PostCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  bool isOwnPost = false;

  //current user
  AppUser? currentUser;

  //profile user
  ProfileUser? postUser;

  //on startup
  @override
  void initState() {
    super.initState();

    getCurrentUser();
    fetchPostUser();
  }

  void getCurrentUser() {
    final authCuibit = context.read<AuthCubit>();
    currentUser = authCuibit.currentUser;
    isOwnPost = (widget.post.userId == currentUser!.uid);
  }

  void fetchPostUser() async {
    final fetchedUser = await profileCubit.getUserProfile(widget.post.userId);
    if (fetchedUser != null) {
      setState(() {
        postUser = fetchedUser;
      });
    }
  }

  /*
  
  LIKES

  */

  //user tapped like button
  void toggleLikePost() {
    //current like status
    final isLiked = widget.post.likes.contains(currentUser!.uid);

    //optimistically like and update UI
    setState(() {
      if (isLiked) {
        widget.post.likes.remove(currentUser!.uid); //unlike
      } else {
        widget.post.likes.add(currentUser!.uid); //like
      }
    });

    //update like
    postCubit
        .toggleLikePost(widget.post.id, currentUser!.uid)
        .catchError((error) {
      //if there is an error, revert back to original values
      setState(() {
        if (isLiked) {
          widget.post.likes.add(currentUser!.uid); //revert unlike
        } else {
          widget.post.likes.remove(currentUser!.uid); //revert like
        }
      });
    });
  }

  /*
  
  COMMENTS
  
  */

  //comment text controller
  final commentTextController = TextEditingController();

  //open comment box -> user wants to type a new comment
  void openNewCommentBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add a new comment"),
        content: MyTextField(
          controller: commentTextController,
          hintText: "Type a comment",
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),

          //save button
          TextButton(
            onPressed: () {
              addComment();
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void addComment() {
    //create a new comment
    final newComment = Comment(
      id: DateTime.now().millisecond.toString(),
      postId: widget.post.id,
      userId: currentUser!.uid,
      userName: currentUser!.name,
      text: commentTextController.text,
      timestamp: DateTime.now(),
    );

    //add comment for using
    if (commentTextController.text.isNotEmpty) {
      postCubit.addComment(widget.post.id, newComment);
    }
  }

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  //show options for deletion
  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cencel"),
          ),
          //delete button
          TextButton(
            onPressed: () {
              widget.onDeletePressed!();
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          //Top section: profile pic / name / delete button
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  uid: widget.post.userId,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //profile pic
                  postUser?.profileImageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: postUser!.profileImageUrl,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : const Icon(Icons.person),

                  const SizedBox(
                    width: 10,
                  ),

                  //name
                  Text(
                    widget.post.userName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  //deleted button
                  if (isOwnPost)
                    GestureDetector(
                      onTap: showOptions,
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          ),

          //image
          CachedNetworkImage(
            imageUrl: widget.post.imageUrl,
            height: 430,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(height: 430),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          //buttons -> like, comment , timestamp
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      //like button
                      GestureDetector(
                        onTap: toggleLikePost,
                        child: Icon(
                          widget.post.likes.contains(currentUser!.uid)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.post.likes.contains(currentUser!.uid)
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      //like count
                      Text(
                        widget.post.likes.length.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                //comment button
                GestureDetector(
                  onTap: openNewCommentBox,
                  child: Icon(
                    Icons.comment,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 5),

                Text(
                  widget.post.comments.length.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),

                const Spacer(),

                //timestamp
                Text(widget.post.timestamp.day.toString() +
                    "/" +
                    widget.post.timestamp.month.toString() +
                    "/" +
                    widget.post.timestamp.year.toString()),
              ],
            ),
          ),

          //CAPTION
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                //username
                Text(
                  widget.post.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 10),

                //text
                Text(
                  widget.post.text,
                ),
              ],
            ),
          ),

          //COMMNENT SECTION
          BlocBuilder<PostCubit, PostStates>(
            builder: (context, state) {
              //LOADED
              if (state is PostsLoaded) {
                //final individual post
                final post = state.posts
                    .firstWhere((post) => (post.id == widget.post.id));

                if (post.comments.isNotEmpty) {
                  //how many comments to show
                  int showCommentCount = post.comments.length;

                  //comment section
                  return ListView.builder(
                    itemCount: showCommentCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      //get individual comment
                      final comment = post.comments[index];

                      //comment title UI
                      return CommentTitle(comment: comment);
                    },
                  );
                }
              }

              //LOADING ...
              if (state is PostsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //ERROR
              else if (state is PostsError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
