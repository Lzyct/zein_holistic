import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/entities/patient_entity.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:zein_holistic/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 1/5/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class EditPatientPage extends StatefulWidget {
  EditPatientPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _EditPatientPageState createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  var _conName = TextEditingController();
  var _conDateBirth = TextEditingController();
  var _conAddress = TextEditingController();
  var _conPhoneNumber = TextEditingController();
  var _conAge = TextEditingController();

  var _fnName = FocusNode();
  var _fnDateBirth = FocusNode();
  var _fnAddress = FocusNode();
  var _fnPhoneNumber = FocusNode();

  var _sex = [Strings.man, Strings.woman];
  var _selectedSex = "";

  var _formKey = GlobalKey<FormState>();

  EditPatientBloc _editPatientBloc;
  DetailPatientBloc _detailPatientBloc;

  @override
  void initState() {
    super.initState();
    _selectedSex = _sex[0];
    _editPatientBloc = BlocProvider.of(context);
    _detailPatientBloc = BlocProvider.of(context);

    _detailPatientBloc.getDetailPatient(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
        appBar: context.appBar(title: Strings.editPatient),
        child: SingleChildScrollView(
          child: BlocListener(
            cubit: _editPatientBloc,
            listener: (_, state) {
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
              cubit: _detailPatientBloc,
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
                      PatientEntity _patientEntity = state.data;
                      _conName.text = _patientEntity.name;
                      _conDateBirth.text = _patientEntity.dateBirth;
                      _conAddress.text = _patientEntity.address;
                      _conPhoneNumber.text = _patientEntity.phoneNumber;
                      _conAge.text =
                          calculateAge(_patientEntity.dateBirth.toDateTime());
                      _selectedSex = _patientEntity.sex;

                      return Form(
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
                              validator: (value) =>
                                  value.isEmpty ? Strings.errorEmpty : null,
                            ),
                            Row(
                              children: [
                                Text(
                                  Strings.sex,
                                  style: TextStyles.textHint,
                                ),
                                SizedBox(width: context.dp16()),
                                FlutterToggleTab(
                                    labels: _sex,
                                    width: context.widthInPercent(10),
                                    height: Dimens.tabHeight,
                                    initialIndex: _sex.indexOf(_selectedSex),
                                    selectedLabelIndex: (index) {
                                      _selectedSex = _sex[index];
                                    },
                                    selectedTextStyle: TextStyles.white,
                                    borderRadius: context.dp16(),
                                    unSelectedTextStyle: TextStyles.primary),
                              ],
                            ).margin(
                                edgeInsets: EdgeInsets.symmetric(
                                    vertical: context.dp8())),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextF(
                                    hint: Strings.dateBirth,
                                    textInputAction: TextInputAction.next,
                                    controller: _conDateBirth,
                                    curFocusNode: DisableFocusNode(),
                                    nextFocusNode: _fnAddress,
                                    validator: (value) => value.isEmpty
                                        ? Strings.errorEmpty
                                        : null,
                                    onTap: () async {
                                      var _result = await context.datePicker();
                                      if (_result != null) {
                                        _conDateBirth.text =
                                            _result.toString().toDate();
                                        _conAge.text = calculateAge(_result);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: context.dp16()),
                                Expanded(
                                  flex: 2,
                                  child: TextF(
                                    textInputAction: TextInputAction.next,
                                    curFocusNode: DisableFocusNode(),
                                    controller: _conAge,
                                    hint: Strings.age,
                                    validator: (value) => value.isEmpty
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
                              validator: (value) =>
                                  value.isEmpty ? Strings.errorEmpty : null,
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
                              validator: (value) =>
                                  value.isEmpty ? Strings.errorEmpty : null,
                            ),
                            SizedBox(height: context.dp16()),
                            Button(
                              title: Strings.save,
                              color: Palette.colorPrimary,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  var _params = {
                                    'name': _conName.text.toString(),
                                    'sex': _selectedSex,
                                    'dateBirth': _conDateBirth.text.toString(),
                                    'address': _conAddress.text.toString(),
                                    'phoneNumber':
                                        _conPhoneNumber.text.toString()
                                  };
                                  _editPatientBloc.editPatient(_params);
                                }
                              },
                            )
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
        ));
  }
}
