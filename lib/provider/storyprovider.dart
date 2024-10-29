import 'package:flutter/material.dart';
import 'package:storyview/model/models.dart';

class StoryProvider with ChangeNotifier {
  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;

  final List<UserModel> users = [
         UserModel(
        id: '1',
        name: 'User 1',
        profileImageUrl: 'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/268432/pexels-photo-268432.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),

          StoryModel(imageUrl: 'https://images.pexels.com/photos/135940/pexels-photo-135940.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/1485548/pexels-photo-1485548.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),
      UserModel(
        id: '2',
        name: 'User 2',
        profileImageUrl: 'https://images.pexels.com/photos/268432/pexels-photo-268432.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/39574/flower-exotic-colorful-pink-39574.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/133472/pexels-photo-133472.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/39574/flower-exotic-colorful-pink-39574.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),   UserModel(
        id: '3',
        name: 'User 3',
        profileImageUrl: 'https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/133081/pexels-photo-133081.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/1485548/pexels-photo-1485548.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),
      UserModel(
        id: '4',
        name: 'User 4',
        profileImageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/133472/pexels-photo-133472.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),   UserModel(
        id: '5',
        name: 'User 5',
        profileImageUrl: 'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/135940/pexels-photo-135940.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/1485548/pexels-photo-1485548.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),
      UserModel(
        id: '6',
        name: 'User 6',
        profileImageUrl: 'https://images.pexels.com/photos/409126/pexels-photo-409126.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/133472/pexels-photo-133472.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/39574/flower-exotic-colorful-pink-39574.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),
      UserModel(
        id: '7',
        name: 'User 7',
        profileImageUrl: 'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/409126/pexels-photo-409126.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/1485548/pexels-photo-1485548.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),
      UserModel(
        id: '8',
        name: 'User 8',
        profileImageUrl: 'https://images.pexels.com/photos/133081/pexels-photo-133081.jpeg?auto=compress&cs=tinysrgb&w=600',
        stories: [
          StoryModel(imageUrl: 'https://images.pexels.com/photos/133472/pexels-photo-133472.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
          StoryModel(imageUrl: 'https://images.pexels.com/photos/133081/pexels-photo-133081.jpeg?auto=compress&cs=tinysrgb&w=600', duration: Duration(seconds: 5)),
        ],
      ),
    ];

  UserModel get currentUser => users[_currentUserIndex];
  StoryModel get currentStory => currentUser.stories[_currentStoryIndex];

  int get currentUserIndex => _currentUserIndex;
  int get currentStoryIndex => _currentStoryIndex;

  void nextStory() {
    if (_currentStoryIndex < currentUser.stories.length - 1) {
      _currentStoryIndex++;
    } else if (_currentUserIndex < users.length - 1) {
      _currentStoryIndex = 0;
      _currentUserIndex++;
    }
    notifyListeners();
  }

  void previousStory() {
    if (_currentStoryIndex > 0) {
      _currentStoryIndex--;
    } else if (_currentUserIndex > 0) {
      _currentUserIndex--;
      _currentStoryIndex = users[_currentUserIndex].stories.length - 1;
    }
    notifyListeners();
  }

  void selectUser(int index) {
    _currentUserIndex = index;
    _currentStoryIndex = 0;
    notifyListeners();
  }
}
