import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/post_card.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 🔹 NORMAL POSTS
        NewsfeedCard(
          userName: "eggsdoodz",
          postContent:
              "day 6 ♡ 25 days of eggsdoodz #art #drawing #doodle #sketckbook #quote",
          date: "2 hours ago",
          numOfLikes: 120,
          avatarUrl: "assets/images/eggs.jpg",
          hasImage: true,
          imageUrl: "assets/images/image1.jpg",
        ),

        NewsfeedCard(
          userName: "Art of Jared Klein",
          postContent: "Ecco food please give me stick-o",
          date: "1 hour ago",
          numOfLikes: 233,
          hasImage: true,
          avatarUrl: "assets/images/jared.jpg",
          imageUrl: "assets/images/sticko.jpg",
        ),

        // ================= ADVERTISEMENT SECTION =================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Text(
            "Advertisement",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),

        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.9,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            aspectRatio: 0.9,
          ),
          items: [
            _adItem("assets/images/catto.jpg"),
            _adItem("assets/images/post.jpg"),
            _adItem("assets/images/pisces.jpg"),
            _adItem("assets/images/eggs.jpg"),
            _adItem("assets/images/jared.jpg"),
            _adItem("assets/images/biand.jpg"),
          ],
        ),

        // 🔹 NORMAL POSTS
        NewsfeedCard(
          userName: "Biand Cafe",
          postContent:
              "Serving joy around town. ☕️ FREE DELIVERY for ₱300+ orders!",
          date: "30 minutes ago",
          numOfLikes: 89,
          hasImage: true,
          avatarUrl: "assets/images/biand.jpg",
          imageUrl: "assets/images/biand2.jpg",
        ),

        NewsfeedCard(
          userName: "Oliver Vergara Musca Jr.",
          postContent: "working in progress",
          date: "1 hour ago",
          numOfLikes: 12,
          hasImage: true,
          imageUrl: "assets/images/photo1.jpg",
          avatarUrl: "assets/images/oliver.jpg",
        ),

        // ================= ADVERTISEMENT SECTION =================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Text(
            "Advertisement",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),

        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.9,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            aspectRatio: 0.9,
          ),
          items: [
            _adItem("assets/images/photo1.jpg"),
            _adItem("assets/images/sticko.jpg"),
            _adItem("assets/images/image1.jpg"),
            _adItem("assets/images/biand2.jpg"),
            _adItem("assets/images/oliver.jpg"),
            _adItem("assets/images/profile.jpg"),
            _adItem("assets/images/catto.jpg"),
            _adItem("assets/images/pisces.jpg"),
          ],
        ),

        // 🔹 MORE NORMAL POSTS
        NewsfeedCard(
          userName: "eggsdoodz",
          postContent: "New artwork coming soon! Stay tuned 🎨",
          date: "3 hours ago",
          numOfLikes: 156,
          avatarUrl: "assets/images/eggs.jpg",
          hasImage: true,
          imageUrl: "assets/images/pisces.jpg",
        ),

        NewsfeedCard(
          userName: "Biand Cafe",
          postContent: "Today's special: Caramel Macchiato ☕️",
          date: "2 hours ago",
          numOfLikes: 201,
          hasImage: true,
          avatarUrl: "assets/images/biand.jpg",
          imageUrl: "assets/images/biand2.jpg",
        ),

        // ================= ADVERTISEMENT SECTION =================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Text(
            "Advertisement",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),

        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.9,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            aspectRatio: 0.9,
          ),
          items: [
            _adItem("assets/images/jared.jpg"),
            _adItem("assets/images/eggs.jpg"),
            _adItem("assets/images/post.jpg"),
            _adItem("assets/images/image1.jpg"),
          ],
        ),

        // 🔹 MORE NORMAL POSTS
        NewsfeedCard(
          userName: "Art of Jared Klein",
          postContent: "New commission available! DM for details",
          date: "4 hours ago",
          numOfLikes: 178,
          hasImage: true,
          avatarUrl: "assets/images/jared.jpg",
          imageUrl: "assets/images/sticko.jpg",
        ),

        NewsfeedCard(
          userName: "Oliver Vergara Musca Jr.",
          postContent: "Finished the project! 🎉",
          date: "5 hours ago",
          numOfLikes: 95,
          hasImage: true,
          imageUrl: "assets/images/photo1.jpg",
          avatarUrl: "assets/images/oliver.jpg",
        ),

        // ================= ADVERTISEMENT SECTION =================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Text(
            "Advertisement",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),

        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.9,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            aspectRatio: 0.9,
          ),
          items: [
            _adItem("assets/images/biand.jpg"),
            _adItem("assets/images/catto.jpg"),
            _adItem("assets/images/pisces.jpg"),
            _adItem("assets/images/profile.jpg"),
            _adItem("assets/images/oliver.jpg"),
          ],
        ),

        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _adItem(String imagePath) {
    return NewsfeedCard(
      userName: "Sponsored",
      postContent: "",
      date: "",
      hasImage: true,
      imageUrl: imagePath,
      avatarUrl: "assets/images/profile.jpg",
      isAds: true,
      adsMarket: 'Ikaw na ito!',
    );
  }
}
