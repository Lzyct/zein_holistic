import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/medical_record_request.dart';
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
class EditMedicalRecordPage extends StatefulWidget {
  EditMedicalRecordPage({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  _EditMedicalRecordPageState createState() => _EditMedicalRecordPageState();
}

class _EditMedicalRecordPageState extends State<EditMedicalRecordPage> {
  TextEditingController _conMainComplaint = TextEditingController();
  TextEditingController _conAdditionalComplaint = TextEditingController();
  TextEditingController _conHistoryOfDisease = TextEditingController();
  TextEditingController _conCheckUpResult = TextEditingController();
  TextEditingController _conConclusionDiagnosis = TextEditingController();
  TextEditingController _conSuggestion = TextEditingController();
  TextEditingController _conExaminer = TextEditingController();

  FocusNode _fnMainComplaint = FocusNode();
  FocusNode _fnAdditionalComplaint = FocusNode();
  FocusNode _fnHistoryOfDisease = FocusNode();
  FocusNode _fnConclusionDiagnosis = FocusNode();
  FocusNode _fnSuggestion = FocusNode();
  FocusNode _fnExaminer = FocusNode();

  var _formKey = GlobalKey<FormState>();
  var _isFirstLoad = true;

  late EditMedicalRecordBloc _editMedicalRecordBloc;
  late DetailMedicalRecordBloc _detailMedicalRecordBloc;
  var _idPatient = "";

  @override
  void initState() {
    super.initState();
    _editMedicalRecordBloc = BlocProvider.of(context);
    _detailMedicalRecordBloc = BlocProvider.of(context);
    _detailMedicalRecordBloc.getDetailMedicalRecord(widget.id.toString());

    _conMainComplaint.addListener(() {
      logs("listener : ${_conMainComplaint.text}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _editMedicalRecordBloc.close();
    _detailMedicalRecordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    logs("isBuild");
    return Parent(
      appBar: context.appBar(),
      child: Container(
        constraints: BoxConstraints(maxWidth: Dimens.maxWidth),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            CustomToolbar(title: Strings.editMedicalRecord),
            Scrollbar(
              child: SingleChildScrollView(
                child: BlocListener(
                  bloc: _editMedicalRecordBloc,
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
                            if (_isFirstLoad) {
                              MedicalRecordResponse _medicalRecordResponse =
                                  state.data;
                              _conMainComplaint.text =
                                  _medicalRecordResponse.data!.mainComplaint!;
                              _conAdditionalComplaint.text =
                                  _medicalRecordResponse
                                      .data!.additionalComplaint!;
                              _conHistoryOfDisease.text = _medicalRecordResponse
                                  .data!.historyOfDisease!;
                              _conCheckUpResult.text =
                                  _medicalRecordResponse.data!.checkUpResult!;
                              _conConclusionDiagnosis.text =
                                  _medicalRecordResponse
                                      .data!.conclusionDiagnosis!;
                              _conSuggestion.text =
                                  _medicalRecordResponse.data!.suggestion!;
                              _conExaminer.text =
                                  _medicalRecordResponse.data!.examiner!;
                              _idPatient =
                                  _medicalRecordResponse.data!.idPatient!;

                              _isFirstLoad = false;
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.isDesktop(context)
                                      ? context.dp36()
                                      : context.dp4()),
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
                                          value!.isEmpty
                                              ? Strings.errorEmpty
                                              : null,
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
                                      textInputAction: TextInputAction.next,
                                      controller: _conExaminer,
                                      curFocusNode: _fnExaminer,
                                      nextFocusNode: null,
                                      validator: (String? value) =>
                                          value!.isEmpty
                                              ? Strings.errorEmpty
                                              : null,
                                    ),
                                    SizedBox(height: Dimens.space16),
                                    Button(
                                      title: Strings.save,
                                      color: Palette.colorPrimary,
                                      width: double.infinity,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          var _request = MedicalRecordRequest(
                                              idPatient: _idPatient.toString(),
                                              mainComplaint:
                                                  _conMainComplaint.text,
                                              additionalComplaint:
                                                  _conAdditionalComplaint.text,
                                              historyOfDisease:
                                                  _conHistoryOfDisease.text,
                                              checkUpResult:
                                                  _conCheckUpResult.text,
                                              conclusionDiagnosis:
                                                  _conConclusionDiagnosis.text,
                                              suggestion: _conSuggestion.text,
                                              examiner: _conExaminer.text);
                                          _editMedicalRecordBloc
                                              .editMedicalRecord(_request,
                                                  widget.id.toString());
                                        }
                                      },
                                    )
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
            ),
          ],
        ),
      ),
    );
  }
}
