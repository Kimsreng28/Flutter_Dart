import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'item_Repository.g.dart';

@visibleForTesting
//data source for memory cache
Map<String, TaskItem> itemDb = {};

@JsonSerializable()
class TaskItem extends Equatable {
  //constructor
  const TaskItem(
      {required this.id,
      required this.listid,
      required this.description,
      required this.status,
      required this.name});

  //deserialization
  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  //copy constructor
  TaskItem copyWith({
    String? id,
    String? listid,
    String? name,
    String? description,
    bool? status,
  }) {
    return TaskItem(
        id: id ?? this.id,
        listid: listid ?? this.listid,
        name: name ?? this.name,
        description: description ?? this.description,
        status: status ?? this.status);
  }

  //properties
  final String id;
  final String listid;
  final String name;
  final String description;
  final bool status;

  //serialization
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  //Equatable
  @override
  List<Object> get props => [id, name];
}

//Repositories TaskItem
class TaskItemRepository {
  //get task list
  Future<TaskItem?> listById(String id) async {
    return itemDb[id];
  }

  // get all the items
  Map<String, dynamic> getAllItems() {
    final formattedLists = <String, dynamic>{};

    if (itemDb.isNotEmpty) {
      itemDb.forEach((String id) {
        final currentItem = itemDb[id];
        formattedLists?[id] = currentItem?.toJson();
      } as void Function(String key, TaskItem value));
    }

    return formattedLists;
  }

  // Add a new TaskItem object to the database
  String createItem(
      {required String name,
      required String listid,
      required String description,
      required bool status}) {
    // dynamically generated id
    final id = name.hashValue;

    //create a new TaskItem object
    final item = TaskItem(
        id: id,
        listid: listid,
        name: name,
        description: description,
        status: status);

    // add a new TaskItem object to the database
    itemDb[id] = item;

    return id;
  }

  // Delete a TaskItem object with the given id
  void deleteItem(String id) {
    itemDb.remove(id);
  }

  // Update Operation
  Future<void> updateItem(
      {required String id,
      required String name,
      required String listid,
      required String description,
      required bool status}) async {
    final currentItem = itemDb[id];

    if (currentItem == null) {
      return Future.error(Exception('Item not found'));
    }

    itemDb[id] = TaskItem(
        id: id,
        name: name,
        listid: listid,
        description: description,
        status: status);
  }
}
