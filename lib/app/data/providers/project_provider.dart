import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_manager/app/data/models/project.dart';
import 'package:project_manager/app/data/repositories/task_repository.dart';

class ProjectProvider {
  final String collectionName;

  ProjectProvider({required this.collectionName});

  Future<List<Project>> fetchAll() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .get();
    return snapshot.docs.map((e) => Project.fromMap(e.data())).toList();
  }

  Stream<QuerySnapshot<Project>> streamAll() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .withConverter<Project>(
      fromFirestore: (snapshot, options) {
        return Project.fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    ).snapshots();
  }

  Stream<List<String>> streamAllStatuses() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map<List<String>>(
          (event) => [
            ...{
              ...event.docs.map((e) {
                return Project.fromMap(e.data()).status;
              }).toList()
            }
          ],
        );
  }

  Future<List<String>> fetchAllStatuses() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .get();
    return [
      ...{
        ...snapshot.docs.map((e) {
          return Project.fromMap(e.data()).status;
        }).toList()
      }
    ];
  }

  Future<List<String>> fetchAllPriorities() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .get();
    return [
      ...{
        ...snapshot.docs.map((e) {
          return Project.fromMap(e.data()).priority;
        }).toList()
      }
    ];
  }

  Stream<List<String>> streamAllPriorities() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map<List<String>>(
          (event) => [
            ...{
              ...event.docs.map((e) {
                return Project.fromMap(e.data()).priority;
              }).toList()
            }
          ],
        );
  }

  Future<void> insertOne(Project project) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .add(project.toMap());
    return;
  }

  Stream<Project> streamById(String id) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .snapshots()
        .map<Project>((event) => Project.fromMap(event.data()!));
  }

  Future<void> deleteById(String id) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete();
    await TaskRepository.instance.onProjectDelete(id);
    return;
  }

  Future<void> updateById(Project project, String id) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .set(project.toMap());
    return;
  }
}
