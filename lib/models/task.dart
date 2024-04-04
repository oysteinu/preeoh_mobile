class Task {
  final String key;
  final String title;

  const Task({required this.key, required this.title});

  factory Task.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'key': String key, 'title': String title} =>
        Task(key: key, title: title),
      _ => throw const FormatException('Failed to load task.'),
    };
  }
}
