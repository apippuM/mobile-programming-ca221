part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

abstract class CommentLoadingState extends CommentState {}

final class CommentGetLoadingState extends CommentLoadingState {}

abstract class CommmentActionState extends CommentState {
  const CommmentActionState();
}

final class CommentLoadedSuccessState extends CommentState {
  final List<Comment> comments;
  
  const CommentLoadedSuccessState(this.comments);
  
  @override
  List<Object> get props => [comments];
}

final class CommentLoadErrorActionState extends CommmentActionState {
  final String message;
  
  const CommentLoadErrorActionState(this.message);
}

final class CommentGetByIdSuccessState extends CommentState {
  final Comment comment;
  
  const CommentGetByIdSuccessState(this.comment);
}

final class CommentGetByIdErrorActionState extends CommmentActionState {
  final String message;
  
  const CommentGetByIdErrorActionState(this.message);
}

final class CommentAddingState extends CommentLoadingState {}

final class CommentAddedSuccessState extends CommmentActionState {
  final Comment comment;
  
  const CommentAddedSuccessState(this.comment);
}

final class CommentAddedErrorActionState extends CommmentActionState {
  final String message;
  
  const CommentAddedErrorActionState(this.message);
}

final class CommentUpdatingState extends CommentLoadingState {}

final class CommentUpdatedSuccessState extends CommmentActionState {
  final Comment comment;
  
  const CommentUpdatedSuccessState(this.comment);
}

final class CommentUpdatedErrorActionState extends CommmentActionState {
  final String message;
  
  const CommentUpdatedErrorActionState(this.message);
}

final class CommentDeletingState extends CommentLoadingState {}

final class CommentDeletedSuccessState extends CommmentActionState {}

final class CommentDeletedErrorActionState extends CommmentActionState {
  final String message;
  
  const CommentDeletedErrorActionState(this.message);
}

final class CommentNavigateToAddActionState extends CommmentActionState {}

final class CommentNavigateToUpdateActionState extends CommmentActionState {
  final String id;
  
  const CommentNavigateToUpdateActionState(this.id);
}

final class CommentNavigateToDeleteActionState extends CommmentActionState {
  final String id;
  
  const CommentNavigateToDeleteActionState(this.id);
}

final class CommentNavigateBackActionState extends CommmentActionState {}