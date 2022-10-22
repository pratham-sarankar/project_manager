import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/providers/project_provider.dart';

class ProjectRepository {
  final ProjectProvider _provider;

  ProjectRepository._(this._provider);
  static final ProjectRepository instance =
      ProjectRepository._(ProjectProvider(collectionName: 'projects'));

  Stream<QuerySnapshot<Project>> streamAll() {
    return _provider.streamAll();
  }

  Future<void> insertOne(Project project) async {
    await _provider.insertOne(project);
    return;
  }

  Stream<Project> streamById(String id) {
    return _provider.streamById(id);
  }

  Future<void> deleteById(String id) async {
    return _provider.deleteById(id);
  }

  Future<void> updateById(Project project, String id) {
    return _provider.updateById(project, id);
  }
}
