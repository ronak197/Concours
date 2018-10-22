import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreConfig {
  CollectionReference collectionReference;
  DocumentReference userReference;

  FirestoreConfig(String collectionName){
    collectionReference = Firestore.instance.collection(collectionName);
  }

  Future<void> addData(String documentName, Map data) async {
    userReference = collectionReference.document(documentName);

    userReference.setData(data)
      .whenComplete((){
        print("Successfully Added");
      })
      .catchError((e){
        print("Error in adding Data $e");
      });
  }
}