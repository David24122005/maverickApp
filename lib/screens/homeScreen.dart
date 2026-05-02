import 'package:flutter/material.dart';
import 'package:maverickapp/screens/dashboardScreen.dart';
import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indiceActual = 0;

  final List<Widget> _vistas = [
    const Dashboardscreen(),
    const Center(child: Text("Productos", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Ventas", style: TextStyle(fontSize: 24))),
    const Center(
      child: Text("Ordenes de compra", style: TextStyle(fontSize: 24)),
    ),
    const Center(child: Text("Usuarios", style: TextStyle(fontSize: 24))),
  ];

  void _cerrarSesion() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Menu superior para cerrar sesion
      appBar: AppBar(
        title: const Text(
          "Maverick",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: _cerrarSesion,
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar sesion",
          ),
        ],
      ),

      //Est cambia entre las pantallas
      body: IndexedStack(index: _indiceActual, children: _vistas),

      //Menu inferior para cambiar entre pantallas
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indiceActual,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black45,
        onTap: (nuevoindice) {
          setState(() {
            _indiceActual = nuevoindice;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_rounded),
            label: "Ventas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage_rounded),
            label: "Productos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Ordenes de compra",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Usuarios"),
        ],
      ),
    );
  }
}
