import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_font.dart';
import 'constants.dart';

class NewsfeedCard extends StatefulWidget {
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
                  backgroundImage: widget.avatarUrl != null
                      ? AssetImage(widget.avatarUrl!)
                      : const AssetImage("assets/images/profile.jpg"),
                ),

                SizedBox(width: 10),

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
              text: widget.postContent,
              fontSize: 13.sp,
              color: Colors.black,
            ),

            SizedBox(height: 10),

// ---------------- IMAGE ----------------
            widget.hasImage
                ? ImagePreviewWidget(imageUrl: widget.imageUrl)
                : SizedBox(),

            SizedBox(height: 10),

// ---------------- REACTION BUTTONS ----------------
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

// LIKE BUTTON 
TextButton.icon(
  style: TextButton.styleFrom(
    foregroundColor:
        isLiked ? Color(0xFFFF709E) : Colors.grey.shade700,
  ),
  onPressed: () {
    print("Like pressed");
    setState(() {
      isLiked = !isLiked;
      likes += isLiked ? 1 : -1;
    });
  },
  icon: Icon(
    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
    size: 15,
    color: isLiked ? Color(0xFFFF709E) : Colors.grey.shade700,
  ),
  label: Text(
    "$likes",
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: isLiked ? Color(0xFFFF709E) : Colors.grey.shade700,
    ),
  ),
),

                  // COMMENT BUTTON 
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade700,
                    ),
                    onPressed: () {
                      print("Comment pressed");
                    },
                    icon: const Icon(Icons.mode_comment_outlined, size: 15),
                    label: const Text(
                      "Comment",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // SHARE BUTTON 
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade700,
                    ),
                    onPressed: () {
                      print("Share pressed");
                    },
                    icon: const Icon(Icons.share_outlined, size: 15),
                    label: const Text(
                      "Share",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
