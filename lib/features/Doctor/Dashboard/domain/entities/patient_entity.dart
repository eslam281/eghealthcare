class PatientEntity {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String image;
  final String medicalSummary;

  const PatientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.image,
    required this.medicalSummary,
  });
}
