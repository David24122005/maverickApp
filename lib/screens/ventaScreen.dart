import 'package:flutter/material.dart';
import 'package:maverickapp/models/venta.dart';
import 'package:maverickapp/services/VentaService.dart';
import 'package:maverickapp/widgets/ventaDetalle.dart';
import 'package:maverickapp/widgets/VentaCard.dart';

class VentaScreen extends StatefulWidget {
  const VentaScreen({Key? key}) : super(key: key);

  @override
  _VentaScreenState createState() => _VentaScreenState();
}

class _VentaScreenState extends State<VentaScreen> {
  final VentaService _ventaService = VentaService();
  List<Venta>? _ventas;
  bool _isLoading = true;
  String? _errorMessage;
  Venta? _ventaSeleccionada;

  @override
  void initState() {
    super.initState();
    _cargarVentas();
  }

  Future<void> _cargarVentas() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _ventaSeleccionada = null;
    });

    try {
      final response = await _ventaService.ObtenerVentas();
      if (response != null && response.exito && response.datos != null) {
        setState(() {
          _ventas = response.datos;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response?.mensaje ?? 'Error desconocido';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar los datos: $e';
        _isLoading = false;
      });
    }
  }

  List<Venta> _getVentas() {
    return _ventas ?? [];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Cargando ventas...'),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _cargarVentas,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final ventasItems = _getVentas();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ventas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarVentas,
            tooltip: "Actualizar",
          ),
        ],
      ),
      body: Row(
        children: [
          // ── Panel izquierdo: lista de ventas ──────────────────────────
          SizedBox(
            width: 1000,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
              ),
              child: ventasItems.isEmpty
                  ? const Center(child: Text('No hay ventas disponibles'))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: ventasItems.length,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: Colors.grey[300]),
                      itemBuilder: (context, index) {
                        final item = ventasItems[index];
                        final isSelected = _ventaSeleccionada == item;

                        return InkWell(
                          onTap: () =>
                              setState(() => _ventaSeleccionada = item),
                          child: Container(
                            color: isSelected
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1)
                                : null,
                            child: VentaCard(item),
                          ),
                        );
                      },
                    ),
            ),
          ),

          // ── Panel derecho: detalle de la venta seleccionada ───────────
          Expanded(
            child: _ventaSeleccionada == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.ads_click,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Selecciona una venta para ver sus detalles',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : VentaDetalle(venta: _ventaSeleccionada!),
          ),
        ],
      ),
    );
  }
}
