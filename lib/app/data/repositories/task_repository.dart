import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_manager/app/data/models/task.dart';
import 'package:project_manager/app/data/providers/task_provider.dart';

class TaskRepository {
  final TaskProvider _provider;

  TaskRepository._(this._provider);
  static final TaskRepository instance =
      TaskRepository._(TaskProvider(collectionName: 'tasks'));

  Stream<QuerySnapshot<Task>> streamAll() {
    return _provider.streamAll();
  }

  Stream<QuerySnapshot<Task>> streamAllByProjectId(String id) {
    return _provider.streamAllByProjectId(id);
  }

  Stream<QuerySnapshot<Task>> streamByProject(String id) {
    return _provider.streamByProject(id);
  }

  Future<void> insertOne(Task task) async {
    return _provider.insertOne(task);
  }

  Stream<List<String>> streamAllStatuses() {
    return _provider.streamAllStatuses();
  }

  Stream<List<String>> streamAllProgresses() {
    return _provider.streamAllProgresses();
  }

  Stream<List<String>> streamAllPriorities() {
    return _provider.streamAllPriorities();
  }

  Future<void> onProjectDelete(String id) async {
    return _provider.onProjectDelete(id);
  }

  Future<void> deleteById(String id) async {
    return _provider.deleteById(id);
  }

  Future<List<String>> fetchAllStatuses() async {
    return _provider.fetchAllStatuses();
  }

  Future<List<String>> fetchAllPriorities() async {
    return _provider.fetchAllPriorities();
  }

  Future<void> updateById(Task task, String id) async {
    return _provider.updateById(task, id);
  }
}
