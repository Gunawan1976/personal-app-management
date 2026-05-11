import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widget/custom_text_widget.dart';
import 'login/presentation/providers/login_state.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextView(
            text: "Profile Pages",
            fontWeight: FontWeight.w600,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(""),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextView(text: "User Name", fontWeight: FontWeight.w600),
                SizedBox(
                  height: 8.h,
                ),
                TextView(text: "@username"),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            child: const Icon(Icons.email, color: Colors.black),
                          ),
                          title: TextView(text: "user@example.com"),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            child: const Icon(Icons.call, color: Colors.black),
                          ),
                          title: TextView(text: "+62123456789"),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            child: const Icon(Icons.location_pin,
                                color: Colors.black),
                          ),
                          title: TextView(text: "Jakarta, Indonesia"),
                          onTap: () {}),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(authSessionProvider.notifier).logout();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  style: ButtonStyle(
                    minimumSize:
                        WidgetStateProperty.all(const Size(double.infinity, 50)),
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  child: TextView(
                    text: "Logout",
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
