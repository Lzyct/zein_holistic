import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/blocs/add_user/add_user_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/blocs/list_user/list_user_bloc.dart';
import 'package:zein_holistic/data/models/entities/table_user.dart';
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
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListUserBloc _listUserBloc;
  String _name = "";

  @override
  void initState() {
    super.initState();
    _listUserBloc = BlocProvider.of(context);
    _listUserBloc.listUser(_name);
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: null,
      isPadding: false,
      isScroll: false,
      child: Column(children: [
        SvgPicture.asset(
          Images.icLogoTextAlt,
          height: context.heightInPercent(6),
        ),
        AnimatedSearchBar(
          label: Strings.search,
          searchDecoration: InputDecoration(
              hintText: Strings.searchPatientHint,
              focusColor: Palette.colorPrimary),
          cursorColor: Palette.colorPrimary,
          onChanged: (value) {
            _name = value;
            _listUserBloc.listUser(_name);
          },
        ),
        Expanded(
            child: BlocBuilder(
          cubit: _listUserBloc,
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
                  List<TableUser> _listUser = state.data;
                  return ListView.builder(
                      itemCount: _listUser.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return CardView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _listUser[index].name,
                                  style: TextStyles.text,
                                ),
                                Text(
                                  _listUser[index].address,
                                  style: TextStyles.text,
                                )
                              ],
                            ),
                            onTap: () {});
                      });
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
                create: (_) => AddUserBloc(), child: RegisterPage()));
            _listUserBloc.listUser(_name);
          },
          tooltip: Strings.addPatient,
          child: Icon(Icons.person_add)),
    );
  }
}
