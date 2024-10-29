class UserModel {
  final String id;
  final String name;
  final String profileImageUrl;
  final List<StoryModel> stories;

  UserModel({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.stories,
  });
}

class StoryModel {
  final String imageUrl;
  final Duration duration;
  bool isViewed;

  StoryModel({
    required this.imageUrl,
    required this.duration,
    this.isViewed = false,
  });
}
