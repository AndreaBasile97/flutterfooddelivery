class Resource {
  final Status status;
  Resource({this.status});
}

enum Status { Success, Error, Cancelled }
