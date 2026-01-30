enum InventoryEventType { purchase, sale, supplierReturn, customerReturn }

class ItemMovementEvent {
  final DateTime date;
  final InventoryEventType type;
  final int quantity;
  final double price; // Unit price/cost involved in this event
  final String entityName; // Supplier Name or "General Customer"
  final String? referenceId; // Invoice ID

  ItemMovementEvent({
    required this.date,
    required this.type,
    required this.quantity,
    required this.price,
    required this.entityName,
    this.referenceId,
  });
}

class ItemStats {
  final double totalProfit;
  final String bestSupplier;
  final double avgTurnoverDays;
  final Map<String, int> supplierBreakdown;

  const ItemStats({
    this.totalProfit = 0.0,
    this.bestSupplier = 'N/A',
    this.avgTurnoverDays = 0.0,
    this.supplierBreakdown = const {},
  });
}

class ItemHistoryResult {
  final List<ItemMovementEvent> events;
  final ItemStats stats;

  ItemHistoryResult({required this.events, required this.stats});
}
