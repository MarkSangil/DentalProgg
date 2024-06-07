import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Controller {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Register(String name, String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    String? uid = userCredential.user?.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'age': '',
      'contact': '',
      'gender': '',
      'birthday': '',
      'address': '',
      'uid': uid,
      'image': '',
      'type': 'customer',
    });
  }

  // ignore: non_constant_identifier_names
  Login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // ignore: non_constant_identifier_names
  Announcement(String title, String description) {
    FirebaseFirestore.instance.collection('announcement').doc().set({
      'title': title,
      'description': description,
    });
  }

  // ignore: non_constant_identifier_names
  Payment(String appointmentId, String user_id, String name, String amount,
      String paymentmethod, String selectedDentalServices) {
    FirebaseFirestore.instance
        .collection('transactions')
        .doc(appointmentId)
        .set({
      'appointmentId': appointmentId,
      'user_id': user_id,
      'name': name,
      'amount': amount,
      'paymentmethod': paymentmethod,
      'selectedDentalServices': selectedDentalServices,
    });

    FirebaseFirestore.instance
        .collection('appointment')
        .doc(appointmentId)
        .set({
      'status': 'Completed',
    }, SetOptions(merge: true));
  }

  // ignore: non_constant_identifier_names
  Consultation(String uid, String name, String description) {
    FirebaseFirestore.instance.collection('consultation').doc().set({
      'uid': uid,
      'name': name,
      'description': description,
    });
  }

  // ignore: non_constant_identifier_names
  Prescription(String uid, String presciption, String date) {
    FirebaseFirestore.instance.collection('prescription').doc().set({
      'uid': uid,
      'date': date,
      'presciption': presciption,
    });
  }

  // ignore: non_constant_identifier_names
  Profile(
      String uid,
      String name,
      String email,
      String age,
      String contact,
      String gender,
      String birthday,
      String address,
      String ecName,
      String ecContactNo,
      String relationshipToPatient,
      String image) {
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'age': age,
      'contact': contact,
      'gender': gender,
      'birthday': birthday,
      'address': address,
      'ec_name': ecName,
      'ec_contact_no': ecContactNo,
      'relationship_to_patient': relationshipToPatient,
      'uid': uid,
      'image': image,
      'type': 'customer'
    });
  }
}
