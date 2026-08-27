import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_font.dart';
import '../screens/detail_screen.dart';

class NewsfeedCard extends StatefulWidget {
  final int? postId;
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool hasImage;
  final String? imageUrl;
  final String? avatarUrl;
  final bool isAds;
  final String? adsMarket;

  const NewsfeedCard({
    super.key,
    this.postId,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes = 0,
    this.hasImage = false,
    this.imageUrl,
    this.avatarUrl,
    this.isAds = false,
    this.adsMarket,
  });

  @override
  State<NewsfeedCard> createState() => _NewsfeedCardState();
}

class _NewsfeedCardState extends State<NewsfeedCard> {
  late int likes;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    likes = widget.numOfLikes;
  }

  void _openDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          postId: widget.postId,
          userName: widget.userName,
          postContent: widget.postContent,
          date: widget.date,
          numOfLikes: likes,
          isLiked: isLiked,
          imageUrl: widget.imageUrl ?? '',
          profileImageUrl: widget.avatarUrl ?? 'assets/images/profile.jpg',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _openDetail(context),
      child: Card(
        color: const Color(0xFFF6F2F8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setSp(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: widget.avatarUrl != null
                        ? (widget.avatarUrl!.startsWith('http')
                              ? NetworkImage(widget.avatarUrl!) as ImageProvider
                              : AssetImage(widget.avatarUrl!))
                        : const AssetImage("assets/images/profile.jpg"),
                    onBackgroundImageError: (_, _) {},
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: widget.userName,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          CustomFont(
                            text: widget.date,
                            fontSize: 11.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.public, size: 14.sp, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz),
                ],
              ),

              SizedBox(height: 10.h),

              CustomFont(
                text: widget.postContent,
                fontSize: 13.sp,
                color: Colors.black,
              ),

              SizedBox(height: 10.h),

              widget.hasImage
                  ? ImagePreviewWidget(
                      imageUrl: widget.imageUrl,
                      height: widget.isAds ? 180.h : 250.h,
                    )
                  : const SizedBox(),

              SizedBox(height: 10.h),

              if (widget.isAds && widget.adsMarket != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MORE DETAILS",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            widget.adsMarket!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E3B43),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Write a comment section for ads
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: const AssetImage(
                        "assets/images/profile.jpg",
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9ECEF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: CustomFont(
                          text: "Write a comment...",
                          color: Colors.grey,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ] else ...[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: isLiked
                              ? const Color(0xFFFF709E)
                              : const Color(0xFFFF709E),
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            likes += isLiked ? 1 : -1;
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 16.sp,
                          color: const Color(0xFFFF709E),
                        ),
                        label: Text(
                          "$likes",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFF709E),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFFF709E),
                        ),
                        onPressed: () => _openDetail(context),
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          size: 16.sp,
                          color: const Color(0xFFFF709E),
                        ),
                        label: Text(
                          "Comment",
                          style: TextStyle(color: const Color(0xFFFF709E)),
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFFF709E),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.ios_share,
                          size: 16.sp,
                          color: const Color(0xFFFF709E),
                        ),
                        label: Text(
                          "Share",
                          style: TextStyle(color: const Color(0xFFFF709E)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: const AssetImage(
                        "assets/images/profile.jpg",
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9ECEF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: CustomFont(
                          text: "Write a comment...",
                          color: Colors.grey,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],

              CustomFont(
                text: "View comments",
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// IMAGE PREVIEW WIDGET
class ImagePreviewWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;

  const ImagePreviewWidget({super.key, this.imageUrl, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade200,
      ),
      child: imageUrl == null
          ? Center(
              child: Icon(Icons.image, size: 60.sp, color: Colors.grey),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: imageUrl!.startsWith("assets/")
                  ? Image.asset(imageUrl!, fit: BoxFit.cover)
                  : Image.network(imageUrl!, fit: BoxFit.cover),
            ),
    );
  }
}
