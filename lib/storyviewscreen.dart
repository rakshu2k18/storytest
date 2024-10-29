import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyview/provider/storyprovider.dart';
class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key});

  @override
  _StoryViewScreenState createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  Timer? _timer;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startStoryTimer();
  }

  void _startStoryTimer() {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    final currentStory = storyProvider.currentStory;

    _progress = 0.0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 50 / currentStory.duration.inMilliseconds;
        if (_progress >= 1.0) {
          timer.cancel();
          _nextStoryOrUser();
        }
      });
    });
  }

  void _nextStoryOrUser() {
    final storyProvider = Provider.of<StoryProvider>(context, listen: false);

    if (storyProvider.currentStoryIndex < storyProvider.currentUser.stories.length - 1) {
      storyProvider.nextStory();
      _startStoryTimer();
    } else if (storyProvider.currentUserIndex < storyProvider.users.length - 1) {
      storyProvider.nextStory();
      _startStoryTimer();
    } else {
      Navigator.pop(context); 
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoryProvider>(context);
    final user = storyProvider.currentUser;

    return Scaffold(
      body: GestureDetector(
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            storyProvider.previousStory();
          } else {
            if (storyProvider.currentStoryIndex == storyProvider.currentUser.stories.length - 1 &&
                storyProvider.currentUserIndex == storyProvider.users.length - 1) {
              Navigator.pop(context);
            } else {
              storyProvider.nextStory();
            }
          }
          _timer?.cancel();
          _startStoryTimer();
        },
        child: Stack(
          children: [
            Center(
              child: Image.network(
                storyProvider.currentStory.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              top: 70,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:  NetworkImage(storyProvider.currentUser.profileImageUrl)// Replace with user's profile picture URL
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); 
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Row(
                children: user.stories.map((story) {
                  final isCurrent = story == storyProvider.currentStory;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: isCurrent ? _progress : (story.isViewed ? 1.0 : 0.0)),
                        duration: const Duration(milliseconds: 50),
                        builder: (context, value, child) => LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey[400],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCurrent ? Colors.blue : Colors.grey[300]!,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
