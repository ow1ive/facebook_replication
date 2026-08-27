import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../widgets/custom_font.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserService _userService = UserService();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _userService.getSavedUser();
    if (!mounted) return;
    setState(() => _currentUser = user);
  }

  Future<void> _signOut() async {
    await _userService.logout();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final String name = _currentUser?.fullName.trim().isNotEmpty == true
        ? _currentUser!.fullName
        : 'Guest';
    final String email = _currentUser?.email ?? '';
    final String? image = _currentUser?.image;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F2F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomFont(
          text: 'Settings',
          fontSize: ScreenUtil().setSp(20),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(16),
          vertical: ScreenUtil().setHeight(20),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtil().setSp(16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: (image != null && image.isNotEmpty)
                      ? NetworkImage(image)
                      : null,
                  onBackgroundImageError: (image != null && image.isNotEmpty)
                      ? (_, _) {}
                      : null,
                  child: (image == null || image.isEmpty)
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                SizedBox(width: ScreenUtil().setWidth(14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: name,
                        fontSize: ScreenUtil().setSp(17),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(4)),
                      CustomFont(
                        text: email,
                        fontSize: ScreenUtil().setSp(13),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(16),
                vertical: ScreenUtil().setHeight(4),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: CustomFont(
                text: 'Sign Out',
                fontSize: ScreenUtil().setSp(15),
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.red),
              onTap: _signOut,
            ),
          ),
        ],
      ),
    );
  }
}
