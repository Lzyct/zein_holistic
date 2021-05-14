import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 24/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Parent extends StatefulWidget {
  final Widget? child;
  final bool isPadding;
  final bool isScroll;
  final Widget appBar;
  final bool avoidBottomInset;
  final Widget? floatingButton;

  const Parent({
    Key? key,
    this.child,
    this.isPadding = true,
    this.isScroll = true,
    required this.appBar,
    this.avoidBottomInset = false,
    this.floatingButton,
  }) : super(key: key);

  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.colorBackgroundAlt,
      alignment: Alignment.center,
      child: Scaffold(
        resizeToAvoidBottomInset: widget.avoidBottomInset,
        appBar: widget.appBar as PreferredSizeWidget? ??
            PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              constraints: BoxConstraints(maxWidth: Dimens.maxWidth),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  widget.isScroll
                      ? Container()
                      : widget.child.padding(
                          edgeInsets: EdgeInsets.all(
                            widget.isPadding ? Dimens.space16 : 0,
                          ),
                        ),
                  Scrollbar(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: widget.isScroll
                          ? widget.child.padding(
                              edgeInsets: EdgeInsets.all(
                                widget.isPadding ? Dimens.space16 : 0,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: widget.floatingButton ?? null,
      ),
    );
  }
}
