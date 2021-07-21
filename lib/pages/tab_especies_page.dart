import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:star_wars_api/constants.dart';
import 'package:star_wars_api/providers/swapi_provider.dart';

class TabEspeciesPage extends StatefulWidget {
  TabEspeciesPage({Key? key}) : super(key: key);

  @override
  _TabEspeciesPageState createState() => _TabEspeciesPageState();
}

class _TabEspeciesPageState extends State<TabEspeciesPage> {
  SwapiProvider provider = new SwapiProvider();
  int paginaActual = 1;
  int cantidadPaginas = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Text('Especies'),
          ),
          Expanded(
            child: FutureBuilder(
              future: provider.getData(tipo: 'species', pagina: paginaActual),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  cantidadPaginas = (snapshot.data['count'] / 10).ceil();
                  return DataTable(
                    columnSpacing: 50,
                    columns: [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Clasificación')),
                      DataColumn(label: Text('Máx Edad')),
                    ],
                    rows: snapshot.data['results'].map<DataRow>((e) {
                      return DataRow(
                        cells: [
                          DataCell(Text(e['name'])),
                          DataCell(Text(e['classification'])),
                          DataCell(Text(e['average_lifespan'])),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  MdiIcons.arrowLeftDropCircle,
                  size: 30,
                  color: kSecondaryColor,
                ),
                onPressed: () {
                  if (paginaActual > 1) {
                    setState(() {
                      paginaActual--;
                    });
                  }
                },
              ),
              Text(
                '$paginaActual',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.arrowRightDropCircle,
                  size: 30,
                  color: kSecondaryColor,
                ),
                onPressed: () {
                  if (paginaActual < cantidadPaginas) {
                    setState(() {
                      paginaActual++;
                    });
                  }
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
