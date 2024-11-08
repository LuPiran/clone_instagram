import 'dart:typed_data';

import 'package:clone_instagram/features/post/domain/entities/comment.dart';
import 'package:clone_instagram/features/post/domain/entities/post.dart';
import 'package:clone_instagram/features/post/domain/repositorys/post_repository.dart';
import 'package:clone_instagram/features/post/presentation/cubits/post_states.dart';
import 'package:clone_instagram/features/storage/domain/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostStates> {
  final PostRepository postRepository;
  final StorageRepository storageRepository;

  PostCubit({
    required this.postRepository,
    required this.storageRepository,
  }) : super(PostsInitial());

  //create a new post
  Future<void> createPost(Post post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      //handle image upload for mobile plataforms (using file path)
      if (imagePath != null) {
        emit(PostUploading());
        imageUrl =
            await storageRepository.uploadPostImageMobile(imagePath, post.id);
      }
      //handle image upload for web plataforms (using file bytes)
      else if (imageBytes != null) {
        emit(PostUploading());
        imageUrl =
            await storageRepository.uploadPostImageWeb(imageBytes, post.id);
      }

      //give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      //create post in the backend
      postRepository.creaetePost(newPost);

      //re-fetch all posts
      fetchAllPosts();
    } catch (e) {
      emit(PostsError("Failed to create post: $e"));
    }
  }

  //featch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostsLoading());
      final posts = await postRepository.fetchAllPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError("Failed to fetch posts: $e"));
    }
  }

  //delete a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepository.deletePost(postId);
    } catch (e) {}
  }

  //toggle like on a post
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      await postRepository.toggleLikePost(postId, userId);
    } catch (e) {
      emit(PostsError("Failed to toggle likes: $e"));
    }
  }

  //add a comment to a post
  Future<void> addComment(String postId, Comment comment) async {
    try {
      await postRepository.addComment(postId, comment);
      await fetchAllPosts();
    } catch (e) {
      emit(PostsError("Failed to add comment: $e"));
    }
  }

  //delete comment from a post
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await postRepository.deleteComment(postId, commentId);
      await fetchAllPosts();
    } catch (e) {
      emit(PostsError("Failed to delete comment: $e"));
    }
  }
}
