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

  // Convert from JSON
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

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'nestedContainers': nestedContainers.map((c) => c.toJson()).toList(),
      'details': details,
    };
  }

  // Convert from Map (used for Firestore or other map-based storage)
  factory TripContainer.fromMap(Map<String, dynamic> map) {
    return TripContainer(
      id: map['id'],
      title: map['title'],
      type: map['type'],
      nestedContainers: (map['nestedContainers'] as List)
          .map((container) => TripContainer.fromMap(container))
          .toList(),
      details: Map<String, dynamic>.from(map['details'] ?? {}),
    );
  }

  // Convert to Map (for storing in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'nestedContainers': nestedContainers.map((c) => c.toMap()).toList(),
      'details': details,
    };
  }

  // Add a nested container
  void addNestedContainer(TripContainer container) {
    nestedContainers.add(container);
  }

  // Remove a nested container
  void removeNestedContainer(String containerId) {
    nestedContainers.removeWhere((container) => container.id == containerId);
  }
}
