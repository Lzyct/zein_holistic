import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/blocs/medical_record/detail/detail_medical_record_bloc.dart';
import 'package:zein_holistic/data/models/entities/medical_record_entity.dart';
import 'package:zein_holistic/data/models/entities/patient_entity.dart';
import 'package:zein_holistic/pages/medical_record/add/add_medical_record_page.dart';
import 'package:zein_holistic/pages/pages.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:zein_holistic/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 1/7/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class ListMedicalRecordPage extends StatefulWidget {
  ListMedicalRecordPage({Key key, this.patientEntity}) : super(key: key);
  final PatientEntity patientEntity;

  @override
  _ListMedicalRecordPageState createState() => _ListMedicalRecordPageState();
}

class _ListMedicalRecordPageState extends State<ListMedicalRecordPage> {
  ListMedicalRecordBloc _listMedicalRecordBloc;
  DeleteMedicalRecordBloc _deleteMedicalRecordBloc;
  List<MedicalRecordEntity> _listMedicalRecord = [];
  var _mainComplaint = "";

  @override
  void initState() {
    super.initState();
    _listMedicalRecordBloc = BlocProvider.of(context);
    _deleteMedicalRecordBloc = BlocProvider.of(context);
    _getMedicalRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(title: Strings.medicalRecord),
      isPadding: false,
      isScroll: false,
      floatingButton: FloatingActionButton(
          backgroundColor: Palette.colorPrimary,
          onPressed: () async {
            await context.goTo(BlocProvider(
                create: (_) => AddMedicalRecordBloc(),
                child: AddMedicalRecordPage(
                  idPatient: widget.patientEntity.id,
                )));
            _getMedicalRecord();
          },
          tooltip: Strings.addMedicalRecord,
          child: Icon(Icons.note_add)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecorations.primary.copyWith(
                color: Palette.colorPrimary,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(Dimens.radius),
                  bottomLeft: Radius.circular(Dimens.radius),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.patientEntity.name,
                        style: TextStyles.whiteBold
                            .copyWith(fontSize: Dimens.fontLarge),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: context.dp16(),
                        child: SvgPicture.asset(
                          widget.patientEntity.sex == Strings.man
                              ? Images.icMan
                              : Images.icWoman,
                          color: Palette.colorPrimary,
                        )),
                    SizedBox(width: context.dp4()),
                    Text(
                      calculateAge(widget.patientEntity.dateBirth.toDateTime()),
                      style: TextStyles.white,
                    )
                  ],
                ),
                Row(children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: context.dp16(),
                  ),
                  SizedBox(
                    width: context.dp8(),
                  ),
                  Text(
                    widget.patientEntity.dateBirth,
                    textAlign: TextAlign.start,
                    style:
                        TextStyles.white.copyWith(fontSize: Dimens.fontSmall),
                  )
                ]),
                SizedBox(height: context.dp4()),
                Row(children: [
                  Icon(
                    Icons.location_city_outlined,
                    color: Colors.white,
                    size: context.dp16(),
                  ),
                  SizedBox(
                    width: context.dp8(),
                  ),
                  Text(
                    widget.patientEntity.address,
                    textAlign: TextAlign.start,
                    style:
                        TextStyles.white.copyWith(fontSize: Dimens.fontSmall),
                  ),
                ]),
              ],
            ).padding(
                edgeInsets: EdgeInsets.only(
                    bottom: context.dp24(),
                    left: context.dp16(),
                    right: context.dp16())),
          ),
          SizedBox(height: context.dp4()),
          AnimatedSearchBar(
            label: Strings.searchMedicalRecord,
            labelStyle: TextStyles.textBold,
            searchDecoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: Strings.searchMedicalRecordHint,
                contentPadding: EdgeInsets.symmetric(
                    vertical: context.dp8(), horizontal: context.dp12()),
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
              _mainComplaint = value;
              _getMedicalRecord();
            },
          ).margin(
              edgeInsets: EdgeInsets.symmetric(horizontal: context.dp16())),
          Expanded(
            child: BlocBuilder(
              cubit: _listMedicalRecordBloc,
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
                      _listMedicalRecord = state.data;
                      return RefreshIndicator(
                        onRefresh: () async {
                          _getMedicalRecord();
                        },
                        child: ListView.builder(
                            itemCount: _listMedicalRecord.length,
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
            ),
          )
        ],
      ),
    );
  }

  _listItem(int index) {
    return Dismissible(
      key: Key(_listMedicalRecord[index].id.toString()),
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
                      text: Strings.askDeleteMedicalRecord,
                      style: TextStyles.text,
                    ),
                    TextSpan(
                        text: " ${_listMedicalRecord[index].mainComplaint} ",
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
                      _deleteMedicalRecordBloc.deleteMedicalRecord(
                          _listMedicalRecord[index].id.toString());
                      _getMedicalRecord();
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
                BlocProvider(create: (_) => EditMedicalRecordBloc()),
                BlocProvider(create: (_) => DetailMedicalRecordBloc()),
              ],
              child: EditMedicalRecordPage(
                id: _listMedicalRecord[index].id.toString(),
              )));
          _getMedicalRecord();
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
                      _listMedicalRecord[index].mainComplaint,
                      style: TextStyles.textBold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    _listMedicalRecord[index].examiner,
                    style: TextStyles.textHint
                        .copyWith(fontSize: Dimens.fontSmall),
                  )
                ],
              ),
              SizedBox(height: context.dp8()),
              Row(
                children: [
                  Icon(
                    Icons.alarm,
                    size: context.dp16(),
                    color: Palette.colorHint,
                  ),
                  SizedBox(width: context.dp4()),
                  Text(
                    _listMedicalRecord[index].createAt.toStringDateTime(),
                    style: TextStyles.textHint
                        .copyWith(fontSize: Dimens.fontSmall),
                  ),
                ],
              )
            ],
          ).padding(edgeInsets: EdgeInsets.all(context.dp16())),
          onTap: () {
            context.goTo(BlocProvider(
              create: (_) => DetailMedicalRecordBloc(),
              child: DetailMedicalRecordPage(
                id: _listMedicalRecord[index].id.toString(),
              ),
            ));
          }),
    );
  }

  _getMedicalRecord() {
    _listMedicalRecordBloc.getListMedicalRecord(
        widget.patientEntity.id, _mainComplaint);
  }
}
