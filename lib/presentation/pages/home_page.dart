import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipey/controllers/video_controller.dart';
import 'package:swipey/presentation/widgets/menu_item.dart';
import 'package:swipey/utils/app_image.dart';
import 'package:swipey/utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            PageView.builder(
                itemCount: controller.datas.length,
                controller: PageController(
                  initialPage: 0,
                  viewportFraction: 1,
                ),
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {},
                itemBuilder: (context, index) {
                  final data = controller.datas[index];
                  return Stack(
                    children: [
                      for (int x = 0; x < data.video.length; x++) ...{
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: YoutubePlayer(
                            controller: controller.videoScrollControllers[
                                index * data.video.length + x],
                            bottomActions: const [
                              CurrentPosition(),
                              ProgressBar(isExpanded: true),
                            ],
                          ),
                        ),
                        // //bottom bar

                        Positioned(
                            bottom: 50,
                            left: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: ClipOval(
                                    child: Image.network(
                                      data.urlImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            data.video[x].description,
                                            style: TextStyle(
                                              color: AppColors.primary
                                                  .withOpacity(0.8),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        //menu bar
                        Positioned(
                            bottom: 150,
                            right: 20,
                            child: Column(
                              children: [
                                buildMenuItem(
                                  imagePath: AppImage.like,
                                  count: data.video[x].like.toString(),
                                  size: 50,
                                ),
                                const SizedBox(height: 25),
                                buildMenuItem(
                                  imagePath: AppImage.comment,
                                  count:
                                      data.video[x].comments.length.toString(),
                                  size: 40,
                                  onTap: () {
                                    Get.bottomSheet(Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          color: AppColors.primary,
                                        ),
                                        child: ListView.builder(
                                          itemCount:
                                              data.video[x].comments.length,
                                          itemBuilder: (context, index) {
                                            final comment =
                                                data.video[x].comments[index];
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      comment.urlImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        comment.name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .tertiary,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Text(
                                                            comment.comment,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .tertiary
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )));
                                  },
                                ),
                                const SizedBox(height: 25),
                                Image.asset(
                                  AppImage.share,
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            )),
                      },
                    ],
                  );
                }),

            //  Shadow Top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 130,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),
            // shadow bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 130,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // top bar
            Positioned(
                top: 60,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Text(
                      'For You',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppImage.user,
                      width: 50,
                      height: 50,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
