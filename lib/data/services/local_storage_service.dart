import 'package:bd_calling_task/data/models/post_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bd_calling_task/data/models/hive/post_hive_model.dart';
import 'package:bd_calling_task/data/services/hive_adapters.dart';

class LocalStorageService {
  static const String postsBoxName = 'posts';

  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    HiveAdapters.registerAdapters();
  }

  static Future<Box<PostHiveModel>> openPostsBox() async {
    return await Hive.openBox<PostHiveModel>(postsBoxName);
  }

  static Future<void> savePosts(List<PostModel> posts) async {
    final box = await openPostsBox();
    await box.clear();

    final hivePosts = posts.map((post) => PostHiveModel.fromPostModel(post)).toList();
    await box.addAll(hivePosts);
  }

  static Future<List<PostModel>> getCachedPosts() async {
    final box = await openPostsBox();
    return box.values.map((hivePost) => hivePost.toPostModel()).toList();
  }

  static Future<bool> hasCachedPosts() async {
    final box = await openPostsBox();
    return box.isNotEmpty;
  }
}
