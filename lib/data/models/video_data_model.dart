import 'package:swipey/data/models/comment_video_model.dart';

class VideoDataModel {
  final String description;
  final String urlVideo;
  final num like;
  final List<CommentVideoModel> comments;

  VideoDataModel(
      {required this.description,
      required this.urlVideo,
      required this.like,
      required this.comments});
}
