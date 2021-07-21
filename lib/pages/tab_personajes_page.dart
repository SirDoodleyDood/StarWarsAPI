import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:star_wars_api/pages/detalle_personajes_page.dart';
import 'package:star_wars_api/providers/swapi_provider.dart';

class TabPersonajesPage extends StatefulWidget {
  TabPersonajesPage({Key? key}) : super(key: key);

  @override
  _TabPersonajesPageState createState() => _TabPersonajesPageState();
}

class _TabPersonajesPageState extends State<TabPersonajesPage> {
  SwapiProvider provider = new SwapiProvider();
  ScrollController scrollCtrl = new ScrollController();
  int paginaActual = 1;
  List<dynamic> listaDatos = [];
  late bool quedanDatos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
        setState(() {
          paginaActual++;
        });
      }
    });
  }

  Future<List<dynamic>> cargarDatos(int numPagina) async {
    var data = await provider.getData(tipo: 'people', pagina: numPagina);
    quedanDatos = data != null;
    if (data != null) {
      listaDatos.addAll(data['results']);
    }
    return listaDatos;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Text(
              'Personajes',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: cargarDatos(paginaActual),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.separated(
                    controller: scrollCtrl,
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: listaDatos.length + 1,
                    itemBuilder: (context, index) {
                      if (index == listaDatos.length) {
                        if (quedanDatos) {
                          return Center(
                            child: LinearProgressIndicator(),
                          );
                        } else {
                          return Center(
                            child: Text('Fin de la lista'),
                          );
                        }
                      }
                      return ListTile(
                        leading: Icon(MdiIcons.accountCircle),
                        title: Text(listaDatos[index]['name']),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () => navegar(context, listaDatos[index]['url']),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void navegar(BuildContext context, String url) {
    final route = new MaterialPageRoute(
      builder: (context) => DetallePersonajesPage(url: url),
    );

    Navigator.push(context, route);
  }
}
