class DashboardKpi {
  final int? ventasHoy;
  final double? totalVentasHoy;
  final int? ventasMes;
  final double? totalVentasMes;
  final double? valorInventario;
  final int? productosBajoStock;
  final int? ordenesPendientes;
  final double? totalOrdenesPendientes;

  DashboardKpi({
    this.ventasHoy,
    this.totalVentasHoy,
    this.ventasMes,
    this.totalVentasMes,
    this.valorInventario,
    this.productosBajoStock,
    this.ordenesPendientes,
    this.totalOrdenesPendientes,
  });

  factory DashboardKpi.fromJson(Map<String, dynamic> json) => DashboardKpi(
    ventasHoy: json["ventasHoy"],
    totalVentasHoy: (json["totalVentasHoy"]! as num).toDouble(),
    ventasMes: json["ventasMes"],
    totalVentasMes: (json["totalVentasMes"]! as num).toDouble(),
    valorInventario: (json["valorInventario"]! as num).toDouble(),
    productosBajoStock: json["productosBajoStock"],
    ordenesPendientes: json["ordenesPendientes"],
    totalOrdenesPendientes: (json["totalOrdenesPendientes"]! as num).toDouble(),
  );
  Map<String, dynamic> toJson() => {
    "ventasHoy": ventasHoy,
    "totalVentasHoy": totalVentasHoy,
    "ventasMes": ventasMes,
    "totalVentasMes": totalVentasMes,
    "valorInventario": valorInventario,
    "productosBajoStock": productosBajoStock,
    "ordenesPendientes": ordenesPendientes,
    "totalOrdenesPendientes": totalOrdenesPendientes,
  };
}
