class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    required this.email,
    required this.gender,
    required this.contactNumber,
    this.referenceContactNumber,
    this.dateOfBirth,
    required this.address,
    required this.city,
    required this.state,
    required this.cnic,
    required this.designation,
    this.team,
    this.teamName,
    this.departmentName,
    this.createdBy,
    this.updatedBy,
    required this.role,
    required this.employmentStatus,
    required this.joiningDate,
    required this.isActive,
    required this.employeeId,
    this.isDefaultWorkingHours = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final team = json['team'] as Map<String, dynamic>?;

    return User(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePicture: json['profile_picture'],
      email: json['email'],
      gender: json['gender'],
      contactNumber: json['contact_number'],
      referenceContactNumber: json['reference_contact_number'],
      dateOfBirth: json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null,
      address: json['address'],
      city: json['city'],
      state: json['state'],
      cnic: json['cnic'],
      designation: json['designation'],
      team: team,
      teamName: team?['name'],
      departmentName: team?['department']?['name'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      role: json['role'],
      employmentStatus: json['employment_status'],
      joiningDate: DateTime.parse(json['joining_date']),
      isActive: json['is_active'],
      employeeId: json['employee_id'],
      isDefaultWorkingHours: json['is_default_working_hours'],
    );
  }

  final String id;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final String email;
  final String gender;
  final String contactNumber;
  final String? referenceContactNumber;
  final DateTime? dateOfBirth;
  final String address;
  final String city;
  final String state;
  final String cnic;
  final String designation;
  final Map<String, dynamic>? team;
  final String? teamName;
  final String? departmentName;
  final String? createdBy;
  final String? updatedBy;
  final String role;
  final String employmentStatus;
  final DateTime joiningDate;
  final bool isActive;
  final String employeeId;
  final bool? isDefaultWorkingHours;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'first_name': firstName,
    'last_name': lastName,
    'profile_picture': profilePicture,
    'email': email,
    'gender': gender,
    'contact_number': contactNumber,
    'reference_contact_number': referenceContactNumber,
    'date_of_birth': dateOfBirth?.toIso8601String(),
    'address': address,
    'city': city,
    'state': state,
    'cnic': cnic,
    'designation': designation,
    'team': team,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'role': role,
    'employment_status': employmentStatus,
    'joining_date': joiningDate.toIso8601String(),
    'is_active': isActive,
    'employee_id': employeeId,
    'is_default_working_hours': isDefaultWorkingHours,
  };
}

