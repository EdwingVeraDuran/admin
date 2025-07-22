class PaginatedData<T> {
  final List<T> data;
  final int total;

  PaginatedData({required this.data, required this.total});
}
