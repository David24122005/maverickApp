import 'package:flutter/material.dart';
import 'package:maverickapp/models/venta.dart';

class VentaCard extends StatelessWidget {
  final Venta venta;

  const VentaCard(this.venta);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              venta.numeroVenta ?? 'Número de venta no disponible',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              venta.usuario != null
                  ? 'Vendedor: ${venta.usuario?.nombre}'
                  : 'Vendedor no disponible',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              venta.cliente != null
                  ? "Cliente: ${venta.cliente?.nombre}"
                  : "Venta general",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            if (venta.detalles != null && venta.detalles!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Productos:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ...venta.detalles!.map(
                    (detalle) => Text(
                      '- ${detalle.producto?.nombre ?? 'Producto'} x${detalle.cantidad} = \$${detalle.precioUnitario?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Text(
              venta.total != null
                  ? '\$${venta.total!.toStringAsFixed(2)}'
                  : 'Total no disponible',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
