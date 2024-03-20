import 'package:equatable/equatable.dart';

class NewFeed extends Equatable {
  final String id;
  final String title;
  final String dates;
  final String subtitle1;
  final String comment;
  final String subtitle2;
  final String view;
  final String image;
  bool? isCompleted;
  bool? isCancelled;

  NewFeed({
    required this.id,
    required this.title,
    required this.dates,
    required this.subtitle1,
    required this.comment,
    required this.subtitle2,
    required this.view,
    required this.image,
    this.isCompleted,
    this.isCancelled,
  }) {
    isCompleted = isCompleted ?? false;
    isCancelled = isCancelled ?? false;
  }

  NewFeed copyWith({
    final String? id,
    final String? title,
    final String? dates,
    final String? subtitle1,
    final String? comment,
    final String? subtitle2,
    final String? view,
    final String? image,
    final bool? isCompleted,
    final bool? isCancelled,
  }) {
    return NewFeed(
      id: id ?? this.id,
      title: title ?? this.title,
      dates: dates ?? this.dates,
      subtitle1: subtitle1 ?? this.subtitle1,
      comment: comment ?? this.comment,
      subtitle2: subtitle2 ?? this.subtitle2,
      view: view ?? this.view,
      image: image ?? this.image,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        dates,
        subtitle1,
        comment,
        subtitle2,
        view,
        image,
        isCompleted,
        isCancelled,
      ];
}
