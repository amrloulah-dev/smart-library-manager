enum RiskLevel { safe, coma, timeTrap, earlyFailure, obsolete }

class RiskAnalysisResult {
  final RiskLevel level;
  final String message;
  final String action;
  final double priorityScore;
  final int suggestedReturnQty;

  const RiskAnalysisResult({
    required this.level,
    required this.message,
    required this.action,
    this.priorityScore = 0.0,
    this.suggestedReturnQty = 0,
  });

  /// Helper factory for Safe status
  factory RiskAnalysisResult.safe() {
    return const RiskAnalysisResult(
      level: RiskLevel.safe,
      message: 'آمن',
      action: 'متابعة عادية',
      priorityScore: 0.0,
    );
  }
  RiskAnalysisResult copyWith({
    RiskLevel? level,
    String? message,
    String? action,
    double? priorityScore,
    int? suggestedReturnQty,
  }) {
    return RiskAnalysisResult(
      level: level ?? this.level,
      message: message ?? this.message,
      action: action ?? this.action,
      priorityScore: priorityScore ?? this.priorityScore,
      suggestedReturnQty: suggestedReturnQty ?? this.suggestedReturnQty,
    );
  }
}
