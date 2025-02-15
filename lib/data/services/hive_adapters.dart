import 'package:hive/hive.dart';
import 'package:bd_calling_task/data/models/hive/post_hive_model.dart';

class HiveAdapters {
  static void registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(_PostHiveModelAdapter());
    }
  }
}

class _PostHiveModelAdapter extends TypeAdapter<PostHiveModel> {
  @override
  final int typeId = 0;

  @override
  PostHiveModel read(BinaryReader reader) {
    return PostHiveModel(
      id: reader.readInt(),
      title: reader.readString(),
      body: reader.readString(),
      userId: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, PostHiveModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.body);
    writer.writeInt(obj.userId);
  }
} 