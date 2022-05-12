import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_monitoring_system/db/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_monitoring_system/models/paitentModel.dart';
import '../../../constants.dart';
import 'upload.dart';

class PatientHomeScreen extends StatelessWidget {
  
  String user = "Name";
  PatientHomeScreen(this.user, {Key? key}) : super(key: key);
  static var  ref = FirebaseFirestore.instance.collection("patient");
  final Stream<QuerySnapshot> _patientStream =ref.where("Aadhar no",isEqualTo: "789456123963").snapshots();
  

  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _patientStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            a['id'] = document.id;
            storedocs.add(a);

          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Welcome " + user),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  "assets/icons/Sign_Up_bg.svg",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  child: SafeArea(
                    child: myProfile(context, storedocs),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget myProfile(BuildContext buildContext, List a) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                      child: Text(
                    'History',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        fontStyle: FontStyle.normal),
                  )),
                )),
            Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                      child: Text(
                    'Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        fontStyle: FontStyle.normal),
                  )),
                )),
          ],
        ),
        Row(
          children: [
            Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Center(
                        child: Text(
                      'Prescription',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontStyle: FontStyle.normal),
                    )),
                  ),
                  onTap: () => print(a[0]),
                )),
            // Container(
            //     width: 180,
            //     height: 180,
            //     padding: const EdgeInsets.all(20.0),
            //     child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15.0),
            //       ),
            //       child: const Center(
            //           child: Text(
            //         'Upload',
            //         style: TextStyle(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 17,
            //             fontStyle: FontStyle.normal),
            //       )),
            //     ),),

            Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(20.0),
                // width: 200,
                // height: 200,
                // padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Center(child: Text('Upload Document')),
                  ),
                  onTap: () {
                    Navigator.push(
                        buildContext,
                        MaterialPageRoute(
                            builder: (context) => UploadDocument(ref)));
                  },
                )),
          ],
        ),
      ],
    );
  }
}
