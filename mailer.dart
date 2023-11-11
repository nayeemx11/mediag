// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// Future<void> sendMail(String recipientEmail) async {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final User? user = auth.currentUser;

//   if (user != null) {
//     final smtpServer = gmail(user.email!, user.uid);
//     final message = Message()
//       ..from = Address(user.email!, 'Your Name')
//       ..recipients.add(recipientEmail)
//       ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
//       ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//       ..html = '<h1>Test</h1>\n<p>Hey!</p>';

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print(e);
//       print('Message not sent.');
//       for (var p in e.problems) {
//         print('Problem: ${p.code}: ${p.msg}');
//       }
//     }
//   }
// }
