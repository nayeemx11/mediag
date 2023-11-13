import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediag/screens/authentication/login_screen.dart';
import 'package:mediag/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class personalInfoUpdate extends StatefulWidget {
  final String _email;
  final String _reegitratrionid;

  personalInfoUpdate(this._email, this._reegitratrionid);

  @override
  _personalInfoUpdateState createState() =>
      _personalInfoUpdateState(_email, _reegitratrionid);
}

class _personalInfoUpdateState extends State<personalInfoUpdate> {
  final String _email;
  final String _reegitratrionid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Future<DocumentSnapshot> userData;
  _personalInfoUpdateState(this._email, this._reegitratrionid);
  Future<DocumentSnapshot> fetchUserData() async {
    return await FirebaseFirestore.instance
        .collection(
            _reegitratrionid) // Use _registrationId instead of widget.registrationId
        .doc(_email) // Use _email instead of widget.email
        .get();
  }

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
    notSetYet(userData);
  }

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Splash_ScreenState.KEYLOGIN, false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login_Screen()),
    );
  }

  void setControllerText(TextEditingController controller, String key,
      Map<String, dynamic> userData) {
    String value = userData[key];
    controller.text = value ?? "not set yet";
  }

  void notSetYet(Future<DocumentSnapshot> userData) async {
    DocumentSnapshot snapshot =
        await fetchUserData(); // Wait for the Future to complete
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    setControllerText(nameController, 'name', userData);
    setControllerText(dobController, 'dob', userData);
    setControllerText(addressController, 'address', userData);
    setControllerText(contactController, 'contact', userData);
    setControllerText(ssnController, 'ssn', userData);
    setControllerText(insuranceController, 'insurance', userData);
    setControllerText(emergencyContactController, 'emergencyContact', userData);
    setControllerText(occupationController, 'occupation', userData);
    setControllerText(employerController, 'employer', userData);
    setControllerText(ethnicityController, 'ethnicity', userData);
    setControllerText(raceController, 'race', userData);

    setControllerText(symptomsController, 'symptoms', userData);
    setControllerText(bloodPressureController, 'bloodPressure', userData);
    setControllerText(heartRateController, 'heartRate', userData);
    setControllerText(respiratoryRateController, 'respiratoryRate', userData);
    setControllerText(temperatureController, 'temperature', userData);
    setControllerText(painDescriptionController, 'painDescription', userData);
    setControllerText(weightChangesController, 'weightChanges', userData);
    setControllerText(sleepPatternsController, 'sleepPatterns', userData);
    setControllerText(
        mentalHealthStatusController, 'mentalHealthStatus', userData);
    setControllerText(
        recentHealthChangesController, 'recentHealthChanges', userData);

    setControllerText(healthIssuesController, 'healthIssues', userData);
    setControllerText(bloodTestResultsController, 'bloodTestResults', userData);
    setControllerText(
        imagingStudyResultsController, 'imagingStudyResults', userData);
    setControllerText(biopsyResultsController, 'biopsyResults', userData);

    setControllerText(
        previousIllnessesController, 'previousIllnesses', userData);
    setControllerText(surgicalHistoryController, 'surgicalHistory', userData);
    setControllerText(
        chronicConditionsController, 'chronicConditions', userData);
    setControllerText(previousHospitalizationsController,
        'previousHospitalizations', userData);
    setControllerText(pastInjuriesController, 'pastInjuries', userData);
    setControllerText(
        substanceUseHistoryController, 'substanceUseHistory', userData);
    setControllerText(
        medicationHistoryController, 'medicationHistory', userData);
    setControllerText(allergiesController, 'allergies', userData);
    setControllerText(
        immunizationHistoryController, 'immunizationHistory', userData);

    setControllerText(
        familyHealthConditionsController, 'familyHealthConditions', userData);
    setControllerText(familySpecificConditionsController,
        'familySpecificConditions', userData);
    setControllerText(ageOfOnsetController, 'ageOfOnset', userData);

    setControllerText(treatmentPlanController, 'treatmentPlan', userData);
    setControllerText(
        medicationInstructionsController, 'medicationInstructions', userData);
    setControllerText(medicationDosageFrequencyController,
        'medicationDosageFrequency', userData);
    setControllerText(
        physicalTherapyPlansController, 'physicalTherapyPlans', userData);
    setControllerText(
        dietaryRecommendationsController, 'dietaryRecommendations', userData);

    setControllerText(
        doctorRecommendationsController, 'doctorRecommendations', userData);
    setControllerText(
        longTermCarePlansController, 'longTermCarePlans', userData);
    setControllerText(
        referralsToSpecialistsController, 'referralsToSpecialists', userData);
    setControllerText(physicalActivityRestrictionsController,
        'physicalActivityRestrictions', userData);

    setControllerText(
        primaryCarePhysicianController, 'primaryCarePhysician', userData);
    setControllerText(specialistsController, 'specialists', userData);
    setControllerText(otherHealthcareProvidersController,
        'otherHealthcareProviders', userData);
    setControllerText(alternativeMedicinePractitionersController,
        'alternativeMedicinePractitioners', userData);

    setControllerText(
        advanceDirectivesController, 'advanceDirectives', userData);
    setControllerText(
        livingWillDetailsController, 'livingWillDetails', userData);
    setControllerText(powerOfAttorneyController, 'powerOfAttorney', userData);

    setControllerText(healthcareProfessionalsInfoController,
        'healthcareProfessionalsInfo', userData);
    setControllerText(medicalConditionBrochuresController,
        'medicalConditionBrochures', userData);
    setControllerText(chronicConditionInstructionsController,
        'chronicConditionInstructions', userData);

    setControllerText(
        lifestyleInformationController, 'lifestyleInformation', userData);
    setControllerText(
        dietaryPreferencesController, 'dietaryPreferences', userData);
    setControllerText(
        exercisePreferencesController, 'exercisePreferences', userData);
    setControllerText(stressManagementTechniquesController,
        'stressManagementTechniques', userData);

    setControllerText(pass_keyController, 'pass_key', userData);
  }

  void showCongratulationSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Congratulations! Information updated successfully.'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Method to update information in Firebase Firestore
  void updateFirebaseFirestore() {
    FirebaseFirestore.instance
        .collection(_reegitratrionid) // Use your collection name here
        .doc(_email) // Use the document ID (e.g., user's email) as needed
        .set({
      'name': nameController.text,
      'dob': dobController.text,
      'address': addressController.text,
      'contact': contactController.text,
      'ssn': ssnController.text,
      'insurance': insuranceController.text,
      'emergencyContact': emergencyContactController.text,
      'occupation': occupationController.text,
      'employer': employerController.text,
      'ethnicity': ethnicityController.text,
      'race': raceController.text,
      'symptomsController': symptomsController.text,
      'bloodPressure': bloodPressureController.text,
      'heartRate': heartRateController.text,
      'respiratoryRate': respiratoryRateController.text,
      'temperature': temperatureController.text,
      'painDescription': painDescriptionController.text,
      'weightChanges': weightChangesController.text,
      'sleepPatterns': sleepPatternsController.text,
      'mentalHealthStatus': mentalHealthStatusController.text,
      'recentHealthChanges': recentHealthChangesController.text,
      'healthIssues': healthIssuesController.text,
      'bloodTestResults': bloodTestResultsController.text,
      'imagingStudyResults': imagingStudyResultsController.text,
      'biopsyResults': biopsyResultsController.text,
      'previousIllnesses': previousIllnessesController.text,
      'surgicalHistory': surgicalHistoryController.text,
      'chronicConditions': chronicConditionsController.text,
      'previousHospitalizations': previousHospitalizationsController.text,
      'pastInjuries': pastInjuriesController.text,
      'substanceUseHistory': substanceUseHistoryController.text,
      'medicationHistory': medicationHistoryController.text,
      'allergies': allergiesController.text,
      'immunizationHistory': immunizationHistoryController.text,
      'familyHealthConditions': familyHealthConditionsController.text,
      'familySpecificConditions': familySpecificConditionsController.text,
      'ageOfOnset': ageOfOnsetController.text,
      'treatmentPlan': treatmentPlanController.text,
      'medicationInstructions': medicationInstructionsController.text,
      'medicationDosageFrequency': medicationDosageFrequencyController.text,
      'physicalTherapyPlans': physicalTherapyPlansController.text,
      'dietaryRecommendations': dietaryRecommendationsController.text,
      'doctorRecommendations': doctorRecommendationsController.text,
      'longTermCarePlans': longTermCarePlansController.text,
      'referralsToSpecialists': referralsToSpecialistsController.text,
      'physicalActivityRestrictions':
          physicalActivityRestrictionsController.text,
      'primaryCarePhysician': primaryCarePhysicianController.text,
      'specialists': specialistsController.text,
      'otherHealthcareProviders': otherHealthcareProvidersController.text,
      'alternativeMedicinePractitioners':
          alternativeMedicinePractitionersController.text,
      'advanceDirectives': advanceDirectivesController.text,
      'livingWillDetails': livingWillDetailsController.text,
      'powerOfAttorney': powerOfAttorneyController.text,
      'healthcareProfessionalsInfo': healthcareProfessionalsInfoController.text,
      'medicalConditionBrochures': medicalConditionBrochuresController.text,
      'chronicConditionInstructions':
          chronicConditionInstructionsController.text,
      'lifestyleInformation': lifestyleInformationController.text,
      'dietaryPreferences': dietaryPreferencesController.text,
      'exercisePreferences': exercisePreferencesController.text,
      'stressManagementTechniques': stressManagementTechniquesController.text,
      'pass_key': pass_keyController.text,
    }).then((_) {
      // Show a success message, navigate back, or perform other actions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Information updated successfully'),
      ));
    }).catchError((error) {
      // Handle errors, show an error message, or perform other actions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Error updating information: $error'),
      ));
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController emergencyContactController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController employerController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController raceController = TextEditingController();

  TextEditingController symptomsController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController respiratoryRateController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController painDescriptionController = TextEditingController();
  TextEditingController weightChangesController = TextEditingController();
  TextEditingController sleepPatternsController = TextEditingController();
  TextEditingController mentalHealthStatusController = TextEditingController();
  TextEditingController recentHealthChangesController = TextEditingController();

  TextEditingController healthIssuesController = TextEditingController();
  TextEditingController bloodTestResultsController = TextEditingController();
  TextEditingController imagingStudyResultsController = TextEditingController();
  TextEditingController biopsyResultsController = TextEditingController();
// Add additional controllers for other types of test results as needed

  TextEditingController previousIllnessesController = TextEditingController();
  TextEditingController surgicalHistoryController = TextEditingController();
  TextEditingController chronicConditionsController = TextEditingController();
  TextEditingController previousHospitalizationsController =
      TextEditingController();
  TextEditingController pastInjuriesController = TextEditingController();
  TextEditingController substanceUseHistoryController = TextEditingController();
  TextEditingController medicationHistoryController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController immunizationHistoryController = TextEditingController();

  TextEditingController familyHealthConditionsController =
      TextEditingController();
  TextEditingController familySpecificConditionsController =
      TextEditingController();
  TextEditingController ageOfOnsetController = TextEditingController();

  TextEditingController treatmentPlanController = TextEditingController();
  TextEditingController medicationInstructionsController =
      TextEditingController();
  TextEditingController medicationDosageFrequencyController =
      TextEditingController();
  TextEditingController physicalTherapyPlansController =
      TextEditingController();
  TextEditingController dietaryRecommendationsController =
      TextEditingController();

  TextEditingController doctorRecommendationsController =
      TextEditingController();
  TextEditingController longTermCarePlansController = TextEditingController();
  TextEditingController referralsToSpecialistsController =
      TextEditingController();
  TextEditingController physicalActivityRestrictionsController =
      TextEditingController();

  TextEditingController primaryCarePhysicianController =
      TextEditingController();
  TextEditingController specialistsController = TextEditingController();
  TextEditingController otherHealthcareProvidersController =
      TextEditingController();
  TextEditingController alternativeMedicinePractitionersController =
      TextEditingController();

  TextEditingController advanceDirectivesController = TextEditingController();
  TextEditingController livingWillDetailsController = TextEditingController();
  TextEditingController powerOfAttorneyController = TextEditingController();

  TextEditingController healthcareProfessionalsInfoController =
      TextEditingController();
  TextEditingController medicalConditionBrochuresController =
      TextEditingController();
  TextEditingController chronicConditionInstructionsController =
      TextEditingController();

  TextEditingController lifestyleInformationController =
      TextEditingController();
  TextEditingController dietaryPreferencesController = TextEditingController();
  TextEditingController exercisePreferencesController = TextEditingController();
  TextEditingController stressManagementTechniquesController =
      TextEditingController();

  TextEditingController pass_keyController = TextEditingController();

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 60, // Adjust the height as needed
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Information Input'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'updateEmail') {
                // _updateEmail();
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
                // PopupMenuItem<String>(
                //   value: 'updateEmail',
                //   child: Text('Update Email'),
                // ),
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
        future: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  PersonalInformationUpdateCard(userData),
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
      floatingActionButton: SizedBox(
        width: 248,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          onPressed: () {
            updateFirebaseFirestore();
            showCongratulationSnackbar(context);
          },
          tooltip: 'Update Information to Database',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Update"),
              SizedBox(width: 8),
              Icon(Icons.update),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPassKey(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Get Pass Key"),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('pass_key', pass_keyController),
            ],
          ),
        ],
      ),
    );
  }

  Widget PersonalInformationUpdateCard(Map<String, dynamic> userData) {
    return Card(
      child: ExpansionTile(
        title: Text("Personal Information"),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Name', nameController),
              buildTextField('Date of Birth', dobController),
              buildTextField('Address', addressController),
              buildTextField('Contact', contactController),
              buildTextField('SSN', ssnController),
              buildTextField('Insurance', insuranceController),
              buildTextField('Emergency Contact', emergencyContactController),
              buildTextField('Occupation', occupationController),
              buildTextField('Employer', employerController),
              buildTextField('Ethnicity', ethnicityController),
              buildTextField('Race', raceController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Symptoms', symptomsController),
              buildTextField('Blood Pressure', bloodPressureController),
              buildTextField('Heart Rate', heartRateController),
              buildTextField('Respiratory Rate', respiratoryRateController),
              buildTextField('Temperature', temperatureController),
              buildTextField('Pain Description', painDescriptionController),
              buildTextField('Weight Changes', weightChangesController),
              buildTextField('Sleep Patterns', sleepPatternsController),
              buildTextField(
                  'Mental Health Status', mentalHealthStatusController),
              buildTextField(
                  'Recent Health Changes', recentHealthChangesController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Health Issues', healthIssuesController),
              buildTextField('Blood Test Results', bloodTestResultsController),
              buildTextField(
                  'Imaging Study Results', imagingStudyResultsController),
              buildTextField('Biopsy Results', biopsyResultsController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Previous Illnesses', previousIllnessesController),
              buildTextField('Surgical History', surgicalHistoryController),
              buildTextField('Chronic Conditions', chronicConditionsController),
              buildTextField('Previous Hospitalizations',
                  previousHospitalizationsController),
              buildTextField('Past Injuries', pastInjuriesController),
              buildTextField(
                  'Substance Use History', substanceUseHistoryController),
              buildTextField('Medication History', medicationHistoryController),
              buildTextField('Allergies', allergiesController),
              buildTextField(
                  'Immunization History', immunizationHistoryController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField(
                  'Family Health Conditions', familyHealthConditionsController),
              buildTextField('Family Specific Conditions',
                  familySpecificConditionsController),
              buildTextField('Age of Onset', ageOfOnsetController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Treatment Plan', treatmentPlanController),
              buildTextField(
                  'Medication Instructions', medicationInstructionsController),
              buildTextField('Medication Dosage Frequency',
                  medicationDosageFrequencyController),
              buildTextField(
                  'Physical Therapy Plans', physicalTherapyPlansController),
              buildTextField(
                  'Dietary Recommendations', dietaryRecommendationsController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField(
                  'Doctor Recommendations', doctorRecommendationsController),
              buildTextField(
                  'Long Term Care Plans', longTermCarePlansController),
              buildTextField(
                  'Referrals to Specialists', referralsToSpecialistsController),
              buildTextField('Physical Activity Restrictions',
                  physicalActivityRestrictionsController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField(
                  'Primary Care Physician', primaryCarePhysicianController),
              buildTextField('Specialists', specialistsController),
              buildTextField('Other Healthcare Providers',
                  otherHealthcareProvidersController),
              buildTextField('Alternative Medicine Practitioners',
                  alternativeMedicinePractitionersController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Advance Directives', advanceDirectivesController),
              buildTextField(
                  'Living Will Details', livingWillDetailsController),
              buildTextField('Power of Attorney', powerOfAttorneyController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField('Healthcare Professionals Info',
                  healthcareProfessionalsInfoController),
              buildTextField('Medical Condition Brochures',
                  medicalConditionBrochuresController),
              buildTextField('Chronic Condition Instructions',
                  chronicConditionInstructionsController),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 8),
              buildTextField(
                  'Lifestyle Information', lifestyleInformationController),
              buildTextField(
                  'Dietary Preferences', dietaryPreferencesController),
              buildTextField(
                  'Exercise Preferences', exercisePreferencesController),
              buildTextField('Stress Management Techniques',
                  stressManagementTechniquesController),
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Edit Profile'),
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: ListView(
  //             padding: EdgeInsets.all(16.0),
  //             children:[

  //             ],
  //             ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             updateFirebaseFirestore();
  //             showCongratulationSnackbar(context);
  //           },
  //           child: Container(
  //             height: 80, // Increase the height as needed
  //             decoration: BoxDecoration(
  //               color: Colors.red, // Background color of the container
  //               borderRadius: BorderRadius.circular(40), // Circular corners
  //             ),
  //             child: Center(
  //               child: Text(
  //                 "Update information",
  //                 style: TextStyle(fontSize: 18, color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
