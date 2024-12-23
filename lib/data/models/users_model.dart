import 'package:swipey/data/models/video_data_model.dart';

class UsersModel {
  final String name;
  final String urlImage;
  final List<VideoDataModel> video;

  UsersModel({
    required this.name,
    required this.urlImage,
    required this.video,
  });
}
