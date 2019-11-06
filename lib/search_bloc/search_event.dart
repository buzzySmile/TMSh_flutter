import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  factory SearchEvent.query(String searchQuery) {
    return SearchEventQuery(searchQuery);
  }
  factory SearchEvent.next() = SearchEventNext;
}

class SearchEventQuery extends SearchEvent {
  final String query;
  SearchEventQuery(this.query);

  @override
  List<Object> get props => [query];
}

class SearchEventNext extends SearchEvent {
  @override
  List<Object> get props => [];
}
