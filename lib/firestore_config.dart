import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreConfig {
  CollectionReference collectionReference;
  DocumentReference userReference;

  FirestoreConfig(){
    collectionReference = Firestore.instance.collection("users");
  }

  DocumentReference getDocument(String documentName){
    return collectionReference.document(documentName);
  }

  Future<void> addData(String uid, Map data) async {
    userReference = collectionReference.document(uid);

    userReference.setData(data)
      .whenComplete((){
        print("Successfully Added");
      })
      .catchError((e){
        print("Error in adding Data $e");
      });
  }
}