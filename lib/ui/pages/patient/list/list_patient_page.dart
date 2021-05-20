import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/models/responses/list_patient_response.dart';
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

  List<Data> _listPatient = [];

  List<DataSelected> _listFilter = [];
  List<String> _listSex = [Strings.all, Strings.man, Strings.woman];

  var _lastPage = 0;
  var _currentPage = 0;

  String _name = "";
  String _sexSelected = Strings.all;
  String _filterSelected = "";

  var _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _listPatientBloc = BlocProvider.of(context);
    _deletePatientBloc = BlocProvider.of(context);

    logs("currentDate ${DateTime.now()}");

    //set listFilter Data
    _listFilter.add(DataSelected(
        title: Strings.newest,
        value: Strings.newestDesc,
        icon: Icons.arrow_upward));

    _listFilter.add(DataSelected(
        title: Strings.name,
        value: Strings.nameAsc,
        icon: Icons.arrow_downward));
    _listFilter.add(DataSelected(
        title: Strings.name,
        value: Strings.nameDesc,
        icon: Icons.arrow_upward));

    _listFilter.add(DataSelected(
        title: Strings.age,
        value: Strings.birthdayDesc,
        icon: Icons.arrow_downward));
    _listFilter.add(DataSelected(
        title: Strings.age,
        value: Strings.birthdayAsc,
        icon: Icons.arrow_upward));

    _filterSelected = _listFilter[0].value!;

    _getPatient();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_currentPage < _lastPage) {
          _currentPage++;
          _getPatient();
        }
      }
    });
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
      appBar: context.appBar(),
      isPadding: false,
      isScroll: false,
      floatingButton:
          Responsive.isMobile(context) || Responsive.isTablet(context)
              ? FloatingActionButton(
                  backgroundColor: Palette.colorPrimary,
                  onPressed: () async {
                    await context.goTo(AppRoute.addPatient);
                    _resetPage();
                    _getPatient();
                  },
                  child: Icon(Icons.note_add),
                  tooltip: Strings.addMedicalRecord,
                )
              : null,
      child: BlocListener(
        bloc: _deletePatientBloc,
        listener: (_, dynamic state) {
          switch (state.status) {
            case Status.LOADING:
              {
                Strings.pleaseWait.toToastLoading();
              }
              break;
            case Status.ERROR:
              {
                state.status.toString().toToastError();
              }
              break;
            case Status.SUCCESS:
              {
                Strings.successDelete.toString().toToastSuccess();
                Navigator.pop(context);

                _resetPage();
                _getPatient();
              }
              break;
          }
        },
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: Dimens.height55,
                    constraints:
                        BoxConstraints(maxWidth: Dimens.maxWidthSearch),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimens.radius),
                            bottomRight: Radius.circular(Dimens.radius)),
                        boxShadow: [BoxShadows.primary]),
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimens.padding),
                    margin: EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: Dimens.height35,
                      child: AnimatedSearchBar(
                        label: Strings.searchPatient,
                        labelStyle: TextStyles.textBold,
                        searchStyle: TextStyles.text,
                        searchDecoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: Strings.searchPatientHint,
                            hintStyle: TextStyles.textHint,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Dimens.space8, vertical: 0),
                            border: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius:
                                  BorderRadius.circular(Dimens.space4),
                              borderSide: BorderSide(
                                color: Palette.colorPrimary,
                                width: 1.0,
                              ),
                            )),
                        cursorColor: Palette.colorPrimary,
                        onChanged: (value) {
                          _name = value;
                          _resetPage();
                          _getPatient();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.padding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            Strings.listPatient,
                            style: TextStyles.textHint.copyWith(
                                fontSize: Responsive.isDesktop(context)
                                    ? Dimens.fontLarge4
                                    : Dimens.fontLarge2),
                          ),
                        ),
                        SizedBox(
                          width: Dimens.minWidthButtonDesktopAlt,
                          child: DropDown(
                            hintIsVisible: false,
                            value: _filterSelected,
                            items: _listFilter.map((e) {
                              logs("item ${e.value}");
                              return DropdownMenuItem(
                                child: Row(
                                  children: [
                                    Icon(
                                      e.icon,
                                      size: Dimens.space16,
                                    ),
                                    SizedBox(width: Dimens.space8),
                                    Text(
                                      e.title.toString(),
                                      style: TextStyles.text,
                                    )
                                  ],
                                ),
                                value: e.value,
                              );
                            }).toList(),
                            onChanged: (value) {
                              logs(value);
                              _filterSelected = value as String;

                              _resetPage();
                              _getPatient();
                            },
                          ),
                        ),
                        SizedBox(width: Dimens.space8),
                        SizedBox(
                          width: Dimens.minWidthButtonDesktop,
                          child: DropDown(
                            hintIsVisible: false,
                            value: _sexSelected,
                            items: _listSex
                                .map((e) => DropdownMenuItem<String>(
                                      child: Row(
                                        children: [
                                          Text(
                                            e.toString(),
                                            style: TextStyles.text,
                                          )
                                        ],
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              logs(value);
                              _sexSelected = value as String;

                              _resetPage();
                              _getPatient();
                            },
                          ),
                        ),
                        SizedBox(width: Dimens.space16),
                        if (Responsive.isDesktop(context))
                          Button(
                            title: Strings.addPatient,
                            color: Palette.colorPrimary,
                            onPressed: () async {
                              await context.goTo(AppRoute.addPatient);
                              _resetPage();
                              _getPatient();
                            },
                          )
                      ]),
                ),
                Expanded(
                    child: BlocBuilder(
                  bloc: _listPatientBloc,
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
                          logs(state.message.toString());
                          return Center(
                            child: Empty(
                              errorMessage: state.message.toString(),
                            ),
                          );
                        }
                      case Status.SUCCESS:
                        {
                          if (_currentPage == 0) _listPatient.clear();

                          _listPatient.addAll(state.data.data);
                          _lastPage = state.data.page.lastPage;

                          return RefreshIndicator(
                            onRefresh: () async {
                              _resetPage();
                              _getPatient();
                            },
                            child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                itemCount: _currentPage == _lastPage
                                    ? _listPatient.length
                                    : _listPatient.length + 1,
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return index < _listPatient.length
                                      ? _listItem(index)
                                      : Container(
                                          height: 50,
                                          child: Center(
                                            child:
                                                new CircularProgressIndicator(),
                                          ),
                                        );
                                }),
                          );
                        }
                      default:
                        return Container();
                    }
                  },
                ))
              ]),
        ),
      ),
    );
  }

  _listItem(int index) {
    return CardView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${index + 1}. ",
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: Dimens.space12,
                          child: SvgPicture.asset(
                            _listPatient[index].sex == Strings.man
                                ? Images.icMan
                                : Images.icWoman,
                            color: Palette.colorText,
                          )),
                      Text(
                        " ${_listPatient[index].name!} (${calculateAge(_listPatient[index].birthday!.toDate())} ${Strings.year})",
                        style: TextStyles.textBold
                            .copyWith(fontSize: Dimens.fontLarge),
                      )
                    ],
                  ),
                  SizedBox(height: Dimens.space8),
                  Row(
                    children: [
                      SizedBox(width: Dimens.space16),
                      Icon(
                        Icons.location_city_outlined,
                        color: Palette.colorHint,
                      ),
                      SizedBox(width: Dimens.space8),
                      Text(
                        _listPatient[index].address!,
                        style: TextStyles.textHint,
                      ),
                    ],
                  ),
                  SizedBox(height: Dimens.space8),
                  Row(
                    children: [
                      SizedBox(width: Dimens.space16),
                      Icon(
                        Icons.phone,
                        color: Palette.colorHint,
                      ),
                      SizedBox(width: Dimens.space8),
                      Text(
                        _listPatient[index].phoneNumber!,
                        style: TextStyles.textHint,
                      ),
                    ],
                  ),
                  SizedBox(height: Dimens.space8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: Dimens.space16),
                      Icon(
                        Icons.lock_clock,
                        color: Palette.colorHint,
                      ),
                      SizedBox(width: Dimens.space8),
                      Text(
                        _listPatient[index].createdAt!.toStringDateTime(),
                        style: TextStyles.textHint,
                      ),
                    ],
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
          context.goTo(AppRoute.listMedicalRecord,
              args: {"patient": _listPatient[index]});
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
            await context.goTo(AppRoute.editPatient,
                args: {"id": _listPatient[index].id});
            _resetPage();
            _getPatient();
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
            await context.goTo(AppRoute.editPatient,
                args: {"id": _listPatient[index].id});
            _resetPage();
            _getPatient();
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
              onPressed: () async {
                _deletePatientBloc
                    .deletePatient(_listPatient[index].id.toString());
              },
            ),
          ],
        );
      },
    );
  }

  _getPatient() {
    _listPatientBloc.listPatient(ListPatientRequest(
        page: _currentPage,
        q: _name,
        isFirstPage: _currentPage == 0,
        filterSelected: _filterSelected,
        sexSelected: _sexSelected));
  }

  _resetPage() {
    _currentPage = 0;
    _lastPage = 0;
  }
}
