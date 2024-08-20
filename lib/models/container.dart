import 'package:flutter/foundation.dart';

class TripContainer {
  final String id;
  final String title;
  final String type;
  final List<TripContainer> nestedContainers;
  final Map<String, dynamic> details;

  TripContainer({
    required this.id,
    required this.title,
    required this.type,
    this.nestedContainers = const [],
    this.details = const {},
  });

  // Add method to convert from JSON
  factory TripContainer.fromJson(Map<String, dynamic> json) {
    return TripContainer(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      nestedContainers: (json['nestedContainers'] as List)
          .map((container) => TripContainer.fromJson(container))
          .toList(),
      details: json['details'] ?? {},
    );
  }

  // Add method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'nestedContainers': nestedContainers.map((c) => c.toJson()).toList(),
      'details': details,
    };
  }

  // Add method to add a nested container
  void addNestedContainer(TripContainer container) {
    nestedContainers.add(container);
  }

  // Add method to remove a nested container
  void removeNestedContainer(String containerId) {
    nestedContainers.removeWhere((container) => container.id == containerId);
  }
}
