import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasklis_app/constant.dart';
import 'package:tasklis_app/httpService.dart';
import 'package:tasklis_app/main.dart';

mixin Func {
  HttpService httpService = HttpService();

  Future<Response<dynamic>> sendRequest(
      {required String endpoint,
      required Method method,
      Map<String, dynamic>? params,
      String? authorizationHeader}) async {
    httpService.init(BaseOptions(
        baseUrl: baseUrl,
        contentType: "application/json",
        headers: {"Authorization": authorizationHeader}));

    final response = await httpService.request(
      endpoint: endpoint,
      method: method,
      params: params,
    );

    return response;
  }

  sendFile({required String endpoint, required FormData formData}) async {
    httpService.init(
        BaseOptions(baseUrl: baseUrl, contentType: "multipart/form-data"));
    final response =
        await httpService.requestFile(endpoint: endpoint, formData: formData);

    return response;
  }

  Future<Map<String, dynamic>> getLists(BuildContext context) async {
    Map<String, dynamic> lists = {};

    await sendRequest(endpoint: allLists, method: Method.GET).then((lsts) {
      lists = lsts.data as Map<String, dynamic>;
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send request")));
    });

    return lists;
  }

  createList(String name) async {
    await sendRequest(
        endpoint: newList, method: Method.POST, params: {"name": name});
  }

  getList(String id) async {
    await sendRequest(endpoint: singleList, method: Method.GET);
  }

  updateList(String id, String name) async {
    await sendRequest(
        endpoint: singleList + id,
        method: Method.PATCH,
        params: {"name": name});
  }

  deleteList(String id) async {
    await sendRequest(endpoint: singleList + id, method: Method.DELETE);
  }

  Future<Map<String, dynamic>> getItems(BuildContext context) async {
    Map<String, dynamic> allItems = {};

    await sendRequest(endpoint: items, method: Method.GET).then((itms) {
      allItems = itms.data as Map<String, dynamic>;
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send request")));
    });

    return allItems;
  }

  createItem(
      String listid, String name, String description, bool status) async {
    await sendRequest(endpoint: items, method: Method.POST, params: {
      "listid": listid,
      "name": name,
      "description": description,
      "status": status
    });
  }

  Future<Map<String, dynamic>> getItemsByList(
      String listid, BuildContext context) async {
    Map<String, dynamic> items = {};
    await sendRequest(endpoint: itemsByList + listid, method: Method.GET)
        .then((itms) {
      items = itms.data as Map<String, dynamic>;
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send request")));
    });

    return items;
  }

  updateItem(String id, String listid, String name, String description,
      bool status) async {
    await sendRequest(endpoint: singleItem + id, method: Method.PATCH, params: {
      "listid": listid,
      "name": name,
      "description": description,
      "status": status
    });
  }

  deleteItem(String id) async {
    await sendRequest(endpoint: singleItem + id, method: Method.DELETE);
  }

  // For Firebase

  getListsUsingFirebase(BuildContext context) async {
    Map<String, dynamic> lists = {};

    await sendRequest(endpoint: firebase, method: Method.GET).then((lsts) {
      lists = lsts.data as Map<String, dynamic>;
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send request")));
    });

    return lists;
  }

  createListUsingFirebase(String name) async {
    await sendRequest(
        endpoint: firebase, method: Method.POST, params: {"name": name});
  }

  updateListUsingFirebase(String id, String name) async {
    await sendRequest(
        endpoint: firebase + id, method: Method.PATCH, params: {"name": name});
  }

  deleteListUsingFirebase(String id) async {
    await sendRequest(endpoint: firebase + id, method: Method.DELETE);
  }

  // For MongoDB

  getListsUsingMongodb(BuildContext context) async {
    Map<String, dynamic> lists = {};

    await sendRequest(endpoint: mongodb, method: Method.GET).then((lsts) {
      lists = lsts.data as Map<String, dynamic>;
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send request")));
    });

    return lists;
  }

  createListUsingMongodb(String name) async {
    await sendRequest(
        endpoint: mongodb, method: Method.POST, params: {"name": name});
  }

  updateListUsingMongodb(String id, String name) async {
    await sendRequest(
        endpoint: mongodb + id, method: Method.PATCH, params: {"name": name});
  }

  deleteListUsingMongodb(String id) async {
    await sendRequest(endpoint: mongodb + id, method: Method.DELETE);
  }

  // For PostgreSQL

  getListsUsingPostgresql(BuildContext context) async {
    Map<String, dynamic> lists = {};

    await sendRequest(endpoint: postgresql, method: Method.GET).then((lsts) {
      lists = lsts.data as Map<String, dynamic>;
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send request")));
    });

    return lists;
  }

  createListUsingPostgresql(String name) async {
    await sendRequest(
        endpoint: postgresql, method: Method.POST, params: {"name": name});
  }

  updateListUsingPostgresql(String id, String name) async {
    await sendRequest(
        endpoint: postgresql + id,
        method: Method.PATCH,
        params: {"name": name});
  }

  deleteListUsingPostgresql(String id) async {
    await sendRequest(endpoint: postgresql + id, method: Method.DELETE);
  }

  setLoginStatus(int status) async {
    await sendRequest(
        endpoint: redis, method: Method.POST, params: {"loggedin": status});
  }

  getLoginStatus(BuildContext context) async {
    final response = await sendRequest(endpoint: redis, method: Method.GET)
        .then((value) => value);
    if (context.mounted) {
      if (response.data['success']) {
        if (response.data['message'] == 0) {
          Navigator.pushNamed(context, "/signin");
        } else {
          Navigator.pushNamed(context, '/lists');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to retrieve login status")));
      }
    }
  }

  createUserUsingBasic(String name, String username, String password,
      BuildContext context) async {
    await sendRequest(
            endpoint: basicAuth,
            method: Method.POST,
            params: {"name": name, "username": username, "password": password})
        .then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          Navigator.pushNamed(context, '/signin');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to create user")));
        }
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to create user")));
    });
  }

  getUserUsingBasic(String username, String password, BuildContext context,
      bool rememberMe) async {
    await sendRequest(
            endpoint: basicAuth,
            method: Method.GET,
            params: {"username": username, "password": password},
            authorizationHeader:
                "Basic ${base64.encode("$username:$password".codeUnits)}")
        .then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          customProvider.setUser(value.data as Map<String, dynamic>);
          Navigator.pushNamed(context, "/lists");
          setLoginStatus(rememberMe ? 1 : 0);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to authenticate user")));
        }
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to authenticate user")));
    });
  }

  updateUserUsingBasic(String id, String name, String username,
      String newPassword, String oldPassword, BuildContext context) async {
    await sendRequest(
            endpoint: basicAuth + id,
            method: Method.PATCH,
            params: {
              "name": name,
              "username": username,
              "password": newPassword
            },
            authorizationHeader:
                "Basic ${base64.encode("$username:$oldPassword".codeUnits)}")
        .then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          // User is updated
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to update user")));
        }
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to update user")));
    });
  }

  deleteUserUsingBasic(String id) async {
    await sendRequest(endpoint: basicAuth + id, method: Method.DELETE);
  }

  createUserUsingBearer(String name, String username, String password,
      BuildContext context) async {
    await sendRequest(
            endpoint: bearerAuth,
            method: Method.POST,
            params: {"name": name, "username": username, "password": password})
        .then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          // User is created
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to create user")));
        }
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to create user")));
    });
  }

  getUserUsingBearer(
      String username, String password, BuildContext context) async {
    await sendRequest(
        endpoint: bearerAuth,
        method: Method.GET,
        params: {"username": username, "password": password}).then((value) {
      if (context.mounted) {
        if (value.statusCode == 200) {
          // User is authenticated
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to authenticate user")));
        }
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to authenticate user")));
    });
  }

  updateUserUsingBearer(
      String id,
      String name,
      String username,
      String newPassword,
      String oldPassword,
      BuildContext context,
      String sessionToken) async {
    await sendRequest(endpoint: bearerAuth + id, method: Method.PATCH, params: {
      "name": name,
      "username": username,
      "password": newPassword
    }).then((value) {}).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to update user")));
    });
  }

  deleteUserUsingBearer(String id, String sessionToken) async {
    await sendRequest(
        endpoint: bearerAuth + id,
        method: Method.DELETE,
        authorizationHeader: "Bearer $sessionToken");
  }

  Future<Map<String, dynamic>> getRecipe(BuildContext context) async {
    Map<String, dynamic> recipe = {};

    await sendRequest(endpoint: restapi, method: Method.GET).then((value) {
      recipe = jsonDecode(value.data) as Map<String, dynamic>;
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch recipe")));
    });

    return recipe;
  }

  // File Upload
  fileUpload(File file) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last)
    });

    await sendFile(endpoint: files, formData: formData);
  }

  fileDownload() {
    return sendRequest(endpoint: files, method: Method.GET);
  }
}
