import 'package:flutter/material.dart';
import 'package:maverickapp/models/Kpis/dashboardKpi.dart';
import 'package:maverickapp/services/kpiService.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboardscreen> {
  final Kpiservice _kpiservice = Kpiservice();
  DashboardKpi? _dashboardData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _kpiservice.ObtenerKpiDashboard();

      if (response != null && response.exito && response.datos != null) {
        setState(() {
          _dashboardData = response.datos;
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

  // Método para convertir DashboardKpi en una lista de KPIs para mostrar
  List<_KpiItem> _getKpiItems() {
    if (_dashboardData == null) return [];

    return [
      _KpiItem(
        title: 'Ventas Hoy',
        value: _dashboardData!.ventasHoy?.toString() ?? '0',
        subtitle:
            'Total: \$${_dashboardData!.totalVentasHoy?.toStringAsFixed(2) ?? '0.00'}',
        icon: Icons.trending_up,
        color: Colors.green,
      ),
      _KpiItem(
        title: 'Ventas del Mes',
        value: _dashboardData!.ventasMes?.toString() ?? '0',
        subtitle:
            'Total: \$${_dashboardData!.totalVentasMes?.toStringAsFixed(2) ?? '0.00'}',
        icon: Icons.calendar_month,
        color: Colors.blue,
      ),
      _KpiItem(
        title: 'Valor Inventario',
        value:
            '\$${_dashboardData!.valorInventario?.toStringAsFixed(2) ?? '0.00'}',
        subtitle: 'Bajo stock: ${_dashboardData!.productosBajoStock ?? 0}',
        icon: Icons.inventory,
        color: Colors.orange,
      ),
      _KpiItem(
        title: 'Órdenes Pendientes',
        value: _dashboardData!.ordenesPendientes?.toString() ?? '0',
        subtitle:
            'Total: \$${_dashboardData!.totalOrdenesPendientes?.toStringAsFixed(2) ?? '0.00'}',
        icon: Icons.pending_actions,
        color: Colors.red,
      ),
    ];
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
              Text('Cargando KPIs...'),
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
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _loadDashboardData,
                  icon: Icon(Icons.refresh),
                  label: Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final kpiItems = _getKpiItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadDashboardData,
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: kpiItems.length,
          itemBuilder: (context, index) => _buildKpiCard(kpiItems[index]),
        ),
      ),
    );
  }

  Widget _buildKpiCard(_KpiItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Aquí puedes agregar navegación o acciones al tocar un KPI
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${item.title}: ${item.value}'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, size: 32, color: item.color),
              ),
              const SizedBox(height: 16),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: item.color,
                    ),
                  ),
                ),
              ),
              if (item.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  item.subtitle!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Clase auxiliar para los items KPI
class _KpiItem {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;

  _KpiItem({
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.color,
  });
}
