import 'dart:math';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:star_wars_api/constants.dart';
import 'package:star_wars_api/providers/swapi_provider.dart';

class DetallePersonajesPage extends StatelessWidget {
  final String url;

  const DetallePersonajesPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwapiProvider provider = new SwapiProvider();
    Random rnd = new Random();
    int numefoto = 1 + rnd.nextInt(6);

    return Scaffold(
      backgroundColor: Color(0xFF1d2025),
      appBar: AppBar(
        title: Text('Personaje'),
      ),
      body: FutureBuilder(
          future: provider.getDataUrl(url),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var per = snapshot.data;
            return Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Column(
                    children: [
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(5),
                        color: Colors.black.withOpacity(0.5),
                        child: Text(
                          per['name'],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  color: Color(0xff3d4045),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Datos del Personaje',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              MdiIcons.deathStar,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                        DataTable(
                          columns: [
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Altura', style: TextStyle(color: Colors.white))),
                                DataCell(Text(per['height'],
                                    style: TextStyle(color: Colors.white))),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Peso', style: TextStyle(color: Colors.white))),
                                DataCell(
                                    Text(per['mass'], style: TextStyle(color: Colors.white))),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Nacimiento', style: TextStyle(color: Colors.white))),
                                DataCell(Text(per['birth_year'],
                                    style: TextStyle(color: Colors.white))),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Genero', style: TextStyle(color: Colors.white))),
                                DataCell(Text(per['gender'],
                                    style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColor,
                    ),
                    child: Text('Volver'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
