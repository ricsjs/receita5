import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//apenas a classe NewNavBar é acionada,
//pois é a única classe que depende de
//interação com o usuário

var dataObjects = [];

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Printando na classe MyApp");
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: DataTableWidget(jsonObjects: dataObjects),
          bottomNavigationBar: NewNavBar2(),
        ));
  }
}

class NewNavBar extends HookWidget {
  NewNavBar();

  @override
  Widget build(BuildContext context) {
    print("Printando na classe NewNavBar");
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class NewNavBar2 extends StatefulWidget {
  const NewNavBar2();

  @override
  _NewNavBar2State createState() => _NewNavBar2State();
}

class _NewNavBar2State extends State<NewNavBar2> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("Printando na classe NewNavBar2");

    if (_selectedIndex == 0) {
      print("café foi selecionado");
    } else if (_selectedIndex == 1) {
      print("cerveja foi selecionado");
    } else if (_selectedIndex == 2) {
      print("nação foi selecionado");
    }

    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
          label: "Cervejas",
          icon: Icon(Icons.local_drink_outlined),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;

  DataTableWidget({this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    print("Printando na classe DataBodyWidget");
    var columnNames = ["Nome", "Estilo", "IBU"],
        propertyNames = ["name", "style", "ibu"];

    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}
