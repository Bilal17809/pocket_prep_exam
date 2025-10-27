import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseJsonCacheService {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  Future<void> _ensureSignedIn() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
      print("Signed in anonymously.");
    }
  }

  Future<File> getCachedJsonFile(String remoteFileName) async {
    await _ensureSignedIn();
    final dir = await getApplicationDocumentsDirectory();
    final localFile = File("${dir.path}/$remoteFileName");
    if (!await localFile.exists()) {
      print("Downloading $remoteFileName from Firebase Storage...");
      await _storage.ref(remoteFileName).writeToFile(localFile);
      print("Saved locally at ${localFile.path}");
    } else {
      print("Using cached $remoteFileName");
    }
    return localFile;
  }

  Future<List<dynamic>> loadJsonList(String remoteFileName) async {
    final file = await getCachedJsonFile(remoteFileName);
    final content = await file.readAsString();
    return json.decode(content);
  }
}
