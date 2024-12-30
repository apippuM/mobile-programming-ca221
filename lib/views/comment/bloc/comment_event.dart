part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentLoadEvent extends CommentEvent {}

class CommentGetByIdEvent extends CommentEvent {
  final String id;

  const CommentGetByIdEvent(this.id);
}

class CommentAddEvent extends CommentEvent {
  final Comment newComment;

  const CommentAddEvent(this.newComment);
}

class CommentUpdateEvent extends CommentEvent {
  final Comment updatedComment;

  const CommentUpdateEvent(this.updatedComment);
}

class CommentDeleteEvent extends CommentEvent {
  final String id;

  const CommentDeleteEvent(this.id);
}

class CommentNavigateToAddEvent extends CommentEvent {}

class CommentNavigateToUpdateEvent extends CommentEvent {
  final String id;
  
  const CommentNavigateToUpdateEvent(this.id);
}

class CommentNavigateToDeleteEvent extends CommentEvent {
  final String id;
  
  const CommentNavigateToDeleteEvent(this.id);
}

class CommentNavigateBackEvent extends CommentEvent {}