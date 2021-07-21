import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:star_wars_api/constants.dart';
import 'package:star_wars_api/pages/tab_especies_page.dart';
import 'package:star_wars_api/pages/tab_naves_page.dart';
import 'package:star_wars_api/pages/tab_personajes_page.dart';
import 'package:star_wars_api/pages/tab_planetas_page.dart';

class TabsPage extends StatelessWidget {
  final _tabPaginas = <Tab>[
    const Tab(icon: Icon(MdiIcons.spaceInvaders), text: 'Espcies'),
    const Tab(icon: Icon(MdiIcons.rocketLaunch), text: 'Naves'),
    const Tab(icon: Icon(MdiIcons.accountCircle), text: 'Personajes'),
    const Tab(icon: Icon(MdiIcons.earth), text: 'Planetas'),
  ];

  final _paginas = <Widget>[
    TabEspeciesPage(),
    TabNavesPage(),
    TabPersonajesPage(),
    TabPlanetasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabPaginas.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Star Wars API',
            style: TextStyle(color: kAccentColor),
          ),
          leading: Icon(
            MdiIcons.deathStarVariant,
            color: kAccentColor,
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabPaginas,
          ),
        ),
        body: TabBarView(
          children: _paginas,
        ),
      ),
    );
  }
}
