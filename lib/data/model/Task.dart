class Task {

  int id;
  String title;
  String description;
  int dateCreated;
  int todoDate;
  int lastUpdateDate;
  int status;

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