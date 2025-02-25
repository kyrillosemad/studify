sealed class ClassEvent {}

class AddClassForDoctor extends ClassEvent {
  String name;
  String date;
  AddClassForDoctor(this.name, this.date);
}

class DeleteClassForDoctor extends ClassEvent {
  String classId;
  DeleteClassForDoctor(this.classId);
}

class LeaveClassForStudent extends ClassEvent {
  String classId;
  LeaveClassForStudent(this.classId);
}


class GetClassForStudent extends ClassEvent {
  String searchQuery;
  GetClassForStudent(this.searchQuery);
}

class GetClassForDoctor extends ClassEvent {
  String searchQuery;
  GetClassForDoctor(this.searchQuery);
}

class GoToStudentClass extends ClassEvent {
  String date;
  String classId;
  String className;
  GoToStudentClass(this.classId, this.className, this.date);
}

class GoToDoctorClass extends ClassEvent {
  String date;
  String classId;
  String className;
  GoToDoctorClass(this.classId, this.className, this.date);
}
