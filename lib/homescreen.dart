import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyview/provider/storyprovider.dart';
import 'package:storyview/storyviewscreen.dart';

class StoryListScreen extends StatelessWidget {
  const StoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<StoryProvider>(context).users;

    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    Provider.of<StoryProvider>(context, listen: false).selectUser(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StoryViewScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(user.profileImageUrl),
                        ),
                        const SizedBox(height: 5),
                        Text(user.name),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Home Screen'),
            ),
          ),
        ],
      ),
    );
  }
}
