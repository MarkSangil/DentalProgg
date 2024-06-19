import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Controller {
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  Login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Announcement(String title, String description, String formattedDateTime) {
    FirebaseFirestore.instance.collection('announcement').doc().set({
      'title': title,
      'description': description,
      'dateandtime': formattedDateTime,
    });
  }

  Payment(String appointmentId, String userId, String name, String amount,
      String paymentmethod, String selectedDentalServices) {
    FirebaseFirestore.instance
        .collection('transactions')
        .doc(appointmentId)
        .set({
      'appointmentId': appointmentId,
      'user_id': userId,
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

  Consultation(String uid, String name, String description) {
    FirebaseFirestore.instance.collection('consultation').doc().set({
      'uid': uid,
      'name': name,
      'description': description,
    });
  }

  Prescription(String uid, String presciption, String date) {
    FirebaseFirestore.instance.collection('prescription').doc().set({
      'uid': uid,
      'date': date,
      'presciption': presciption,
    });
  }

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
