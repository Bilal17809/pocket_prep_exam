import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseJsonCacheService {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  /// Signs in anonymously to Firebase if not already signed in
  Future<void> _ensureSignedIn() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
      print("🔐 Signed in anonymously.");
    }
  }

  /// Downloads a JSON file from Firebase Storage and caches it locally
  Future<File> getCachedJsonFile(String remoteFileName) async {
    await _ensureSignedIn();

    final dir = await getApplicationDocumentsDirectory();
    final localFile = File("${dir.path}/$remoteFileName");

    if (!await localFile.exists()) {
      print("📥 Downloading $remoteFileName from Firebase Storage...");
      await _storage.ref(remoteFileName).writeToFile(localFile);
      print("✅ Saved locally at ${localFile.path}");
    } else {
      print("✅ Using cached $remoteFileName");
    }

    return localFile;
  }

  /// Loads JSON data from the cached file
  Future<List<dynamic>> loadJsonList(String remoteFileName) async {
    final file = await getCachedJsonFile(remoteFileName);
    final content = await file.readAsString();
    return json.decode(content);
  }
}
