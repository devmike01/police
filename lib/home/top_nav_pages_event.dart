abstract class TopNavPagesEvent{
  String getTitle();
  int getIndex();
}

class ForcesEvent extends TopNavPagesEvent{

  @override
  int getIndex() {
    return 0;
  }

  @override
  String getTitle() {
    return "Forces in the\nUnited Kingdom";
  }
}
class CrimesEvent  extends TopNavPagesEvent{

  @override
  int getIndex() {
    return 1;
  }

  @override
  String getTitle() {
    return "Crimes around your\nselected area";
  }
}
class NewsEvent extends TopNavPagesEvent{

  @override
  int getIndex() {
    return 2;
  }


  @override
  String getTitle() {
    return "Happenings in your\ncurrent neighbouhood.";
  }
}