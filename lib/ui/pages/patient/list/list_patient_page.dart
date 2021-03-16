import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/enums/enums.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/pages/pages.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ListPatientPage extends StatefulWidget {
  ListPatientPage({Key? key}) : super(key: key);

  @override
  _ListPatientPageState createState() => _ListPatientPageState();
}

class _ListPatientPageState extends State<ListPatientPage> {
  late ListPatientBloc _listPatientBloc;
  late DeletePatientBloc _deletePatientBloc;
  String _name = "";
  List<PatientEntity>? _listPatient = [];

  @override
  void initState() {
    super.initState();
    _listPatientBloc = BlocProvider.of(context);
    _deletePatientBloc = BlocProvider.of(context);
    _getPatient();
  }

  @override
  void dispose() {
    super.dispose();
    _listPatientBloc.close();
    _deletePatientBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: AppBar(
        toolbarHeight: Dimens.height55,
        brightness: Brightness.light,
        title: SvgPicture.asset(
          Images.icLogoTextAlt,
          height: Dimens.height35,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Palette.colorPrimary,
              ),
              onPressed: () async {
                await context.goTo(SettingsPage());
                _getPatient();
              })
        ],
      ),
      isPadding: false,
      isScroll: false,
      child: Column(children: [
        Container(
            width: context.widthInPercent(100),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.radius), bottomRight: Radius.circular(Dimens.radius)),
                boxShadow: [BoxShadows.primary]),
            child: Column(
              children: [
                AnimatedSearchBar(
                  label: Strings.searchPatient,
                  labelStyle: TextStyles.textBold,
                  searchDecoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: Strings.searchPatientHint,
                      hintStyle: TextStyles.textHint,
                      contentPadding: EdgeInsets.symmetric(horizontal: Dimens.space8),
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderRadius: BorderRadius.circular(Dimens.space4),
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
                edgeInsets: EdgeInsets.only(bottom: Dimens.space16, left: Dimens.space16, right: Dimens.space16))),
        Expanded(
            child: BlocBuilder(
          bloc: _listPatientBloc,
          builder: (_, dynamic state) {
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
                  logs(state.message.toString());
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
                        itemCount: _listPatient!.length,
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
            await context.goTo(BlocProvider(create: (_) => AddPatientBloc(), child: AddPatientPage()));
            _getPatient();
          },
          tooltip: Strings.addPatient,
          child: Icon(Icons.person_add)),
    );
  }

  _listItem(int index) {
    return Dismissible(
      key: Key(_listPatient![index].id!),
      background: Container(
        color: Palette.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: Dimens.space16),
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
            SizedBox(width: Dimens.space16),
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
                    TextSpan(text: " ${_listPatient![index].name} ", style: TextStyles.textBold),
                    TextSpan(
                      text: Strings.questionMark,
                      style: TextStyles.text,
                    )
                  ]),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      Strings.cancel,
                      style: TextStyles.textHint,
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext, false); // Dismiss alert dialog
                    },
                  ),
                  TextButton(
                    child: Text(
                      Strings.delete,
                      style: TextStyles.text.copyWith(color: Palette.red),
                    ),
                    onPressed: () {
                      _deletePatientBloc.deletePatient(_listPatient![index].id);
                      _getPatient();
                      Navigator.pop(dialogContext, true); // Dismiss alert dialog
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
                id: _listPatient![index].id,
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
                      _listPatient![index].name!,
                      style: TextStyles.textBold,
                    ),
                  ),
                  Text(
                    _listPatient![index].phoneNumber!,
                    style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
                  )
                ],
              ),
              SizedBox(height: Dimens.space8),
              Text(
                _listPatient![index].address!,
                style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
              ),
            ],
          ).padding(edgeInsets: EdgeInsets.all(Dimens.space16)),
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
                  patientEntity: _listPatient![index],
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
