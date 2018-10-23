import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreConfig {
  CollectionReference collectionReference;
  DocumentReference userReference;

  FirestoreConfig(){
    collectionReference = Firestore.instance.collection("users");
    userReference = collectionReference.document("sanket");
    userReference.get()
      .then((datasnapshot){
        if(datasnapshot.exists){
          print(datasnapshot.data["name"]);
        } else {
          print("Data does not exist");
        }
      });
  }

  DocumentReference getDocument(String documentName){
    return collectionReference.document(documentName);
  }
}