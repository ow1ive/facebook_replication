import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/post_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/custom_dialogs.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  final PostService _postService = PostService();

  User? _currentUser;
  List<Post> _posts = [];
  bool _isLoadingPosts = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await _userService.getSavedUser();
    if (!mounted) return;
    setState(() => _currentUser = user);

    if (user == null) {
      setState(() => _isLoadingPosts = false);
      return;
    }

    try {
      final posts = await _postService.getPostsByUserId(user.id);
      if (!mounted) return;
      setState(() {
        _posts = posts;
        _isLoadingPosts = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoadingPosts = false);
    }
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFont(
            text: "About Me",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18.sp, color: Colors.black54),
              SizedBox(width: 8),
              CustomFont(
                text: "Sampaloc, Manila",
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.home_outlined, size: 18.sp, color: Colors.black54),
              SizedBox(width: 8),
              CustomFont(
                text: "Poblacion, San Andres, Romblon",
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.cake_outlined, size: 18.sp, color: Colors.black54),
              SizedBox(width: 8),
              CustomFont(
                text: "March 14, 2005",
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.camera_alt_outlined, size: 18.sp, color: Colors.black54),
              SizedBox(width: 8),
              CustomFont(text: "@ow1ive", fontSize: 14.sp, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _photos() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/pic1/400/400',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50),
                );
              },
            ),
          ),
          onTap: () => customShowImageDialog(
            context,
            imageUrl: 'https://picsum.photos/seed/pic1/800/800',
          ),
        ),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/pic2/400/400',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50),
                );
              },
            ),
          ),
          onTap: () => customShowImageDialog(
            context,
            imageUrl: 'https://picsum.photos/seed/pic2/800/800',
          ),
        ),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/pic3/400/400',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50),
                );
              },
            ),
          ),
          onTap: () => customShowImageDialog(
            context,
            imageUrl: 'https://picsum.photos/seed/pic3/800/800',
          ),
        ),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/pic4/400/400',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50),
                );
              },
            ),
          ),
          onTap: () => customShowImageDialog(
            context,
            imageUrl: 'https://picsum.photos/seed/pic4/800/800',
          ),
        ),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/pic5/400/400',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50),
                );
              },
            ),
          ),
          onTap: () => customShowImageDialog(
            context,
            imageUrl: 'https://picsum.photos/seed/pic5/800/800',
          ),
        ),
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/pic6/400/400',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50),
                );
              },
            ),
          ),
          onTap: () => customShowImageDialog(
            context,
            imageUrl: 'https://picsum.photos/seed/pic6/800/800',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String routeArgument =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? '';
    final String profileName = _currentUser?.fullName.trim().isNotEmpty == true
        ? _currentUser!.fullName
        : (routeArgument.isNotEmpty ? routeArgument : 'Olive Vergara Musca');

    // 🔥 CHANGE THESE TO YOUR REAL IMAGE URLS IF FROM API
    final String coverImageUrl =
        "https://picsum.photos/800/400"; // cover from network
    final String profileImageUrl =
        _currentUser?.image ?? "https://picsum.photos/200"; // profile image

    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 🔥 COVER IMAGE WITH CACHE
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: coverImageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[300]),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                  ),
                ),

                Positioned(
                  bottom: -50,
                  left: ScreenUtil().setWidth(20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 🔥 PROFILE IMAGE WITH CACHE
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: CachedNetworkImageProvider(
                          profileImageUrl,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(55)),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: profileName,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20),
                    color: const Color.fromARGB(255, 230, 100, 159),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  Row(
                    children: [
                      CustomFont(
                        text: '15,354',
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      CustomFont(
                        text: 'followers',
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.grey,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(5)),
                      Icon(Icons.circle, size: 5.sp, color: Colors.grey),
                      SizedBox(width: ScreenUtil().setWidth(5)),
                      CustomFont(
                        text: '5',
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      CustomFont(
                        text: 'following',
                        fontSize: ScreenUtil().setSp(15),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Row(
                    children: [
                      CustomButton(buttonName: 'Follow', onPressed: () {}),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      CustomButton(
                        buttonName: 'Message',
                        buttonType: 'outlined',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: ScreenUtil().setHeight(10)),

            TabBar(
              indicatorColor: FB_DARK_PRIMARY,
              tabs: [
                Tab(
                  child: CustomFont(
                    text: 'Posts',
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  child: CustomFont(
                    text: 'About',
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  child: CustomFont(
                    text: 'Photos',
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  _isLoadingPosts
                      ? const Center(child: CircularProgressIndicator())
                      : _posts.isEmpty
                      ? Center(
                          child: CustomFont(
                            text: 'No posts yet',
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _posts.length,
                          itemBuilder: (context, index) {
                            final post = _posts[index];
                            return NewsfeedCard(
                              postId: post.id,
                              userName: profileName,
                              postContent: post.title.isNotEmpty
                                  ? '${post.title}\n\n${post.body}'
                                  : post.body,
                              date: 'Post #${post.id}',
                              numOfLikes: post.likes,
                              hasImage: false,
                              avatarUrl: _currentUser?.image,
                            );
                          },
                        ),
                  SingleChildScrollView(child: _buildAboutTab()),
                  _photos(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
