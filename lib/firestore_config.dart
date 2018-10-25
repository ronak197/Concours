import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreConfig {
  CollectionReference collectionReference;
  DocumentReference dataReference;

  FirestoreConfig(String collectionName){
    collectionReference = Firestore.instance.collection(collectionName);
  }

  Stream<QuerySnapshot> getSnapshot(){
    return collectionReference.snapshots();
  }

  Future<void> addData(String documentName, Map data) async {
    dataReference = collectionReference.document(documentName);

    dataReference.setData(data)
      .whenComplete((){
        print("Successfully Added");
      })
      .catchError((e){
        print("Error in adding Data $e");
      });
  }

  Future<void> deleteData(String documentName) async {
    dataReference = collectionReference.document(documentName);

    dataReference.delete()
      .whenComplete((){
        print("Successfully Deleted");
      })
      .catchError((e){
        print("Error occured in deleting data $e");
      });
  }
}