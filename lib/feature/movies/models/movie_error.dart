enum MovieError {
  initial(title: 'Something went wrong while downloading genres. Check network connection.', canClose: false),
  loadMovies(title: 'Something went wrong while downloading movies. Check network connection.', canClose: false),
  loadMore(title: 'Something went wrong while downloading more movies. You can try again, or close and continue using app.', canClose: true);

  final String title;
  final bool canClose;

  const MovieError({required this.title, required this.canClose});
}