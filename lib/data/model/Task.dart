class Task {

  final int id;
  final String title;
  final String description;
  final BigInt dateCreated;
  final BigInt todoDate;
  final BigInt lastUpdateDate;
  final int status;

  Task(
      this.id,
      this.title,
      this.description,
      this.dateCreated,
      this.todoDate,
      this.lastUpdateDate,
      this.status
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateCreated': dateCreated,
      'todoDate': todoDate,
      'lastUpdateDate': lastUpdateDate,
      'status': status
    };
  }

}