import 'package:bd_calling_task/data/models/post_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class PostHiveModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final int userId;

  PostHiveModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory PostHiveModel.fromJson(Map<String, dynamic> json) {
    return PostHiveModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  factory PostHiveModel.fromPostModel(PostModel post) {
    return PostHiveModel(
      id: post.id,
      title: post.title,
      body: post.body,
      userId: post.userId,
    );
  }

  PostModel toPostModel() {
    return PostModel(
      id: id,
      title: title,
      body: body,
      userId: userId,
    );
  }
}
