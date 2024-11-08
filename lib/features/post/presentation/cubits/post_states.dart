/*

POST STATES

*/

import 'package:clone_instagram/features/post/domain/entities/post.dart';

abstract class PostStates {}

//initial
class PostsInitial extends PostStates {}

//loading...
class PostsLoading extends PostStates {}

//uploading...
class PostUploading extends PostStates {}

//error
class PostsError extends PostStates {
  final String message;
  PostsError(this.message);
}

//loaded
class PostsLoaded extends PostStates {
  final List<Post> posts;
  PostsLoaded(this.posts);
}
