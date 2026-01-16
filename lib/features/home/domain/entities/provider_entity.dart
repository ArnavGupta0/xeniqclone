class ProviderEntity {
  final String id;
  final String name;
  final String avatarUrl;
  final double latitude;
  final double longitude;
  final bool isOnline;
  final double pricePerMinute;

  const ProviderEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.latitude,
    required this.longitude,
    required this.isOnline,
    required this.pricePerMinute,
  });

  factory ProviderEntity.fromJson(Map<String, dynamic> json) {
    return ProviderEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      avatarUrl: json['avatar_url'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      isOnline: json['is_online'] as bool? ?? false,
      pricePerMinute: (json['price_per_minute'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
