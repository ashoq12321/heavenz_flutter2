class Course {
  late String courseName;
  late String ptTrainerName;
  late String noOfLessons;
  late String duration;
  late String currentLesson;

  @override
  String toString() {
    return '[courseName: $courseName, ptTrainerName: $ptTrainerName, noOfLessons: $noOfLessons, duration: $duration, currentLesson: $currentLesson]';
  }
}
