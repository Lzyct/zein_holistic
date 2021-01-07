import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/pages/medical_record/medical_record.dart';
import 'package:zein_holistic/pages/pages.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:zein_holistic/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ListPatientPage extends StatefulWidget {
  ListPatientPage({Key key}) : super(key: key);

  @override
  _ListPatientPageState createState() => _ListPatientPageState();
}

class _ListPatientPageState extends State<ListPatientPage> {
  ListPatientBloc _listPatientBloc;
  DeletePatientBloc _deletePatientBloc;
  String _name = "";
  List<PatientEntity> _listPatient = [];

  @override
  void initState() {
    super.initState();
    _listPatientBloc = BlocProvider.of(context);
    _deletePatientBloc = BlocProvider.of(context);
    _getPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: null,
      isPadding: false,
      isScroll: false,
      child: Column(children: [
        Container(
            width: context.widthInPercent(100),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.radius),
                    bottomRight: Radius.circular(Dimens.radius)),
                boxShadow: [BoxShadows.primary]),
            child: Column(
              children: [
                SvgPicture.asset(
                  Images.icLogoTextAlt,
                  height: Dimens.height40,
                ).margin(edgeInsets: EdgeInsets.all(context.dp16())),
                AnimatedSearchBar(
                  label: Strings.searchPatient,
                  labelStyle: TextStyles.textBold,
                  searchDecoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: Strings.searchPatientHint,
                      hintStyle: TextStyles.textHint,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: context.dp8()),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.circular(context.dp4()),
                        borderSide: BorderSide(
                          color: Palette.colorPrimary,
                          width: 1.0,
                        ),
                      )),
                  cursorColor: Palette.colorPrimary,
                  onChanged: (value) {
                    _name = value;
                    _getPatient();
                  },
                )
              ],
            ).padding(
                edgeInsets: EdgeInsets.only(
                    bottom: context.dp16(),
                    left: context.dp16(),
                    right: context.dp16()))),
        Expanded(
            child: BlocBuilder(
          cubit: _listPatientBloc,
          builder: (_, state) {
            switch (state.status) {
              case Status.LOADING:
                {
                  return Center(child: Loading());
                }
                break;
              case Status.EMPTY:
                {
                  return Center(
                    child: Empty(
                      errorMessage: state.message.toString(),
                    ),
                  );
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
                  _listPatient = state.data;
                  return RefreshIndicator(
                    onRefresh: () async {
                      _getPatient();
                    },
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: _listPatient.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return _listItem(index);
                        }),
                  );
                }
                break;
              default:
                return Container();
            }
          },
        ))
      ]),
      floatingButton: FloatingActionButton(
          backgroundColor: Palette.colorPrimary,
          onPressed: () async {
            await context.goTo(BlocProvider(
                create: (_) => AddPatientBloc(), child: AddPatientPage()));
            _getPatient();
          },
          tooltip: Strings.addPatient,
          child: Icon(Icons.person_add)),
    );
  }

  _listItem(int index) {
    return Dismissible(
      key: Key(_listPatient[index].id),
      background: Container(
        color: Palette.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: context.dp16()),
            Text(
              Strings.delete,
              style: TextStyles.white,
            )
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Palette.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(width: context.dp16()),
            Text(
              Strings.edit,
              style: TextStyles.white,
            )
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(
                  Strings.delete,
                  style: TextStyles.textBold,
                ),
                content: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: Strings.askDeletePatient,
                      style: TextStyles.text,
                    ),
                    TextSpan(
                        text: " ${_listPatient[index].name} ",
                        style: TextStyles.textBold),
                    TextSpan(
                      text: Strings.questionMark,
                      style: TextStyles.text,
                    )
                  ]),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      Strings.cancel,
                      style: TextStyles.textHint,
                    ),
                    onPressed: () {
                      Navigator.pop(
                          dialogContext, false); // Dismiss alert dialog
                    },
                  ),
                  FlatButton(
                    child: Text(
                      Strings.delete,
                      style: TextStyles.text.copyWith(color: Palette.red),
                    ),
                    onPressed: () {
                      _deletePatientBloc.deletePatient(_listPatient[index].id);
                      _getPatient();
                      Navigator.pop(
                          dialogContext, true); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          await context.goTo(MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => EditPatientBloc()),
                BlocProvider(create: (_) => DetailPatientBloc()),
              ],
              child: EditPatientPage(
                id: _listPatient[index].id,
              )));
          _getPatient();
        }
        return false;
      },
      child: CardView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _listPatient[index].name,
                      style: TextStyles.textBold,
                    ),
                  ),
                  Text(
                    _listPatient[index].phoneNumber,
                    style: TextStyles.textHint
                        .copyWith(fontSize: Dimens.fontSmall),
                  )
                ],
              ),
              SizedBox(height: context.dp8()),
              Text(
                _listPatient[index].address,
                style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
              ),
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            context.goTo(
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => ListMedicalRecordBloc(),
                  ),
                  BlocProvider(
                    create: (_) => DeleteMedicalRecordBloc(),
                  )
                ],
                child: ListMedicalRecordPage(
                  patientEntity: _listPatient[index],
                ),
              ),
            );
          }),
    );
  }

  _getPatient() {
    _listPatientBloc.getListPatient(_name);
  }
}
