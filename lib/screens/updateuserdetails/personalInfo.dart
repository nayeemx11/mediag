import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediag/screens/authentication/login_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
import 'package:mediag/screens/updateuserdetails/personInfoupdate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationCard extends StatefulWidget {
  final String registrationId;
  final String email;

  PersonalInformationCard(this.email, this.registrationId);

  @override
  _PersonalInformationCardState createState() =>
      _PersonalInformationCardState();
}

class _PersonalInformationCardState extends State<PersonalInformationCard> {
  late Future<DocumentSnapshot> _userData;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login_Screen()),
    );
  }

  void _updateInfo() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                personalInfoUpdate(widget.email, widget.registrationId)));
  }

  Future<DocumentSnapshot> fetchUserData() async {
    return await FirebaseFirestore.instance
        .collection(widget.registrationId)
        .doc(widget.email)
        .get();
  }

  Widget buildText(String label, String subLable) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 24, // Adjust the height as needed
        child: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "$label ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "$subLable",
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.email}"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Update_Info') {
                _updateInfo();
              } else if (value == 'updatePassword') {
                // _updatePassword();
              } else if (value == 'deleteAccount') {
                // _deleteAccount(context);
              } else if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Update_Info',
                  child: Text('Update Info'),
                ),
                // PopupMenuItem<String>(
                //   value: 'updatePassword',
                //   child: Text('Update Password'),
                // ),
                // PopupMenuItem<String>(
                //   value: 'deleteAccount',
                //   child: Text('Delete Account'),
                // ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // var userData = snapshot.data!.data() as Map<String, dynamic>;
            var userData = snapshot.data?.data() as Map<String, dynamic> ?? {};

            return SingleChildScrollView(
              child: Column(
                children: [
                  PersonalInformationCard(userData),
                  currentHealthStatusData(userData),
                  diagnosesAndTestResultsData(userData),
                  medicalHistoryData(userData),
                  familyMedicalHistoryData(userData),
                  treatmentPlansData(userData),
                  doctorsRecommendationsData(userData),
                  healthcareProvidersData(userData),
                  healthcareDirectivesData(userData),
                  patientEducationMaterialData(userData),
                  healthAndWellnessData(userData),
                  getPassKey(userData),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget PersonalInformationCard(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Personal Information"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("User Name:", "${userData['name']}"),
                  buildText("Date of Birth:", "${userData['dob']}"),
                  buildText("Address:", "${userData['address']}"),
                  buildText("Contact Information:", "${userData['contact']}"),
                  buildText("Social Security Number:", "${userData['ssn']}"),
                  buildText("Insurance Details:", "${userData['insurance']}"),
                  buildText(
                      "Emergency Contact:", "${userData['emergencyContact']}"),
                  buildText("Occupation:", "${userData['occupation']}"),
                  buildText("Employer:", "${userData['employer']}"),
                  buildText("Ethnicity:", "${userData['ethnicity']}"),
                  buildText("Race:", "${userData['race']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget currentHealthStatusData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Current Health Status"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Symptoms:", "${userData['symptoms'] ?? ""}"),
                  buildText("Vital Signs:",
                      ""), // Assuming you want to add more details about vital signs in the subsequent lines

                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText(
                            "Blood Pressure:", "${userData['bloodPressure']}"),
                        buildText("Heart Rate:", "${userData['heartRate']}"),
                        buildText("Respiratory Rate:",
                            "${userData['respiratoryRate']}"),
                        buildText("Temperature:", "${userData['temperature']}"),
                      ],
                    ),
                  ),
                  buildText("Pain Levels and Descriptions:",
                      "${userData['painDescription']}"),
                  buildText(
                      "Changes in Weight:", "${userData['weightChanges']}"),
                  buildText("Sleep Patterns:", "${userData['sleepPatterns']}"),
                  buildText("Mental Health Status:",
                      "${userData['mentalHealthStatus']}"),
                  buildText("Recent Changes in Health:",
                      "${userData['recentHealthChanges']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget diagnosesAndTestResultsData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Diagnoses and Test Results"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Current Health Issues or Chronic Conditions:",
                      "${userData['healthIssues']} ?? " " "),
                  buildText("Recent Medical Test Results:", ""),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText(
                            "Blood Tests: ", "${userData['bloodTestResults']}"),
                        buildText("Imaging Studies: ",
                            "${userData['imagingStudyResults']}"),
                        buildText(
                            "Biopsy Results: ", "${userData['biopsyResults']}"),
                        // Add additional fields for other types of test results as needed
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget medicalHistoryData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Medical History"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Previous Illnesses and Conditions:",
                      "${userData['previousIllnesses']}"),
                  buildText(
                      "Surgical History:", "${userData['surgicalHistory']}"),
                  buildText("Chronic Conditions:",
                      "${userData['chronicConditions']}"),
                  buildText("Previous Hospitalizations:",
                      "${userData['previousHospitalizations']}"),
                  buildText("Past Injuries:", "${userData['pastInjuries']}"),
                  buildText("Substance Use History:",
                      "${userData['substanceUseHistory']}"),
                  buildText("Medication History:",
                      "${userData['medicationHistory']}"),
                  buildText("Allergies:", "${userData['allergies']}"),
                  buildText("Immunization History:",
                      "${userData['immunizationHistory']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget familyMedicalHistoryData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Family Medical History"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Family Health Conditions:",
                      "${userData['familyHealthConditions']}"),
                  buildText("Family Members' Specific Health Conditions:",
                      "${userData['familySpecificConditions']}"),
                  buildText("Age of Onset for Family Medical Conditions:",
                      "${userData['ageOfOnset']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget treatmentPlansData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Treatment Plans"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Current Treatment Plan:",
                      "${userData['treatmentPlan']}"),
                  buildText("Medication Instructions:",
                      "${userData['medicationInstructions']}"),
                  buildText("Dosage and Frequency of Medications:",
                      "${userData['medicationDosageFrequency']}"),
                  buildText("Physical Therapy or Rehabilitation Plans:",
                      "${userData['physicalTherapyPlans']}"),
                  buildText("Dietary Restrictions or Recommendations:",
                      "${userData['dietaryRecommendations']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget doctorsRecommendationsData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Doctor's Recommendations"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText(
                      "Healthcare Professional's Advice and Recommendations:",
                      "${userData['doctorRecommendations']}"),
                  buildText("Long-term Care Plans:",
                      "${userData['longTermCarePlans']}"),
                  buildText("Referrals to Specialists:",
                      "${userData['referralsToSpecialists']}"),
                  buildText("Restrictions on Physical Activity or Work:",
                      "${userData['physicalActivityRestrictions']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget healthcareProvidersData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Healthcare Providers"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Primary Care Physician:",
                      "${userData['primaryCarePhysician']}"),
                  buildText("Specialists:", "${userData['specialists']}"),
                  buildText("Other Healthcare Providers:",
                      "${userData['otherHealthcareProviders']}"),
                  buildText(
                      "Alternative or Complementary Medicine Practitioners:",
                      "${userData['alternativeMedicinePractitioners']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget healthcareDirectivesData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Healthcare Directives"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Advance Directives or Living Wills:",
                      "${userData['advanceDirectives']}"),
                  buildText(
                      "Living Will Details - Preferences for Life-Sustaining Treatments:",
                      "${userData['livingWillDetails']}"),
                  buildText("Power of Attorney for Healthcare Decisions:",
                      "${userData['powerOfAttorney']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget patientEducationMaterialData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Patient Education Material"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Information from Healthcare Professionals:",
                      "${userData['healthcareProfessionalsInfo']}"),
                  buildText(
                      "Brochures or Information Sheets about Medical Conditions:",
                      "${userData['medicalConditionBrochures']}"),
                  buildText(
                      "Instructions for Managing Chronic Conditions at Home:",
                      "${userData['chronicConditionInstructions']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget healthAndWellnessData(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Health and Wellness"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Lifestyle Information:",
                      "${userData['lifestyleInformation']}"),
                  buildText("Dietary Preferences or Restrictions:",
                      "${userData['dietaryPreferences']}"),
                  buildText("Exercise Routines and Preferences:",
                      "${userData['exercisePreferences']}"),
                  buildText("Stress Management Techniques:",
                      "${userData['stressManagementTechniques']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getPassKey(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Get Pass Key"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildText("Pass Key", "${userData['pass_key']}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
