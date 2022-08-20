import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_app/screens/add_post_screen.dart';
import 'package:unsplash_app/screens/profile_screen.dart';
import 'package:unsplash_app/screens/search_screen.dart';
import 'package:unsplash_app/screens/notification_screen.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  // const NotificationScreen(
  //   postId: null,
  // ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
