import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_medical_record_request.dart';
import 'package:zein_holistic/core/data/models/responses/list_medical_record_response.dart'
    as medical_record;
import 'package:zein_holistic/core/data/models/responses/list_patient_response.dart'
    as patient;
import 'package:zein_holistic/core/enums/enums.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/pages/pages.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 1/7/21 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2021 | All Right Reserved
class ListMedicalRecordPage extends StatefulWidget {
  ListMedicalRecordPage({Key? key, this.patientData}) : super(key: key);
  final patient.Data? patientData;

  @override
  _ListMedicalRecordPageState createState() => _ListMedicalRecordPageState();
}

class _ListMedicalRecordPageState extends State<ListMedicalRecordPage> {
  late ListMedicalRecordBloc _listMedicalRecordBloc;
  late DeleteMedicalRecordBloc _deleteMedicalRecordBloc;
  List<medical_record.Data>? _listMedicalRecord = [];
  var _mainComplaint = "";

  @override
  void initState() {
    super.initState();
    _listMedicalRecordBloc = BlocProvider.of(context);
    _deleteMedicalRecordBloc = BlocProvider.of(context);
    _getMedicalRecord();
  }

  @override
  void dispose() {
    super.dispose();
    _listMedicalRecordBloc.close();
    _deleteMedicalRecordBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: context.appBar(),
      isPadding: false,
      isScroll: false,
      floatingButton:
          Responsive.isMobile(context) || Responsive.isTablet(context)
              ? FloatingActionButton(
                  backgroundColor: Palette.colorPrimary,
                  onPressed: () async {
                    await context.goTo(AppRoute.addMedicalRecord,
                        args: {"idPatient": widget.patientData?.id.toString()});
                    _getMedicalRecord();
                  },
                  child: Icon(Icons.note_add),
                  tooltip: Strings.addMedicalRecord,
                )
              : null,
      child: Column(
        children: [
          Container(
            decoration: BoxDecorations.primary.copyWith(
                color: Palette.colorPrimary,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(Dimens.radius),
                  bottomLeft: Radius.circular(Dimens.radius),
                )),
            padding: EdgeInsets.all(Dimens.space16),
            margin: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? context.dp36()
                    : context.dp4()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.patientData!.name!,
                        style: TextStyles.whiteBold
                            .copyWith(fontSize: Dimens.fontLarge),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: Dimens.space16,
                        child: SvgPicture.asset(
                          widget.patientData!.sex == Strings.man
                              ? Images.icMan
                              : Images.icWoman,
                          color: Palette.colorPrimary,
                        )),
                    SizedBox(width: Dimens.space8),
                    Text(
                      "${calculateAge(widget.patientData!.birthday!.toDateTime())} ${Strings.year}",
                      style: TextStyles.whiteBold.copyWith(
                        fontSize: Dimens.fontSmall,
                      ),
                    )
                  ],
                ),
                Row(children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: Dimens.space16,
                  ),
                  SizedBox(
                    width: Dimens.space8,
                  ),
                  Text(
                    widget.patientData!.birthday!,
                    textAlign: TextAlign.start,
                    style:
                        TextStyles.white.copyWith(fontSize: Dimens.fontSmall),
                  )
                ]),
                SizedBox(height: Dimens.space4),
                Row(children: [
                  Icon(
                    Icons.location_city_outlined,
                    color: Colors.white,
                    size: Dimens.space16,
                  ),
                  SizedBox(
                    width: Dimens.space8,
                  ),
                  Text(
                    widget.patientData!.address!,
                    textAlign: TextAlign.start,
                    style:
                        TextStyles.white.copyWith(fontSize: Dimens.fontSmall),
                  ),
                ]),
              ],
            ).padding(
                edgeInsets: EdgeInsets.only(
                    bottom: Dimens.space24,
                    left: Dimens.space16,
                    right: Dimens.space16)),
          ),
          CustomToolbar(title: Strings.addMedicalRecord),
          SizedBox(height: Dimens.space4),
          Row(
            mainAxisAlignment: Responsive.isDesktop(context)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (Responsive.isDesktop(context))
                Button(
                  title: Strings.addMedicalRecord,
                  color: Palette.colorPrimary,
                  width: Dimens.minWidthButtonDesktopAlt,
                  onPressed: () async {
                    await context.goTo(AppRoute.addMedicalRecord,
                        args: {"idPatient": widget.patientData?.id.toString()});
                    _getMedicalRecord();
                  },
                ),
              Container(
                constraints: BoxConstraints(maxWidth: Dimens.maxWidthSearch),
                child: AnimatedSearchBar(
                  label: Strings.searchMedicalRecord,
                  labelStyle: TextStyles.textBold,
                  searchStyle: TextStyles.text,
                  searchDecoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: Strings.searchMedicalRecordHint,
                      hintStyle: TextStyles.textHint,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: Dimens.space8),
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
                    _mainComplaint = value;
                    _getMedicalRecord();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: Dimens.space16),
          Expanded(
            child: BlocBuilder(
              bloc: _listMedicalRecordBloc,
              builder: (_, dynamic state) {
                switch (state.status) {
                  case Status.LOADING:
                    {
                      return Center(child: Loading());
                    }
                  case Status.EMPTY:
                    {
                      return Center(
                        child: Empty(
                          errorMessage: state.message.toString(),
                        ),
                      );
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
                      _listMedicalRecord = state.data.data;
                      return RefreshIndicator(
                        onRefresh: () async {
                          _getMedicalRecord();
                        },
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: _listMedicalRecord!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return _listItem(index);
                            }),
                      );
                    }
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
    return CardView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _listMedicalRecord![index].mainComplaint!,
                    style: TextStyles.textBold,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: Dimens.space8),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: Dimens.space16,
                        color: Palette.colorHint,
                      ),
                      SizedBox(width: Dimens.space4),
                      Text(
                        _listMedicalRecord![index]
                            .createdAt!
                            .toStringDateTime(),
                        style: TextStyles.textHint
                            .copyWith(fontSize: Dimens.fontSmall),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimens.space16),
                  Text(
                    "${Strings.examiner} : ${_listMedicalRecord![index].examiner!}",
                    style: TextStyles.textHint,
                  ),
                ],
              ),
            ),
            Responsive.isDesktop(context)
                ? _buttonWeb(index)
                : _buttonMobile(index)
          ],
        ).padding(edgeInsets: EdgeInsets.all(Dimens.space16)),
        onTap: () {
          context.goTo(AppRoute.detailMedicalRecord,
              args: {"id": _listMedicalRecord![index].id.toString()});
        });
  }

  _buttonWeb(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ButtonIcon(
          icon: Icons.edit,
          title: Strings.edit,
          titleColor: Colors.white,
          onPressed: () async {
            await context.goTo(AppRoute.editMedicalRecord,
                args: {"id": _listMedicalRecord![index].id.toString()});
            _getMedicalRecord();
          },
        ),
        ButtonIcon(
          color: Palette.red,
          titleColor: Colors.white,
          onPressed: () async {
            await _dialogDelete(index);
          },
          icon: Icons.delete_outline,
          title: Strings.delete,
        )
      ],
    );
  }

  _buttonMobile(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ButtonIcon(
          icon: Icons.edit,
          titleColor: Colors.white,
          onPressed: () async {
            await context.goTo(AppRoute.editMedicalRecord,
                args: {"id": _listMedicalRecord![index].id.toString()});
            _getMedicalRecord();
          },
        ),
        SizedBox(width: Dimens.space8),
        ButtonIcon(
            color: Palette.red,
            titleColor: Colors.white,
            onPressed: () async {
              await _dialogDelete(index);
            },
            icon: Icons.delete_outline)
      ],
    );
  }

  _dialogDelete(int index) async {
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
                  text: " ${_listMedicalRecord![index].mainComplaint} ",
                  style: TextStyles.textBold),
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
                _deleteMedicalRecordBloc.deleteMedicalRecord(
                    _listMedicalRecord![index].id.toString());
                _getMedicalRecord();
                Navigator.pop(dialogContext, true); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  _getMedicalRecord() {
    _listMedicalRecordBloc.getListMedicalRecord(ListMedicalRecordRequest(
        page: 0, idPatient: widget.patientData!.id!, q: _mainComplaint));
  }
}
