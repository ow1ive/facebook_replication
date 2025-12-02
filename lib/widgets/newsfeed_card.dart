import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_font.dart';
import 'constants.dart';

class NewsfeedCard extends StatelessWidget {
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool hasImage;
  final String? imageUrl;
  final String? avatarUrl;

  const NewsfeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes = 0,
    this.hasImage = false,
    this.imageUrl,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF6F2F8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- PROFILE ROW ----------------
            Row(
              children: [
                
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: avatarUrl != null
                      ? AssetImage(avatarUrl!)
                      : const AssetImage("assets/images/profile.jpg"),
                ),

                SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: userName,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        CustomFont(
                          text: date,
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.public, size: 14.sp, color: Colors.grey),
                      ],
                    ),
                  ],
                ),

                const Spacer(),
                const Icon(Icons.more_horiz),
              ],
            ),

            SizedBox(height: 10),

            // ---------------- POST CONTENT ----------------
            CustomFont(
              text: postContent,
              fontSize: 13.sp,
              color: Colors.black,
            ),

            SizedBox(height: 10),

            // ---------------- IMAGE OR PLACEHOLDER ----------------
            hasImage ? ImagePreviewWidget(imageUrl: imageUrl) : SizedBox(),

            SizedBox(height: 10),

            // ---------------- REACTION BUTTONS ----------------
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  PostActionButton(icon: Icons.thumb_up_alt_outlined, label: "Like"),
                  PostActionButton(icon: Icons.comment_outlined, label: "Comment"),
                  PostActionButton(icon: Icons.share_outlined, label: "Share"),
                ],
              ),
            ),

            SizedBox(height: 10),

            // ---------------- COMMENT FIELD ----------------
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.black),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFE9ECEF),
                      borderRadius: BorderRadius.circular(10),
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

            SizedBox(height: 10),

            CustomFont(
              text: "View comments",
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

//
// IMAGE PLACEHOLDER WIDGET

class ImagePreviewWidget extends StatelessWidget {
  final String? imageUrl;

  const ImagePreviewWidget({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: imageUrl == null
          ? Center(child: Icon(Icons.image, size: 60, color: Colors.grey))
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl!.startsWith("assets/")
                  ? Image.asset(imageUrl!, fit: BoxFit.cover)
                  : Image.network(imageUrl!, fit: BoxFit.cover),
            ),
    );
  }
}

// POST ACTION BUTTON
class PostActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const PostActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade700),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
