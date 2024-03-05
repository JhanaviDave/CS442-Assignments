class PersonInfo {
  // Person's information class with name and email
  final String name;
  final String email;

  PersonInfo({required this.name, required this.email});
}

class SNS {
  // Social Network site/link class
  final String instagram;
  final String linkedin;

  SNS({required this.instagram, required this.linkedin});
}

class ImageAsset {
  //Images class
  final String imagePath;

  ImageAsset({required this.imagePath});
}

class Interests {
  //Hobbies & Interests class
  final String hobbies;

  Interests({required this.hobbies});
}

class ProjectInfo {
  //Details of project class
  final String projectName;
  final String timeOfImplementation;

  ProjectInfo({required this.projectName, required this.timeOfImplementation});
}
