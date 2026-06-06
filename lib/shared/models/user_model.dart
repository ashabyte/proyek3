// ─── User Model ──────────────────────────────────────────────────────────────
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        avatarUrl: json['avatar_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
      };
}

// ─── Service Model ────────────────────────────────────────────────────────────
class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String category; // 'printing' | 'design' | 'photography'
  final double price;
  final String? imageUrl;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.imageUrl,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'price': price,
        'image_url': imageUrl,
      };
}

// ─── Booking Model ────────────────────────────────────────────────────────────
enum BookingStatus { upcoming, completed, cancelled }

class BookingModel {
  final String id;
  final String serviceId;
  final String serviceName;
  final String userId;
  final DateTime scheduledAt;
  final BookingStatus status;
  final double totalAmount;
  final String? notes;

  const BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.userId,
    required this.scheduledAt,
    required this.status,
    required this.totalAmount,
    this.notes,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] ?? '',
        serviceId: json['service_id'] ?? '',
        serviceName: json['service_name'] ?? '',
        userId: json['user_id'] ?? '',
        scheduledAt: DateTime.parse(
            json['scheduled_at'] ?? DateTime.now().toIso8601String()),
        status: BookingStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => BookingStatus.upcoming,
        ),
        totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'service_id': serviceId,
        'service_name': serviceName,
        'user_id': userId,
        'scheduled_at': scheduledAt.toIso8601String(),
        'status': status.name,
        'total_amount': totalAmount,
        'notes': notes,
      };
}
