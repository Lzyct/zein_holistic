import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
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
class AddPatientPage extends StatefulWidget {
  AddPatientPage({Key? key}) : super(key: key);

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
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

  late AddPatientBloc _addPatientBloc;

  @override
  void initState() {
    super.initState();
    _selectedSex = _sex[0];
    _addPatientBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _addPatientBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.addPatient),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: BlocListener(
            bloc: _addPatientBloc,
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
                    hint: Strings.name,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: _conName,
                    curFocusNode: _fnName,
                    nextFocusNode: _fnDateBirth,
                    validator: (String? value) =>
                        value!.isEmpty ? Strings.errorEmpty : null,
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
                          width: Dimens.toggle,
                          height: Dimens.toggle,
                          initialIndex: 0,
                          selectedLabelIndex: (index) {
                            _selectedSex = _sex[index];
                          },
                          selectedTextStyle: TextStyles.white,
                          borderRadius: Dimens.space16,
                          unSelectedTextStyle: TextStyles.primary),
                    ],
                  ).margin(
                      edgeInsets: EdgeInsets.symmetric(vertical: Dimens.space8)),
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
                          validator: (String? value) =>
                              value!.isEmpty ? Strings.errorEmpty : null,
                          onTap: () async {
                            var _result = await context.datePicker(
                                currentDate: _conDateBirth.text.isNotEmpty
                                    ? _conDateBirth.text.toDate()
                                    : null);
                            if (_result != null) {
                              _conDateBirth.text =
                                  _result.toString().toStringDate();
                              _conAge.text = calculateAge(_result);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: Dimens.space16),
                      Expanded(
                        flex: 2,
                        child: TextF(
                          textInputAction: TextInputAction.next,
                          curFocusNode: DisableFocusNode(),
                          controller: _conAge,
                          hint: Strings.age,
                          validator: (String? value) =>
                              value!.isEmpty ? Strings.errorEmpty : null,
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
                        value!.isEmpty ? Strings.errorEmpty : null,
                  ),
                  TextF(
                    hint: Strings.phoneNumber,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    controller: _conPhoneNumber,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    curFocusNode: _fnPhoneNumber,
                    validator: (String? value) =>
                        value!.isEmpty ? Strings.errorEmpty : null,
                  ),
                  SizedBox(height: Dimens.space16),
                  Button(
                    title: Strings.save,
                    color: Palette.colorPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var _params = {
                          'name': _conName.text.toString(),
                          'sex': _selectedSex,
                          'dateBirth': _conDateBirth.text.toString(),
                          'address': _conAddress.text.toString(),
                          'phoneNumber': _conPhoneNumber.text.toString()
                        };
                        _addPatientBloc.addPatient(_params);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
