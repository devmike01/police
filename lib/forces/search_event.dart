abstract class SearchEvent{}
class SearchTextEvent extends SearchEvent{
  String text;
  SearchTextEvent(this.text);
}

class ClickSearchEvent extends SearchEvent{
  bool showField;
  ClickSearchEvent(this.showField);
}