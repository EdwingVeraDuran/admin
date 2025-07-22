class Query {
  final int page;
  final int pageSize;
  final String? query;

  Query({required this.page, required this.pageSize, this.query});

  Query copyWith({int? page, int? pageSize, String? query}) {
    return Query(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      query: query ?? this.query,
    );
  }

  bool get isSearch => query != null && query!.isNotEmpty;
}
