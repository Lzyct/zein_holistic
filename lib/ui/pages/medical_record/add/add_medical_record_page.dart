import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/enums/enums.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 1/7/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class AddMedicalRecordPage extends StatefulWidget {
  AddMedicalRecordPage({Key? key, this.idPatient}) : super(key: key);
  final String? idPatient;

  @override
  _AddMedicalRecordPageState createState() => _AddMedicalRecordPageState();
}

class _AddMedicalRecordPageState extends State<AddMedicalRecordPage> {
  var _conMainComplaint = TextEditingController();
  var _conAdditionalComplaint = TextEditingController();
  var _conHistoryOfDisease = TextEditingController();
  var _conCheckUpResult = TextEditingController();
  var _conConclusionDiagnosis = TextEditingController();
  var _conSuggestion = TextEditingController();
  var _conExaminer = TextEditingController();

  var _fnMainComplaint = FocusNode();
  var _fnAdditionalComplaint = FocusNode();
  var _fnHistoryOfDisease = FocusNode();
  var _fnConclusionDiagnosis = FocusNode();
  var _fnSuggestion = FocusNode();
  var _fnExaminer = FocusNode();

  var _formKey = GlobalKey<FormState>();

  late AddMedicalRecordBloc _addMedicalRecordBloc;

  @override
  void initState() {
    super.initState();
    _addMedicalRecordBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _addMedicalRecordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addMedicalRecord),
      child: SingleChildScrollView(
        child: BlocListener(
          bloc: _addMedicalRecordBloc,
          listener: (_, dynamic state) {
            switch (state.status) {
              case Status.LOADING:
                {
                  Strings.pleaseWait.toToastLoading();
                }
                break;
              case Status.ERROR:
                {
                  state.message.toString().toToastError();
                }
                break;
              case Status.SUCCESS:
                {
                  Strings.successSaveData.toToastSuccess();
                  Navigator.pop(context);
                }
                break;
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextF(
                  hint: Strings.mainComplaint,
                  textInputAction: TextInputAction.next,
                  controller: _conMainComplaint,
                  curFocusNode: _fnMainComplaint,
                  nextFocusNode: _fnAdditionalComplaint,
                  validator: (String? value) =>
                      value!.isEmpty ? Strings.errorEmpty : null,
                ),
                TextF(
                  hint: Strings.additionalComplaint,
                  textInputAction: TextInputAction.next,
                  controller: _conAdditionalComplaint,
                  curFocusNode: _fnAdditionalComplaint,
                  nextFocusNode: _fnHistoryOfDisease,
                ),
                TextF(
                  hint: Strings.historyOfDisease,
                  textInputAction: TextInputAction.next,
                  controller: _conHistoryOfDisease,
                  curFocusNode: _fnHistoryOfDisease,
                  nextFocusNode: _fnConclusionDiagnosis,
                ),
                TextF(
                  hint: Strings.conclusionDiagnosis,
                  textInputAction: TextInputAction.next,
                  controller: _conConclusionDiagnosis,
                  curFocusNode: _fnConclusionDiagnosis,
                  nextFocusNode: _fnSuggestion,
                ),
                TextF(
                  hint: Strings.suggestion,
                  textInputAction: TextInputAction.next,
                  controller: _conSuggestion,
                  curFocusNode: _fnSuggestion,
                  nextFocusNode: _fnExaminer,
                ),
                TextF(
                  hint: Strings.examiner,
                  textInputAction: TextInputAction.done,
                  controller: _conExaminer,
                  curFocusNode: _fnExaminer,
                  validator: (String? value) =>
                      value!.isEmpty ? Strings.errorEmpty : null,
                ),
                SizedBox(height: context.dp16()),
                Button(
                  title: Strings.save,
                  color: Palette.colorPrimary,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var _params = {
                        'idPatient': widget.idPatient,
                        'mainComplaint': _conMainComplaint.text,
                        'additionalComplaint': _conAdditionalComplaint.text,
                        'historyOfDisease': _conHistoryOfDisease.text,
                        'checkUpResult': _conCheckUpResult.text,
                        'conclusionDiagnosis': _conConclusionDiagnosis.text,
                        'suggestion': _conSuggestion.text,
                        'examiner': _conExaminer.text
                      };
                      _addMedicalRecordBloc.addMedicalRecord(_params);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
