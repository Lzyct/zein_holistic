import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/models/responses/patient_response.dart';
import 'package:zein_holistic/core/enums/enums.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 1/5/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class EditPatientPage extends StatefulWidget {
  EditPatientPage({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  _EditPatientPageState createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  TextEditingController _conName = TextEditingController();
  TextEditingController _conDateBirth = TextEditingController();
  TextEditingController _conAddress = TextEditingController();
  TextEditingController _conPhoneNumber = TextEditingController();
  TextEditingController _conAge = TextEditingController();

  FocusNode _fnName = FocusNode();
  FocusNode _fnDateBirth = FocusNode();
  FocusNode _fnAddress = FocusNode();
  FocusNode _fnPhoneNumber = FocusNode();

  var _sex = [Strings.man, Strings.woman];
  String? _selectedSex = "";
  var _isFirstLoad = true;
  var _id = "";

  var _formKey = GlobalKey<FormState>();

  late EditPatientBloc _editPatientBloc;
  late DetailPatientBloc _detailPatientBloc;

  @override
  void initState() {
    super.initState();
    _selectedSex = _sex[0];
    _editPatientBloc = BlocProvider.of(context);
    _detailPatientBloc = BlocProvider.of(context);

    _detailPatientBloc.getDetailPatient(widget.id.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _editPatientBloc.close();
    _detailPatientBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
        appBar: context.appBar(),
        isScroll: false,
        child: Container(
          constraints: BoxConstraints(maxWidth: Dimens.maxWidth),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              CustomToolbar(title: Strings.editPatient),
              Scrollbar(
                child: SingleChildScrollView(
                  child: BlocListener(
                    bloc: _editPatientBloc,
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
                      bloc: _detailPatientBloc,
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
                              if (_isFirstLoad) {
                                //set initial data
                                PatientResponse _patientResponse = state.data;
                                _conName.text = _patientResponse.data!.name!;
                                _conDateBirth.text =
                                    _patientResponse.data!.birthday!;
                                _conAddress.text =
                                    _patientResponse.data!.address!;
                                _conPhoneNumber.text =
                                    _patientResponse.data!.phoneNumber!;
                                _conAge.text = calculateAge(_patientResponse
                                    .data!.birthday!
                                    .toDateTime());
                                _selectedSex = _patientResponse.data!.sex;
                                _id = _patientResponse.data!.id!;
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
                                        hint: Strings.name,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        controller: _conName,
                                        curFocusNode: _fnName,
                                        nextFocusNode: _fnDateBirth,
                                        validator: (String? value) =>
                                            value!.isEmpty
                                                ? Strings.errorEmpty
                                                : null,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            Strings.sex,
                                            style: TextStyles.textHint,
                                          ),
                                          SizedBox(width: Dimens.space16),
                                          FlutterToggleTab(
                                              labels: _sex,
                                              width: Dimens.space16,
                                              height: Dimens.height35,
                                              initialIndex:
                                                  _sex.indexOf(_selectedSex!),
                                              selectedLabelIndex: (index) {
                                                _selectedSex = _sex[index];
                                              },
                                              selectedTextStyle:
                                                  TextStyles.white,
                                              borderRadius: Dimens.space16,
                                              unSelectedTextStyle:
                                                  TextStyles.primary),
                                        ],
                                      ).margin(
                                          edgeInsets: EdgeInsets.symmetric(
                                              vertical: Dimens.space8)),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: TextF(
                                              hint: Strings.dateBirth,
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: _conDateBirth,
                                              curFocusNode: DisableFocusNode(),
                                              nextFocusNode: _fnAddress,
                                              validator: (String? value) =>
                                                  value!.isEmpty
                                                      ? Strings.errorEmpty
                                                      : null,
                                              onTap: () async {
                                                var _result =
                                                    await context.datePicker(
                                                        currentDate:
                                                            _conDateBirth.text
                                                                .toDate());
                                                if (_result != null) {
                                                  _conDateBirth.text = _result
                                                      .toString()
                                                      .toStringDate();
                                                  _conAge.text =
                                                      calculateAge(_result);
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: Dimens.space16),
                                          Expanded(
                                            flex: 2,
                                            child: TextF(
                                              textInputAction:
                                                  TextInputAction.next,
                                              curFocusNode: DisableFocusNode(),
                                              controller: _conAge,
                                              hint: Strings.age,
                                              validator: (String? value) =>
                                                  value!.isEmpty
                                                      ? Strings.errorEmpty
                                                      : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextF(
                                        hint: Strings.address,
                                        textInputAction: TextInputAction.next,
                                        controller: _conAddress,
                                        curFocusNode: _fnAddress,
                                        nextFocusNode: _fnPhoneNumber,
                                        validator: (String? value) =>
                                            value!.isEmpty
                                                ? Strings.errorEmpty
                                                : null,
                                      ),
                                      TextF(
                                        hint: Strings.phoneNumber,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.phone,
                                        controller: _conPhoneNumber,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        curFocusNode: _fnPhoneNumber,
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            var _updatePatientRequest =
                                                PatientRequest(
                                                    name: _conName.text
                                                        .toString(),
                                                    sex:
                                                        _selectedSex.toString(),
                                                    birthday: _conDateBirth.text
                                                        .toString(),
                                                    address: _conAddress.text
                                                        .toString(),
                                                    phoneNumber: _conPhoneNumber
                                                        .text
                                                        .toString());
                                            _editPatientBloc.updatePatient(
                                                _updatePatientRequest, _id);
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
        ));
  }
}
