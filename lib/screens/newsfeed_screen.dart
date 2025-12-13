import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsfeedCard(
          userName: "eggsdoodz",
          postContent: "day 6 ♡ 25 days of eggsdoodz #art #drawing #doodle #sketckbook #quote",
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

        NewsfeedCard(
          userName: "Biand Cafe",
          postContent: "Serving joy around town. ☕️ Enjoy FREE DELIVERY for ₱300+ orders within Ligaya, Liwanag, Tabin-dagat, Liwayway, and Dapawan (Bayan) — weekdays, 9:30 AM to 3:00 PM. At oo, isama mo na ang orders ng family, friends, and workmates kaseeee group order is life! 😉",
          date: "30 minutes ago",
          numOfLikes: 89,
          hasImage: true,    
          avatarUrl: "assets/images/biand.jpg",
          imageUrl: "assets/images/biand2.jpg",

        ),

        NewsfeedCard(
          userName: "eggsdoodz",
          postContent: "day 7 ⋆.˚ᓚᘏᗢ 25 days of eggsdoodz",
          date: "Yesterday at 4:45 AM",
          numOfLikes: 401,
          hasImage: true,
          avatarUrl: "assets/images/eggs.jpg",
          imageUrl: "assets/images/catto.jpg",
        ),

        NewsfeedCard(
          userName: "eggsdoodz",
          postContent: "day 3 ⋆˚꩜｡ 25 days of eggsdoodz",
          date: "10 minutes ago",
          numOfLikes: 56,
          hasImage: true,
          avatarUrl: "assets/images/eggs.jpg", 
          imageUrl: "assets/images/post.jpg",         
        ),

        NewsfeedCard(
          userName: "Sskait",
          postContent: "Zodiac Spotify wrapped ✨ As a virgo, accurate po ito 😆",
          date: "3 hours ago",
          numOfLikes: 144,
          hasImage: true,
          imageUrl: "assets/images/pisces.jpg",
          avatarUrl: "assets/images/sskait.jpg",  
        ),

        NewsfeedCard(
          userName: "Oliver Vergara Musca Jr.",
          postContent: "working in progress",
          date: "1 hour ago",
          numOfLikes: 12,
          hasImage: true,
          imageUrl: "assets/images/wip.jpg",
          avatarUrl: "assets/images/oliver.jpg", 
        ),
      ],
    );
  }
}
