import '../widgets/custom_info.dart' as notif;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView(
        children: const [
          notif.CustomInformation(
            name: 'Olive Vergara Musca',
            post: 'loved your post',
            description: 'pisces season is here ♓️',
            date: 'March 14, 2025',
            numOfLikes: 1643,
            profileImageUrl: 'assets/images/profile.jpg',
            imageUrl: 'assets/images/pisces.jpg',
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Olive Vergara Musca',
            post: 'loved your post',
            description: 'finally made it',
            date: '1m ago',
            profileImageUrl: 'assets/images/profile.jpg',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Stranger Things',
            post: 'updated their profile picture',
            description: 'Tap to view their new profile picture',
            date: '5m ago',
            profileImageUrl: 'assets/images/st.jpg',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Olive Vergara Musca',
            post: 'loved your post',
            description: 'stack rg',
            date: '10m ago',
            profileImageUrl: 'assets/images/profile.jpg',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Tine Sombria',
            post: 'shared your post',
            description: 'wippp',
            date: '15m ago',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Tine Sombria',
            post: 'shared your post',
            description: 'wiwowiwowiwowi',
            date: '20m ago',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Olive Vergara Musca',
            post: 'loved your post',
            description: 'wiwiwiowow',
            date: '30m ago',
            profileImageUrl: 'assets/images/profile.jpg',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Tine Sombria',
            post: 'added a new post',
            description:
                'Drop Ready. The streets won\'t wait - neither should you.',
            date: '45m ago',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Olive Vergara Musca',
            post: 'shared your post',
            description: 'wippp',
            profileImageUrl: 'assets/images/profile.jpg',
            date: '1h ago',
            numOfLikes: 0,
          ),
          Divider(),

          notif.CustomInformation(
            name: 'Olive Vergara Musca',
            post: 'tagged you in a story',
            description: 'unwind time',
            profileImageUrl: 'assets/images/profile.jpg',
            date: '1h ago',
            numOfLikes: 0,
          ),
          Divider(),
        ],
      ),
    );
  }
}
