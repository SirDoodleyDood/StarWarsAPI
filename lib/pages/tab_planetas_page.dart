import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:star_wars_api/providers/swapi_provider.dart';

class TabPlanetasPage extends StatefulWidget {
  TabPlanetasPage({Key? key}) : super(key: key);

  @override
  _TabPlanetasPageState createState() => _TabPlanetasPageState();
}

class _TabPlanetasPageState extends State<TabPlanetasPage> {
  SwapiProvider provider = new SwapiProvider();
  ScrollController scrollCtrl = new ScrollController();
  int paginaActual = 1;
  List<dynamic> listaDatos = [];
  late bool quedanDatos;
  var coloresCard = [0xFFB4282D, 0xFFDA5A38, 0xFFF7A23A];

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
    var data = await provider.getData(tipo: 'planets', pagina: numPagina);
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
              'Planetas',
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
                      return Card(
                        color: Color(coloresCard[index % 3]),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    listaDatos[index]['name'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Icon(
                                    MdiIcons.earth,
                                    size: 30,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Text(
                                  'Rotation Period: ${listaDatos[index]['rotation_period']}'),
                              Text(
                                  'Orbital Period: ${listaDatos[index]['orbital_period']}'),
                              Text('Gravity: ${listaDatos[index]['gravity']}'),
                              Text('Climate: ${listaDatos[index]['climate']}'),
                            ],
                          ),
                        ),
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
}
