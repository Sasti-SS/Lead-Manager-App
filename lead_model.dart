class LeadModel {
  int? id;
  String name;
  String contact;
  String notes;
  String status; // New, Contacted, Converted, Lost

  LeadModel({
    this.id,
    required this.name,
    required this.contact,
    this.notes = "",
    this.status = "New",
  });

  factory LeadModel.fromMap(Map<String, dynamic> json) => LeadModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        contact: json['contact'] as String,
        notes: json['notes'] as String? ?? "",
        status: json['status'] as String? ?? "New",
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'contact': contact,
        'notes': notes,
        'status': status,
      };
}
