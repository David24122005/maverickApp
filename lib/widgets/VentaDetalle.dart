import 'package:flutter/material.dart';
import 'package:maverickapp/models/cliente.dart';
import 'package:maverickapp/models/venta.dart';
import 'package:maverickapp/services/ClienteService.dart';

class VentaDetalle extends StatefulWidget {
  final Venta? venta;

  const VentaDetalle({Key? key, this.venta}) : super(key: key);

  VentaDetalleState createState() => VentaDetalleState();
}

class VentaDetalleState extends State<VentaDetalle> {
  final ClienteService _clienteService = ClienteService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _clienteIdController;
  String? _opcionSeleccionada = "0";
  List<Cliente>? _clientes;

  @override
  void initState() {
    super.initState();
    _clienteIdController = TextEditingController(
      text: widget.venta?.cliente?.id?.toString() ?? "0",
    );
    _opcionSeleccionada = widget.venta?.cliente?.id?.toString();
    _obtenerClientes();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalle de Venta',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Tarjeta principal con los datos de la venta
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ ]),
                  ),
                  TextFormField(
                    controller: TextEditingController(
                      text: widget.venta?.numeroVenta ?? '—',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Número de Venta',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: TextEditingController(
                      text: widget.venta?.usuario?.nombre ?? '—',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Vendedor',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: widget.venta?.cliente?.id?.toString(),
                    items: _clientes?.map((cliente) {
                      return DropdownMenuItem<String>(
                        value: cliente.id.toString(),
                        child: Text(cliente.nombre ?? 'Cliente'),
                      );
                    }).toList(),
                    onChanged: (nuevoValor) {
                      setState(() {
                        _opcionSeleccionada = nuevoValor;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Cliente',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Cliente>?> _obtenerClientes() async {
    try {
      final response = await _clienteService.ObtenerClientes();
      if (response != null && response.exito && response.datos != null) {
        setState(() {
          _clientes = response.datos;
        });
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
