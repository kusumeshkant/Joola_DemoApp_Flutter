import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampleapp/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoCarousel extends StatefulWidget {
  const VideoCarousel({super.key});

  @override
  _VideoCarouselState createState() => _VideoCarouselState();
}

class _VideoCarouselState extends State<VideoCarousel> {
  late VideoPlayerController _videoController1;
  late VideoPlayerController _videoController2;
  int _currentIndex = 0;

  final List<VideoModel> _videos = [
    VideoModel(title: 'Grip, Stance, and Swing', videoUrl: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4', thumbnail: 'assets/video_thumbnail_1.png', remainingTime: 'only 7 mins remaining'),
      VideoModel(title: 'Backhand Techniques', videoUrl: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4', thumbnail: 'assets/video_thumbnail_2.png', remainingTime: 'only 5 mins remaining'),
  ];

  @override
  void initState() {
    super.initState();
    _videoController1 =  VideoPlayerController.networkUrl(Uri.parse(_videos[0].videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
    _videoController2 =
        VideoPlayerController.networkUrl(Uri.parse(_videos[1].videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoController1.dispose();
    _videoController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _videos.length,
          options: CarouselOptions(
            height: 200.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.964,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return _buildVideoCard(itemIndex);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _videos.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() => _currentIndex = entry.key);
              },
              child: Container(
                width: _currentIndex == entry.key ? 25.0 : 8,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: _currentIndex == entry.key
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius: _currentIndex == entry.key
                      ? BorderRadius.circular(15)
                      : null,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.deepPurple)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVideoCard(int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .49,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              image: DecorationImage(
                image: AssetImage("assets/sport_1.avif"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_filled,
                size: 80,
                color: Colors.grey.withOpacity(.4),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .222,
            width: MediaQuery.of(context).size.width * .472,
            padding: const EdgeInsets.only(top: 10, bottom: 15, left: 11, right: 9),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _videos[index].title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _videos[index].remainingTime,
                      style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                    ),
                    const SizedBox(width: 50),
                    Container(
                      height: 4,
                      margin: const EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: index == 0 ? 0.8 : 0.5, 
                          backgroundColor: Colors.grey,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
