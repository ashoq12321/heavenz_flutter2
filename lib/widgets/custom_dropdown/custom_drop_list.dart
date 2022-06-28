import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/widgets/custom_dropdown/DropListModel.dart';

class CustomDropList extends StatefulWidget {
  CustomDropList(
      {Key? key,
      this.containerHeight,
      required this.itemSelected,
      required this.dropListModel,
      required this.onOptionSelected,
      this.decorationRequired})
      : super(key: key);

  final double? containerHeight;
  OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;
  bool? decorationRequired = true;

  @override
  _CustomDropListState createState() =>
      _CustomDropListState(/*itemSelected, dropListModel*/);
}

class _CustomDropListState extends State<CustomDropList>
    with SingleTickerProviderStateMixin {
  //late OptionItem optionItemSelected;
  //late final DropListModel dropListModel;

  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  //_CustomDropListState(this.optionItemSelected, this.dropListModel);

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              this.isShow = !this.isShow;
              _runExpandCheck();
              setState(() {});
            },
            child: Container(
              height: widget.containerHeight ?? 48,
              decoration: (widget.decorationRequired ?? true)
                  ? BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: ColorConstants.appGreen),
                      borderRadius: BorderRadius.circular(8.0),
                      color: ColorConstants.appWhite,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.5,
                          color: ColorConstants.appGreen,
                        )
                      ],
                    )
                  : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.itemSelected.title,
                        style: (widget.decorationRequired ?? true)
                            ? FontType.normal.style(
                                size: 18.0,
                                color: Colors.black.withOpacity(0.52),
                                appFontFamilyName: 'Poppins',
                                shadows: [
                                  Shadow(
                                    blurRadius: 0.5,
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0.3, 0.3),
                                  ),
                                ],
                              )
                            : FontType.normal.style(
                                size: 22.0,
                                color: ColorConstants.appGrey,
                                appFontFamilyName: 'Lato',
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 10,
                        ),
                        child: Container(
                          height: 22,
                          width: 22,
                          child: Image.asset(
                            'images/ic_dropdown.png',
                            color: ColorConstants.appGreen,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: _buildDropListOptions(
                      widget.dropListModel.listOptionItems, context))),
//          Divider(color: Colors.grey.shade300, height: 1,)
        ],
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    //border: Border(top: BorderSide(color: Colors.grey, width: 1)),
                    ),
                child: Text(item.title,
                    style: FontType.normal.style(
                      size: 16.0,
                      color: ColorConstants.appGreen.withOpacity(0.82),
                      appFontFamilyName: 'Poppins',
                      shadows: [
                        Shadow(
                          blurRadius: 0.4,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0.2, 0.2),
                        ),
                      ],
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        onTap: () {
          widget.itemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }
}
