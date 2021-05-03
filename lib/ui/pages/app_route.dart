import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/entities/patient_entity.dart';
import 'package:zein_holistic/ui/pages/pages.dart';

class AppRoute {
  AppRoute._();

  //define page route name
  static const String splashScreen = "splashscreen";
  static const String mainScreen = "main";
  // patient
  static const String listPatient = "patient/list";
  static const String addPatient = "patient/add";
  static const String editPatient = "patient/edit";

  // medical record
  static const String listMedicalRecord = "medical-record/list";
  static const String addMedicalRecord = "medical-record/add";
  static const String editMedicalRecord = "medical-record/edit";
  static const String detailMedicalRecord = "medical-record/detail";

  //define page route
  static Map<String, WidgetBuilder> getRoutes({RouteSettings? settings}) => {
        splashScreen: (_) => SplashScreenPage(),
        addPatient: (_) => BlocProvider(
            create: (_) => AddPatientBloc(), child: AddPatientPage()),
        editPatient: (_) {
          //get arguments
          var _args = settings?.arguments as Map<String, Object?>;
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => EditPatientBloc()),
                BlocProvider(create: (_) => DetailPatientBloc()),
              ],
              child: EditPatientPage(
                id: _args["id"] as String,
              ));
        },
        listPatient: (_) => MultiBlocProvider(providers: [
              BlocProvider(create: (_) => ListPatientBloc()),
              BlocProvider(create: (_) => DeletePatientBloc())
            ], child: ListPatientPage()),
        listMedicalRecord: (_) {
          var _args = settings?.arguments as Map<String, Object?>;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => ListMedicalRecordBloc(),
              ),
              BlocProvider(
                create: (_) => DeleteMedicalRecordBloc(),
              )
            ],
            child: ListMedicalRecordPage(
              patientEntity: _args["patient"] as PatientEntity,
            ),
          );
        },
        addMedicalRecord: (_) {
          var _args = settings?.arguments as Map<String, Object?>;
          return BlocProvider(
              create: (_) => AddMedicalRecordBloc(),
              child: AddMedicalRecordPage(
                  idPatient: _args["idPatient"] as String));
        },
        editMedicalRecord: (_) {
          var _args = settings?.arguments as Map<String, Object?>;
          return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => EditMedicalRecordBloc()),
                BlocProvider(create: (_) => DetailMedicalRecordBloc()),
              ],
              child: EditMedicalRecordPage(
                id: _args["id"] as String,
              ));
        },
        detailMedicalRecord: (_) {
          var _args = settings?.arguments as Map<String, Object?>;
          return BlocProvider(
            create: (_) => DetailMedicalRecordBloc(),
            child: DetailMedicalRecordPage(
              id: _args["id"] as String,
            ),
          );
        }
      };
}
