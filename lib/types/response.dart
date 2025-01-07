class PaginationResponse<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  PaginationResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return PaginationResponse<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List).map(fromJsonT).toList(),
    );
  }

  factory PaginationResponse.fromResponseJson(
    dynamic json,
    T Function(dynamic) fromJsonT,
  ) {
    return PaginationResponse<T>(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List).map(fromJsonT).toList(),
    );
  }
}
