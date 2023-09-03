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
    return "Forces in the United Kingdom";
  }
}
class CrimesEvent  extends TopNavPagesEvent{

  @override
  int getIndex() {
    return 1;
  }

  @override
  String getTitle() {
    return "See crimes around your selected\narea";
  }
}
class NewsEvent extends TopNavPagesEvent{

  @override
  int getIndex() {
    return 2;
  }


  @override
  String getTitle() {
    return "See what's happening in your\ncurrent neighbouhood.";
  }
}