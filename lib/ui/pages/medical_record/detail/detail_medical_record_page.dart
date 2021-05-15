import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/responses/medical_record_response.dart';
import 'package:zein_holistic/core/enums/enums.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 1/7/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class DetailMedicalRecordPage extends StatefulWidget {
  DetailMedicalRecordPage({Key? key, this.id}) : super(key: key);
  final String? id;

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

  late DetailMedicalRecordBloc _detailMedicalRecordBloc;

  @override
  void initState() {
    super.initState();
    _detailMedicalRecordBloc = BlocProvider.of(context);
    _detailMedicalRecordBloc.getDetailMedicalRecord(widget.id.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _detailMedicalRecordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(),
      child: Container(
        constraints: BoxConstraints(maxWidth: Dimens.maxWidth),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            CustomToolbar(title: Strings.detailMedicalRecord),
            Scrollbar(
              child: SingleChildScrollView(
                child: BlocBuilder(
                  bloc: _detailMedicalRecordBloc,
                  builder: (_, dynamic state) {
                    switch (state.status) {
                      case Status.LOADING:
                        {
                          return Center(child: Loading());
                        }
                      case Status.ERROR:
                        {
                          return Center(
                            child: Empty(
                              errorMessage: state.message.toString(),
                            ),
                          );
                        }
                      case Status.SUCCESS:
                        {
                          //set initial data
                          MedicalRecordResponse _medicalRecordEntity =
                              state.data;
                          _conMainComplaint.text =
                              _medicalRecordEntity.data!.mainComplaint!;
                          _conAdditionalComplaint.text =
                              _medicalRecordEntity.data!.additionalComplaint!;
                          _conHistoryOfDisease.text =
                              _medicalRecordEntity.data!.historyOfDisease!;
                          _conCheckUpResult.text =
                              _medicalRecordEntity.data!.checkUpResult!;
                          _conConclusionDiagnosis.text =
                              _medicalRecordEntity.data!.conclusionDiagnosis!;
                          _conSuggestion.text =
                              _medicalRecordEntity.data!.suggestion!;
                          _conExaminer.text =
                              _medicalRecordEntity.data!.examiner!;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.isDesktop(context)
                                    ? context.dp36()
                                    : context.dp4()),
                            child: Form(
                              child: Column(
                                children: [
                                  TextF(
                                    hint: Strings.mainComplaint,
                                    textInputAction: TextInputAction.next,
                                    controller: _conMainComplaint,
                                    curFocusNode: DisableFocusNode(),
                                    validator: (String? value) => value!.isEmpty
                                        ? Strings.errorEmpty
                                        : null,
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
                            ),
                          );
                        }
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
