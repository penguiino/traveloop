import 'container.dart';

class Trip {
  final String id;
  final String name;
  final String ownerId;
  final List<TripContainer> containers;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> collaborators;
  final Map<String, dynamic> metadata;
  final String description;

  Trip({
    required this.id,
    required this.name,
    required this.ownerId,
    this.containers = const [],
    required this.startDate,
    required this.endDate,
    this.collaborators = const [],
    this.metadata = const {},
    required this.description,
  });

  // Add method to convert from JSON
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      containers: (json['containers'] as List)
          .map((container) => TripContainer.fromJson(container))
          .toList(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      collaborators: List<String>.from(json['collaborators']),
      metadata: json['metadata'] ?? {},
      description: json['description'] ?? '',
    );
  }

  // Add method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'containers': containers.map((c) => c.toJson()).toList(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'collaborators': collaborators,
      'metadata': metadata,
      'description': description,
    };
  }

  // Add method to add a container to the trip
  void addContainer(TripContainer container) {
    containers.add(container);
  }

  // Add method to remove a container from the trip
  void removeContainer(String containerId) {
    containers.removeWhere((container) => container.id == containerId);
  }

  // Add method to add a collaborator to the trip
  void addCollaborator(String userId) {
    collaborators.add(userId);
  }

  // Add method to remove a collaborator from the trip
  void removeCollaborator(String userId) {
    collaborators.removeWhere((collaborator) => collaborator == userId);
  }

  // Factory constructor for an empty Trip
  factory Trip.empty() {
    return Trip(
      id: '',
      name: '',
      ownerId: '',
      containers: [],
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      collaborators: [],
      metadata: {},
      description: '',
    );
  }
}
