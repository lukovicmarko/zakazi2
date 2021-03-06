import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zakazi/src/constants.dart';
import 'package:zakazi/src/screens/details/components/aboutSalon.dart';
import 'package:zakazi/src/screens/details/components/specialist.dart';
import 'package:zakazi/src/screens/details/components/specialistsCard.dart';
import 'package:zakazi/src/screens/details/components/tabs.dart';

import '../../../data/reviewsData.dart';
import '../../../data/salonsData.dart';
import '../../../models/Review.dart';
import '../../../models/Salon.dart';
import 'aboutTitle.dart';
import 'infoTab.dart';
import 'salonReview.dart';

class Body extends StatefulWidget {
  final Salon salon;

  const Body({Key? key, required this.salon}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final reviewsData = ReviewsData();

  List<Review> reviews = [];

  void getSalonReviews() async {
    await reviewsData.getReviews(widget.salon.id);
    reviews = reviewsData.reviews;
  }

  @override
  void initState() {
    getSalonReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final salonsData = Provider.of<SalonsData>(context);

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 333.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.salon.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Container(
              height: size.height / 1.5.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.salon.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                          Container(
                            width: 56.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: kGreenColor,
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            child: Center(
                              child: Text(
                                'Open',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.salon.address,
                        style: TextStyle(
                          color: kDarkGreyTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/solid/rating4stars.svg",
                            height: 18.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '(${widget.salon.numReviews} reviews)',
                            style: const TextStyle(color: Color(0XFFABAAB1)),
                          )
                        ],
                      ),
                      SizedBox(height: 28.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoTab(
                            icon: "assets/icons/stroke/Chrome(stroke).svg",
                            name: 'Website',
                            onPress: () {},
                          ),
                          InfoTab(
                            icon: "assets/icons/stroke/Phone(stroke).svg",
                            name: 'Call',
                            onPress: () {},
                          ),
                          InfoTab(
                            icon: "assets/icons/stroke/Map-pin(stroke).svg",
                            name: 'Directions',
                            onPress: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      const AboutTitle(title: "Salon specialists"),
                      SizedBox(height: 15.h),
                      Specialists(specialists: widget.salon.specialist),
                      const Tabs(),
                      salonsData.selectedTabIndex == 0
                          ? AboutSalon(salon: widget.salon)
                          : salonsData.selectedTabIndex == 1
                              ? Container()
                              : salonsData.selectedTabIndex == 2
                                  ? Container()
                                  : salonsData.selectedTabIndex == 3
                                      ? SalonReview(
                                          salon: widget.salon,
                                          reviews: reviews,
                                        )
                                      : Container()
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
