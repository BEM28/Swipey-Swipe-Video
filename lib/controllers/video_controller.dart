import 'package:get/get.dart';
import 'package:swipey/data/models/comment_video_model.dart';
import 'package:swipey/data/models/users_model.dart';
import 'package:swipey/data/models/video_data_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  RxList<UsersModel> datas = <UsersModel>[].obs;
  late List<YoutubePlayerController> videoScrollControllers = [];

  @override
  void onInit() async {
    super.onInit();
    _loadDummyData();
  }

  @override
  void onClose() {
    for (final controller in videoScrollControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void _loadDummyData() async {
    datas.value = [
      // Menambahkan data video
      UsersModel(
        name: "Micheal",
        urlImage:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsNWPhXbh68-pBV7iNSR76TAgOVQRSqkuogA&s",
        video: List.generate(3, (index) {
          return VideoDataModel(
            description: "Video description ${index + 1} by Micheal.",
            urlVideo: "https://www.youtube.com/shorts/5jDrPud-h8c",
            like: 1000 + index * 100,
            comments: List.generate(3, (commentIndex) {
              return CommentVideoModel(
                name: "Commenter ${commentIndex + 1}",
                urlImage:
                    "https://web.rupa.ai/wp-content/uploads/2023/08/aruna3619_An_Asian_young_man_standing_against_a_minimalist_offi_d1957f73-3bf2-49d0-b48b-b1cb37540c09.png",
                comment: "Nice video ${index + 1}!",
              );
            }),
          );
        }),
      ),
      UsersModel(
        name: "Sophia",
        urlImage:
            "https://www.charleskeith.co.id/on/demandware.static/-/Library-Sites-CharlesKeithID/default/dwd3146f5b/images/brand-profile/charles-keith-spring-24-library-archive-page-01-m.jpg",
        video: List.generate(5, (index) {
          return VideoDataModel(
            description: "Delicious food recipe ${index + 1} by Sophia.",
            urlVideo: "hhttps://www.youtube.com/shorts/FPFM_zfPeeM",
            like: 1500 + index * 150,
            comments: List.generate(2, (commentIndex) {
              return CommentVideoModel(
                name: "Foodie ${commentIndex + 1}",
                urlImage:
                    "https://web.rupa.ai/wp-content/uploads/2023/08/aruna3619_An_Asian_young_man_standing_against_a_minimalist_offi_d1957f73-3bf2-49d0-b48b-b1cb37540c09.png",
                comment: "Yummy recipe ${index + 1}!",
              );
            }),
          );
        }),
      ),
      UsersModel(
        name: "Liam",
        urlImage:
            "https://shanibacreative.com/wp-content/uploads/2020/06/membuat-foto-profil-yang-bagus.jpg",
        video: List.generate(4, (index) {
          return VideoDataModel(
            description: "Adventure ${index + 1} by Liam.",
            urlVideo: "https://www.youtube.com/shorts/zlXDOPDlJDc",
            like: 2000 + index * 200,
            comments: List.generate(4, (commentIndex) {
              return CommentVideoModel(
                name: "Explorer ${commentIndex + 1}",
                urlImage:
                    "https://web.rupa.ai/wp-content/uploads/2023/08/aruna3619_An_Asian_young_man_standing_against_a_minimalist_offi_d1957f73-3bf2-49d0-b48b-b1cb37540c09.png",
                comment: "Awesome adventure ${index + 1}!",
              );
            }),
          );
        }),
      ),
      UsersModel(
        name: "Emma",
        urlImage:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8KCxnBtiYuIhil5pe4NkMV1eOaThD1s3MAOIg75EuI7XVb3SzipiCtfnZsTbTXe2P-4w",
        video: List.generate(6, (index) {
          return VideoDataModel(
            description: "Fashion style ${index + 1} by Emma.",
            urlVideo: "https://www.youtube.com/shorts/GTUwshxDNs8",
            like: 3000 + index * 300,
            comments: List.generate(3, (commentIndex) {
              return CommentVideoModel(
                name: "Fan ${commentIndex + 1}",
                urlImage:
                    "https://web.rupa.ai/wp-content/uploads/2023/08/aruna3619_An_Asian_young_man_standing_against_a_minimalist_offi_d1957f73-3bf2-49d0-b48b-b1cb37540c09.png",
                comment: "Love this style ${index + 1}!",
              );
            }),
          );
        }),
      ),
    ];

    await getVideos();
  }

  Future<void> getVideos() async {
    try {
      // Mengisi videoScrollControllers untuk semua video
      for (var data in datas) {
        videoScrollControllers.addAll(
          _createYoutubeControllers(data.video, autoPlay: true),
        );
      }
    } catch (e) {
      print('Error in getVideos: $e');
    }
  }

  List<YoutubePlayerController> _createYoutubeControllers(
      List<VideoDataModel> urls,
      {required bool autoPlay}) {
    return urls.map((url) {
      String videoId = YoutubePlayer.convertUrlToId(url.urlVideo) ?? '';
      return YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: autoPlay,
          mute: false,
          disableDragSeek: true,
        ),
      );
    }).toList();
  }
}
