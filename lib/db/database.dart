import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_system/models/doctorModel.dart';
import 'package:health_monitoring_system/models/paitentModel.dart';
import 'package:health_monitoring_system/models/labModel.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('doctor');
  CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');
  CollectionReference labCollection =
      FirebaseFirestore.instance.collection('labs');


  Future<FutureBuilder<DocumentSnapshot<Object?>>> getPatient(String aadhar)async {
    return FutureBuilder<DocumentSnapshot>(
      future: patientCollection.doc().get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }

  Future<void> addLab(Labs lab) {
    return labCollection
        .add({
          'Name': lab.labName,
          'User Name': lab.userName,
          'Contact': lab.contNo,
          'Address': lab.address,
          'Password': lab.password
        })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }

  Future<void> addPatient(Patients patients) {
    return patientCollection
        .add({
          'Name': patients.name,
          'Birth Date': patients.birthDate,
          'Blood Group': patients.bloodGr,
          'Gender': patients.gender,
          'Aadhar no': patients.aadharNo,
          'Contact': patients.contNo,
          'Address': patients.address,
          'Password': patients.password,
          'his_reports':FieldValue.arrayUnion(patients.histories)
        })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }

  Future<void> addDoctor(Doctors doctors) {
    return doctorCollection
        .add({
          'Name': doctors.drName,
          'gender': doctors.gender,
          'Aadhar no': doctors.aadharNo,
          'Contact': doctors.contNo,
          'Clini Address': doctors.address,
          'Password': doctors.password
        })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }
}
