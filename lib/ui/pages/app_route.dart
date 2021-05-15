import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/responses/list_patient_response.dart';
import 'package:zein_holistic/ui/pages/pages.dart';

class AppRoute {
  AppRoute._();

  // patient
  static const String patient = "patient";
  static const String listPatient = "$patient/list";
  static const String addPatient = "$patient/add";
  static const String editPatient = "$patient/edit";

  // medical record
  static const String medicalRecord = "medical-record";
  static const String listMedicalRecord = "$medicalRecord/list";
  static const String addMedicalRecord = "$medicalRecord/add";
  static const String editMedicalRecord = "$medicalRecord/edit";
  static const String detailMedicalRecord = "$medicalRecord/detail";

  //define page route
  static Map<String, WidgetBuilder> getRoutes({RouteSettings? settings}) => {
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
              patientData: _args["patient"] as Data,
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
