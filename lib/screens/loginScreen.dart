import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maverickapp/screens/homeScreen.dart';
import 'package:maverickapp/services/AutenticacionService.dart';
import 'package:maverickapp/widgets/Tarjeta.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormController = TextEditingController();
  final _passwordFormController = TextEditingController();

  //Esta variable es donde se almacenara el token que devuelve la api
  final _storage = const FlutterSecureStorage();

  final Autenticacionservice _autenticacionservice = Autenticacionservice();
  bool _mostrarTarjeta = false;
  String? _mensaje = "";
  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _mostrarTarjeta = false;
      });
      final respuesta = await _autenticacionservice.login(
        _emailFormController.text,
        _passwordFormController.text,
      );
      setState(() => _isLoading = false);
      if (respuesta != null) {
        if (respuesta.exito) {
          String tokenDeLaApi = respuesta.datos!.token!;
          await _storage.write(key: 'token', value: tokenDeLaApi);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          setState(() {
            _mensaje = respuesta.mensaje;
            _mostrarTarjeta = true;
          });
        }
      } else {
        setState(() {
          _mensaje = "Error de conexion con el servidor.";
          _mostrarTarjeta = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //se muestra el logo oficial de la app, seguido de una corta bienvenida a la aplicacion.
                    const Icon(
                      Icons.shopping_cart_rounded,
                      size: 100,
                      color: Colors.lightBlue,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),

                    //El input de el correo electronico
                    TextFormField(
                      controller: _emailFormController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Correo electronico",
                        prefix: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Debes ingresar el email.";
                        if (!value.contains("@")) return "Correo no valido.";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    //El input de la Contraseña
                    TextFormField(
                      controller: _passwordFormController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        prefix: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.length > 8)
                          return "La contraseña debe tener minimo 8 caracteres.";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    //Boton de inicio de sesion
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text("INICIAR SESIÓN"),
                          ),
                  ],
                ),
              ),
            ),
          ),
          if (_mostrarTarjeta)
            Container(
              color: Colors.black54,
              child: Tarjeta(
                titulo: "No se inicio sesion.",
                mensaje: _mensaje ?? "Error desconocido.",
                onCerrar: () {
                  setState(() {
                    _mostrarTarjeta = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
