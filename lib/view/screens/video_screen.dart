import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_firebase/controllers/video_controller.dart';
import 'package:tiktok_firebase/core/constants.dart';
import 'package:tiktok_firebase/view/screens/comment_screen.dart';
import 'package:tiktok_firebase/view/widgets/circle_animation.dart';
import 'package:tiktok_firebase/view/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});
  final VideoController videoController = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        //similar to consumer in provider that gives data from controllers
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                Column(
                  children: [
                    SizedBox(height: 100),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.username,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data.caption,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        data.songName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildProfile(''),
                                ActionItems(
                                  onTap: () =>
                                      videoController.likeVideo(data.id),
                                  icon: Icons.favorite,
                                  iconColor:
                                      data.likes.contains(
                                        authController.user.uid,
                                      )
                                      ? Colors.red
                                      : Colors.white,
                                  text: data.likes.length.toString(),
                                ),
                                ActionItems(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CommentScreen(id: data.id),
                                      ),
                                    );
                                  },
                                  icon: Icons.comment,
                                  text: data.commentCount.toString(),
                                ),
                                ActionItems(
                                  onTap: () {},
                                  icon: Icons.reply,
                                  text: data.shareCount.toString(),
                                ),
                                SizedBox(height: 24),
                                CircleAnimation(
                                  child: buildMusicAlbum(data.profilePhoto),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }

  buildProfile(String profilePic) {
    return SizedBox(
      width: 70,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePic),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePic) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.grey, Colors.white],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(image: NetworkImage(profilePic), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionItems extends StatelessWidget {
  const ActionItems({
    super.key,
    this.onTap,
    required this.text,
    this.iconColor,
    this.textColor,
    required this.icon,
  });
  final Function()? onTap;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(icon, size: 40, color: iconColor ?? Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(fontSize: 20, color: textColor ?? Colors.white),
        ),
      ],
    );
  }
}
