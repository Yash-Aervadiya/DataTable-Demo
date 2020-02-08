import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Superheros(),
    );
  }
}

class Superheros extends StatefulWidget {
  @override
  _SuperherosState createState() => _SuperherosState();
}

class _SuperherosState extends State<Superheros> {
  List<Avengers> avengers;
  List<Avengers> selectedAvengers;
  bool sort;

  @override
  void initState() {
    sort = false;
    selectedAvengers = [];
    avengers = Avengers.getAvengers();
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        avengers.sort((a, b) => a.name.compareTo(b.name));
      } else {
        avengers.sort((a, b) => b.name.compareTo(a.name));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avengers DataTable"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: DataTable(
              sortAscending: sort,
              sortColumnIndex: 0,
              columns: [
                DataColumn(
                    label: Text("Name", style: TextStyle(fontSize: 16)),
                    numeric: false,
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        sort = !sort;
                      });
                      onSortColum(columnIndex, ascending);
                    }),
                DataColumn(
                  label: Text("Weapons", style: TextStyle(fontSize: 16)),
                  numeric: false,
                ),
              ],
              rows: avengers
                  .map(
                    (avenger) => DataRow(
                        selected: selectedAvengers.contains(avenger),
                        cells: [
                          DataCell(
                            Text(avenger.name),
                            onTap: () {
                              print('Selected ${avenger.name}');
                            },
                          ),
                          DataCell(
                            Text(avenger.weapon),
                          ),
                        ]),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Avengers {
  String name;
  String weapon;

  Avengers({this.name, this.weapon});

  static List<Avengers> getAvengers() {
    return <Avengers>[
      Avengers(name: "Captain America", weapon: "Shield"),
      Avengers(name: "Thor", weapon: "Mjolnir"),
      Avengers(name: "Spiderman", weapon: "Web Shooters"),
      Avengers(name: "Doctor Strange ", weapon: "Eye Of Agamotto"),
    ];
  }
}
