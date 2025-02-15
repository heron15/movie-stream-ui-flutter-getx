import 'package:bd_calling_task/data/models/post_model.dart';
import 'package:bd_calling_task/data/models/network_response_model.dart';
import 'package:bd_calling_task/data/services/network_caller.dart';
import 'package:bd_calling_task/data/services/local_storage_service.dart';
import 'package:bd_calling_task/utils/urls.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DownloadsScreenController extends GetxController {
  bool _isLoading = false;
  List<PostModel> _posts = [];
  String _error = '';
  bool _isOffline = false;

  bool get isLoading => _isLoading;
  List<PostModel> get posts => _posts;
  String get error => _error;
  bool get isOffline => _isOffline;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      await _loadCachedPosts();
    } else {
      await getPosts();
    }
  }

  Future<void> _loadCachedPosts() async {
    try {
      _isLoading = true;
      _error = '';
      update();

      if (await LocalStorageService.hasCachedPosts()) {
        _posts = await LocalStorageService.getCachedPosts();
        _isOffline = true;
      } else {
        _error = 'No cached data available';
      }
    } catch (e) {
      _error = 'Error loading cached data: $e';
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> getPosts() async {
    try {
      _isLoading = true;
      _error = '';
      _isOffline = false;
      update();

      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        await _loadCachedPosts();
        return;
      }

      NetworkResponseModel response = await Get.find<NetworkCaller>().getRequest(Urls.getDownloads);

      if (response.isSuccess) {
        try {
          final List<dynamic> results = response.responseData;
          _posts = results.map((json) => PostModel.fromJson(json)).toList();
          await LocalStorageService.savePosts(_posts);
        } catch (e) {
          _error = 'Failed to parse data: $e';
        }
      } else {
        _error = response.errorMessage ?? 'Failed to fetch posts';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      update();
    }
  }
}
