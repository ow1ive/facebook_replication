import '../widgets/notification.dart' as notif;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView(
        children: const [

          notif.Notification(
            name: 'Kirsten Amarillo',
            post: 'invited you to follow Tyrant Esports',
            description: 'Tap to view their page',
          ),
          Divider(),

          notif.Notification(
            name: 'Cali',
            post: 'loved your post',
            description: '“finally made it”',
          ),
          Divider(),

          notif.Notification(
            name: 'Stranger Things',
            post: 'updated their profile picture',
            description: '"Tap to view their new profile picture"',
          ),
          Divider(),

          notif.Notification(
            name: 'Choc',
            post: 'loved your post',
            description: 'stack rg',
          ),
          Divider(),

          notif.Notification(
            name: 'Tine Sombria',
            post: 'shared your post',
            description: 'wippp',
          ),
          Divider(),

          notif.Notification(
            name: 'Tine Sombria',
            post: 'shared your post',
            description: 'wiwowiwowiwowi',
          ),
          Divider(),

          notif.Notification(
            name: 'Tyrant Esports',
            post: 'started following you',
            description: 'You now have 653 followers',
          ),
          Divider(),

          notif.Notification(
            name: 'Slave',
            post: 'added a new post',
            description: 'Drop Ready. The streets won\'t wait - neither should you.',
          ),
          Divider(),

          notif.Notification(
            name: 'Stan',
            post: 'sent you a friend request',
            description: 'You have 32 mutual friends',
          ),
          Divider(),

          notif.Notification(
            name: 'Oliver Vergara Musca Jr.',
            post: 'tagged you in a story',
            description: 'Story will disappear in 24 hours',
          ),
          Divider(),
        ],
      ),
    );
  }
}
