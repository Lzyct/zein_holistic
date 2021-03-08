import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
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
class DetailMedicalRecordPage extends StatefulWidget {
  DetailMedicalRecordPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _DetailMedicalRecordPageState createState() =>
      _DetailMedicalRecordPageState();
}

class _DetailMedicalRecordPageState extends State<DetailMedicalRecordPage> {
  var _conMainComplaint = TextEditingController();
  var _conAdditionalComplaint = TextEditingController();
  var _conHistoryOfDisease = TextEditingController();
  var _conCheckUpResult = TextEditingController();
  var _conConclusionDiagnosis = TextEditingController();
  var _conSuggestion = TextEditingController();
  var _conExaminer = TextEditingController();

  DetailMedicalRecordBloc _detailMedicalRecordBloc;

  @override
  void initState() {
    super.initState();
    _detailMedicalRecordBloc = BlocProvider.of(context);
    _detailMedicalRecordBloc.getDetailMedicalRecord(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.detailMedicalRecord),
      child: SingleChildScrollView(
        child: BlocBuilder(
          cubit: _detailMedicalRecordBloc,
          builder: (_, state) {
            switch (state.status) {
              case Status.LOADING:
                {
                  return Center(child: Loading());
                }
                break;
              case Status.ERROR:
                {
                  return Center(
                    child: Empty(
                      errorMessage: state.message.toString(),
                    ),
                  );
                }
                break;
              case Status.SUCCESS:
                {
                  //set initial data
                  MedicalRecordEntity _medicalRecordEntity = state.data;
                  _conMainComplaint.text = _medicalRecordEntity.mainComplaint;
                  _conAdditionalComplaint.text =
                      _medicalRecordEntity.additionalComplaint;
                  _conHistoryOfDisease.text =
                      _medicalRecordEntity.historyOfDisease;
                  _conCheckUpResult.text = _medicalRecordEntity.checkUpResult;
                  _conConclusionDiagnosis.text =
                      _medicalRecordEntity.conclusionDiagnosis;
                  _conSuggestion.text = _medicalRecordEntity.suggestion;
                  _conExaminer.text = _medicalRecordEntity.examiner;
                  return Form(
                    child: Column(
                      children: [
                        TextF(
                          hint: Strings.mainComplaint,
                          textInputAction: TextInputAction.next,
                          controller: _conMainComplaint,
                          curFocusNode: DisableFocusNode(),
                          validator: (value) =>
                              value.isEmpty ? Strings.errorEmpty : null,
                        ),
                        TextF(
                          hint: Strings.additionalComplaint,
                          textInputAction: TextInputAction.next,
                          controller: _conAdditionalComplaint,
                          curFocusNode: DisableFocusNode(),
                        ),
                        TextF(
                          hint: Strings.historyOfDisease,
                          textInputAction: TextInputAction.next,
                          controller: _conHistoryOfDisease,
                          curFocusNode: DisableFocusNode(),
                        ),
                        TextF(
                          hint: Strings.conclusionDiagnosis,
                          textInputAction: TextInputAction.next,
                          controller: _conConclusionDiagnosis,
                          curFocusNode: DisableFocusNode(),
                        ),
                        TextF(
                          hint: Strings.suggestion,
                          textInputAction: TextInputAction.next,
                          controller: _conSuggestion,
                          curFocusNode: DisableFocusNode(),
                        ),
                        TextF(
                          hint: Strings.examiner,
                          textInputAction: TextInputAction.done,
                          controller: _conExaminer,
                          curFocusNode: DisableFocusNode(),
                        ),
                      ],
                    ),
                  );
                }
                break;
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
