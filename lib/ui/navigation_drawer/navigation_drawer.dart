
import 'package:flutter/material.dart';
import 'package:news_flutter_block/res/app_context_extension.dart';
import 'package:news_flutter_block/ui/navigation_drawer/navigation_action.dart';

class NavigationDrawer extends StatelessWidget {

  final Function(NavigationAction) countryMenuClick;

  const NavigationDrawer({required this.countryMenuClick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                _createDrawerHeader(context),
                _createDrawerBodyItem(context, icon: Icons.language, text: context.resources.strings!.menuCountry, onTap: countryMenuClick, action: NavigationAction.country),
                _expendedDrawerBody(context, onTap: countryMenuClick),
                _createDrawerBodyItem(context, icon: Icons.info_outlined, text: context.resources.strings!.menuAboutUs, onTap: countryMenuClick,action: NavigationAction.about),
              ],
            ),
          ),
          const Divider(color: Colors.grey),
          //Drawer bottom view
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: const ImageIcon(AssetImage("assets/images/icons/ic_medium.png")),
                    onTap: () {
                      countryMenuClick(NavigationAction.medium);
                    },
                  ),
                  GestureDetector(
                    child: const ImageIcon(AssetImage("assets/images/icons/ic_linkedin.png")),
                    onTap: () {
                      countryMenuClick(NavigationAction.linkedIn);
                    },
                  ),
                  GestureDetector(
                    child: const ImageIcon(AssetImage("assets/images/icons/ic_github.png")),
                    onTap: () {
                      countryMenuClick(NavigationAction.github);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/images/bg_drawer_header.jpeg')
            )
        ),
        child: Stack(
            children: <Widget>[
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: context.resources.color.colorAccent,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(context.resources.dimension.defaultMargin,context.resources.dimension.verySmallMargin,context.resources.dimension.verySmallMargin,context.resources.dimension.verySmallMargin),
                        child: Text(
                          "marajhussain75@gmail.com",
                          style: context.resources.style.drawerTextStyle,
                        ),
                      )
                  )
              ),
            ]
        )
    );
  }

  Widget _createDrawerBodyItem(BuildContext context, {required IconData icon, required String text, required Function(NavigationAction) onTap, required NavigationAction action}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: context.resources.dimension.smallMargin),
            child: Text(text, style: context.resources.style.drawerTextStyle,),
          )
        ],
      ),
      onTap: () => onTap(action),
    );
  }

  Widget _createExpandDrawerChildBodyItem(BuildContext context, {required String text, required Function(NavigationAction) onTap, required NavigationAction action}) {
    return ListTile(
      title: Text(text),
      onTap: () => onTap(action),
    );
  }

  Widget _expendedDrawerBody(BuildContext context, {required Function(NavigationAction) onTap}) {
    return ExpansionTile(
      //Transform used to remove space between title & icon
      title: Transform(
        transform: Matrix4.translationValues(-24, 0.0, 0.0),
        child: Text(context.resources.strings!.menuSubCategories, style: context.resources.style.drawerTextStyle,),
      ),
      leading: const Icon(Icons.category_outlined), //add icon
      childrenPadding: const EdgeInsets.only(left:34), //children padding
      children: [
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuAll, onTap: countryMenuClick, action: NavigationAction.allNews),
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuBusiness, onTap: countryMenuClick, action: NavigationAction.business),
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuEntertainment, onTap: countryMenuClick, action: NavigationAction.entertainment),
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuHealth, onTap: countryMenuClick, action: NavigationAction.health),
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuScience, onTap: countryMenuClick, action: NavigationAction.science),
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuSports, onTap: countryMenuClick, action: NavigationAction.sports),
        _createExpandDrawerChildBodyItem(context, text: context.resources.strings!.subMenuTechnology, onTap: countryMenuClick, action: NavigationAction.technology),
      ],
    );
  }
}
