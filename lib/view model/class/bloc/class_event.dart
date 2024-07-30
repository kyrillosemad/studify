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



class GetClassForStudent extends ClassEvent {
  String searchQuery;
  GetClassForStudent(this.searchQuery);
}

class GetClassForDoctor extends ClassEvent {
  String searchQuery;
  GetClassForDoctor(this.searchQuery);
}
