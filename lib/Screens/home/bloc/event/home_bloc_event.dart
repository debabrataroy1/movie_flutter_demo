
abstract class HomeBlocEvent {
  int pageNo;
  HomeBlocEvent(this.pageNo);

  @override
  List<Object> get props => [];
}

class FetchCarouselDataEvent extends HomeBlocEvent {
   FetchCarouselDataEvent(this.pageNo) : super(0);

  @override
  int pageNo;

  @override
  List<Object> get props => [pageNo];
}

class HomeFetchDataEvent extends HomeBlocEvent {
  HomeFetchDataEvent(this.pageNo): super(0);
  @override
  int pageNo;

  @override
  List<Object> get props => [pageNo];
}
