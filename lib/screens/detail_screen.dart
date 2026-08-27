import '../widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';
import '../services/user_service.dart';

class DetailScreen extends StatefulWidget {
  final int? postId;
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool isLiked;
  final String imageUrl;
  final String profileImageUrl;

  const DetailScreen({
    super.key,
    this.postId,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes = 0,
    this.isLiked = false,
    this.imageUrl = '',
    this.profileImageUrl = '',
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final CommentService _commentService = CommentService();
  final UserService _userService = UserService();
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  late int likes;
  bool isLiked = false;

  List<Comment> comments = [];
  bool isLoadingComments = true;
  bool isSubmittingComment = false;

  @override
  void initState() {
    super.initState();
    likes = widget.numOfLikes;
    isLiked = widget.isLiked;
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    if (widget.postId == null) {
      setState(() => isLoadingComments = false);
      return;
    }

    try {
      final result = await _commentService.getCommentsByPostId(widget.postId!);
      if (!mounted) return;
      setState(() {
        comments = result;
        isLoadingComments = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => isLoadingComments = false);
    }
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty || widget.postId == null) return;

    setState(() => isSubmittingComment = true);
    try {
      final user = await _userService.getSavedUser();
      final newComment = await _commentService.addComment(
        postId: widget.postId!,
        userId: user?.id ?? 0,
        body: text,
      );
      if (!mounted) return;
      setState(() {
        comments = [newComment, ...comments];
        _commentController.clear();
      });
    } catch (_) {
      // DummyJSON's add-comment call is simulated and does not persist.
    } finally {
      if (mounted) setState(() => isSubmittingComment = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomFont(
          text: widget.userName,
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.imageUrl.isEmpty
                  ? const SizedBox()
                  : Image.asset(widget.imageUrl, fit: BoxFit.cover),

              SizedBox(height: ScreenUtil().setHeight(20)),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  children: [
                    widget.profileImageUrl.isEmpty
                        ? const Icon(Icons.person)
                        : CircleAvatar(
                            radius: ScreenUtil().setSp(25),
                            backgroundImage:
                                widget.profileImageUrl.startsWith('http')
                                ? NetworkImage(widget.profileImageUrl)
                                : AssetImage(widget.profileImageUrl)
                                      as ImageProvider,
                            onBackgroundImageError: (_, _) {},
                          ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFont(
                          text: widget.userName,
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            CustomFont(
                              text: widget.date,
                              fontSize: ScreenUtil().setSp(15),
                              color: Colors.grey,
                            ),
                            SizedBox(width: ScreenUtil().setWidth(3)),
                            Icon(
                              Icons.public,
                              color: Colors.grey,
                              size: ScreenUtil().setSp(18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(15)),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                alignment: Alignment.centerLeft,
                child: CustomFont(
                  text: widget.postContent,
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black,
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(30)),
              const Divider(),

              // ---------------- LIKE / COMMENT / SHARE ----------------
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LIKE BUTTON (ENHANCEMENT 3)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                          likes += isLiked ? 1 : -1;
                        });
                      },
                      icon: Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                        color: FB_DARK_PRIMARY,
                      ),
                      label: CustomFont(
                        text: likes == 0 ? 'Like' : likes.toString(),
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),

                    TextButton.icon(
                      onPressed: () => _commentFocusNode.requestFocus(),
                      icon: const Icon(Icons.comment, color: FB_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Comment',
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),

                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.redo, color: FB_DARK_PRIMARY),
                      label: CustomFont(
                        text: 'Share',
                        fontSize: ScreenUtil().setSp(12),
                        color: FB_DARK_PRIMARY,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // ---------------- COMMENTS (ENHANCEMENT 3) ----------------
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: 'Comments',
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(12)),

                    if (isLoadingComments)
                      const Center(child: CircularProgressIndicator())
                    else if (comments.isEmpty)
                      CustomFont(
                        text: 'No comments yet',
                        fontSize: ScreenUtil().setSp(13),
                        color: Colors.grey,
                      )
                    else
                      Column(
                        children: comments.map((comment) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: FB_LIGHT_SECONDARY,
                                  child: const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: ScreenUtil().setWidth(10)),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(12),
                                      vertical: ScreenUtil().setHeight(8),
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF6F2F8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomFont(
                                          text: comment.fullName.isNotEmpty
                                              ? comment.fullName
                                              : comment.username,
                                          fontSize: ScreenUtil().setSp(13),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(2),
                                        ),
                                        CustomFont(
                                          text: comment.body,
                                          fontSize: ScreenUtil().setSp(13),
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                    SizedBox(height: ScreenUtil().setHeight(10)),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            focusNode: _commentFocusNode,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(14),
                                vertical: ScreenUtil().setHeight(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(8)),
                        isSubmittingComment
                            ? const Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: FB_DARK_PRIMARY,
                                ),
                                onPressed: _submitComment,
                              ),
                      ],
                    ),

                    SizedBox(height: ScreenUtil().setHeight(20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
