import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sampleapp/Views/dashBoard_page/widgets/step_tracker_app.dart';
import 'package:sampleapp/Views/dashBoard_page/widgets/challenges.dart';
import 'package:sampleapp/Views/dashBoard_page/widgets/stat_widget.dart';
import 'package:sampleapp/values/strings.dart';

class DashboardScreen extends StatefulWidget {
  final String? userName;

  const DashboardScreen({super.key, this.userName});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final int steps = 259;
  final int steps2 = 459;

  final int targetSteps = 2000;
  final int anotherSteps = 800;


  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _secondAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.0, end: steps / targetSteps)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _secondAnimation = Tween<double>(begin: 0.0, end: steps / targetSteps)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Center(
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 55.h,
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                          size: 29,
                          color: Colors.purple[200],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.favorite,
                          size: 29,
                          color: Colors.purple[200],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 7, right: 7, top: 4, bottom: 4),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.gif_box,
                          size: 23,
                          color: Colors.purple[200],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Rewards",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "${Strings.goodMorning} ${widget.userName}!",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Column(
              children: [
                Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(170),
                        topLeft: Radius.circular(170)),
                    color: Colors.purple[100],
                  ),
                  margin: const EdgeInsets.only(left: 40),
                  padding: EdgeInsets.only(right: 15.sp, left: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProgressCircle(
                          _animation, _secondAnimation, steps, targetSteps),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const StatWidget(
                              icon: Icons.location_on,
                              value: "0.1",
                              label: "Kms",
                              color: Colors.red,
                            ),
                            const StatWidget(
                              icon: Icons.local_fire_department,
                              value: "190",
                              label: "Cal",
                            ),
                            StatWidget(
                              icon: Icons.monetization_on,
                              value: "24",
                              label: "Coins",
                              color: Colors.yellow[200],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10),
              child: Text(
                Strings.resumePlaying,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const VideoCarousel(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Challenge",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.deepPurple[600],
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                       SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 25,
                        color: Colors.deepPurple[600],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const ChallengeScreen(),
            _buildAchievementsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCircle(Animation<double> secondAnimation,
      Animation<double> animation, int currentSteps, int totalSteps) {
    return Stack(
      children: [
        CircularPercentIndicator(
          radius: 75.0,
          lineWidth: 15.0,
          percent: .55, //animation.value,
          animation: true,
          animationDuration: 4000,
          center: Text(
            "$currentSteps\nof $totalSteps steps",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.purple[400],
          backgroundColor: Colors.purple.withOpacity(.3),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: CircularPercentIndicator(
            widgetIndicator: const Icon(
              Icons.monetization_on,
              color: Colors.amber,
              size: 20,
            ),
            radius: 60,
            lineWidth: 6.0,
            percent: .65,
            animation: true,
            animationDuration: 3000,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.amber,
            backgroundColor: Colors.purple.withOpacity(.0),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Achievements",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ), ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                          color: Colors.deepPurple[600],
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                     SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 25,
                      color: Colors.deepPurple[600],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 10),
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 80,
                          margin: const EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.emoji_events,
                              size: 40,
                            ),
                          ),
                        ),
                        Container(
                          height: 95.h,
                          width: 245.w,
                          margin: const EdgeInsets.only(left: 4, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monthly Mania",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Walk 100,000 steps",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 24.h,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.money_off_csred_outlined,
                                          color: Colors.amber,
                                          size: 16.sp,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '24',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "55% ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.purple[800]),
                                            ),
                                            Text(
                                              "Completed ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 130,
                                          height: 5,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(200),),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                             borderRadius: BorderRadius.circular(4),
                                            child: LinearProgressIndicator(
                                              value: 0.55, // example values
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.deepPurple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 80,
                          margin: const EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.emoji_events,
                              size: 40,
                            ),
                          ),
                        ),
                        Container(
                          height: 95.h,
                          width: 245.w,
                          // color: Colors.red,
                          margin: const EdgeInsets.only(left: 4, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monthly Mania",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Walk 100,000 steps",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 24.h,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.money_off_csred_outlined,
                                          color: Colors.amber,
                                          size: 16.sp,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '24',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "15% ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.purple[800]),
                                            ),
                                            Text(
                                              "Completed ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 130,
                                          height: 5,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                                                                         borderRadius: BorderRadius.circular(4),

                                            child: LinearProgressIndicator(
                                              value: 0.15, // example values
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.deepPurple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 80,
                          margin: const EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.emoji_events,
                              size: 40,
                            ),
                          ),
                        ),
                        Container(
                          height: 95.h,
                          width: 245.w,
                          // color: Colors.red,
                          margin: const EdgeInsets.only(left: 4, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monthly Mania",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Walk 100,000 steps",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 24.h,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.money_off_csred_outlined,
                                          color: Colors.amber,
                                          size: 16.sp,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '24',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "35% ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.purple[800]),
                                            ),
                                            Text(
                                              "Completed ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 130,
                                          height: 5,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                                                                         borderRadius: BorderRadius.circular(4),

                                            child: LinearProgressIndicator(
                                              value: 0.35, // example values
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.deepPurple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 80,
                          margin: const EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.emoji_events,
                              size: 40,
                            ),
                          ),
                        ),
                        Container(
                          height: 95.h,
                          width: 245.w,
                          // color: Colors.red,
                          margin: const EdgeInsets.only(left: 4, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monthly Mania",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Walk 100,000 steps",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 24.h,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.money_off_csred_outlined,
                                          color: Colors.amber,
                                          size: 16.sp,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '24',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "96% ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.purple[800]),
                                            ),
                                            Text(
                                              "Completed ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 130,
                                          height: 5,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                                                                         borderRadius: BorderRadius.circular(4),

                                            child: LinearProgressIndicator(
                                              value: 0.85, // example values
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.deepPurple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 80,
                          margin: const EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.emoji_events,
                              size: 40,
                            ),
                          ),
                        ),
                        Container(
                          height: 95.h,
                          width: 245.w,
                          // color: Colors.red,
                          margin: const EdgeInsets.only(left: 4, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Monthly Mania",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Walk 100,000 steps",
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 24.h,
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.money_off_csred_outlined,
                                          color: Colors.amber,
                                          size: 16.sp,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '24',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "5% ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.purple[800]),
                                            ),
                                            Text(
                                              "Completed ",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 130,
                                          height: 5,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: ClipRRect(
                                                                                         borderRadius: BorderRadius.circular(4),

                                            child: LinearProgressIndicator(
                                              value: 0.05, // example values
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.deepPurple),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

