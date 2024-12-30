import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/repositories/contracts/abs_api_comment_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../../models/comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AbsApiCommentRepository _apiCommentRepository;
  List<Comment> _comments = [];
  CommentBloc(this._apiCommentRepository) : super(CommentInitial()) {
    on<CommentLoadEvent>(commentLoadEvent);
    on<CommentAddEvent>(commentAddEvent);
    on<CommentDeleteEvent>(commentDeleteEvent);
    on<CommentUpdateEvent>(commentUpdateEvent);
    on<CommentNavigateToAddEvent>(commentNavigateToAddEvent);
    on<CommentNavigateToUpdateEvent>(commentNavigateToUpdateEvent);
    on<CommentNavigateToDeleteEvent>(commentNavigateToDeleteEvent);
    on<CommentNavigateBackEvent>(commentNavigateBackEvent);
  }

  List<Comment> get comments => _comments;

  Comment? getCommentById(String commentId) => _comments.firstWhereOrNull((comment) => comment.id == commentId);

  FutureOr<void> commentLoadEvent(CommentLoadEvent event, Emitter<CommentState> emit) async {
    emit(CommentGetLoadingState());
    try {
      _comments = await _apiCommentRepository.getAll();
      emit(CommentLoadedSuccessState(_comments));
    } catch (e) {
      log(e.toString(), name: 'CommentBloc:commentLoadEvent');
      emit(const CommentLoadErrorActionState('Failed to load comments.'));
    }
  }

  FutureOr<void> commentAddEvent(CommentAddEvent event, Emitter<CommentState> emit) async {
    emit(CommentAddingState());
    try {
      final newAddedComment = await _apiCommentRepository.create(event.newComment);
      if (newAddedComment != null) {
        _comments.add(newAddedComment);
        emit(CommentAddedSuccessState(event.newComment));
      } else {
        emit(const CommentAddedErrorActionState('Failed to add comment.'));
      }
    } catch (e) {
      emit(CommentAddedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentUpdateEvent(CommentUpdateEvent event, Emitter<CommentState> emit) async {
    emit(CommentUpdatingState());
    try {
      final existingComment = getCommentById(event.updatedComment.id!);
      if (existingComment != null) {
        final isUpdated = await _apiCommentRepository.update(event.updatedComment);
        if (isUpdated) {
          _comments[_comments.indexOf(existingComment)] = event.updatedComment;
          emit(CommentUpdatedSuccessState(event.updatedComment));
        } else {
          emit(const CommentUpdatedErrorActionState('Failed to update comment.'));
        }
      } else {
        emit(const CommentUpdatedErrorActionState('Comment not found.'));
      }
    } catch (e) {
      emit(CommentUpdatedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentDeleteEvent(CommentDeleteEvent event, Emitter<CommentState> emit) async {
    emit(CommentDeletingState());
    try {
      final existingComment = getCommentById(event.id);
      if (existingComment != null) {
        final isDeleted = await _apiCommentRepository.delete(event.id);
        if (isDeleted) {
          _comments.remove(existingComment);
          emit(CommentDeletedSuccessState());
        } else {
          emit(const CommentDeletedErrorActionState('Failed to delete comment.'));
        }
      } else {
        emit(const CommentDeletedErrorActionState('Comment not found.'));
      }
    } catch (e) {
      emit(CommentDeletedErrorActionState(e.toString()));
    }
  }

  FutureOr<void> commentNavigateToAddEvent(CommentNavigateToAddEvent event, Emitter<CommentState> emit) {
    emit(CommentNavigateToAddActionState());
  }

  FutureOr<void> commentNavigateToUpdateEvent(CommentNavigateToUpdateEvent event, Emitter<CommentState> emit) {
    emit(CommentNavigateToUpdateActionState(event.id));
  }

  FutureOr<void> commentNavigateToDeleteEvent(CommentNavigateToDeleteEvent event, Emitter<CommentState> emit) {
    emit(CommentNavigateToDeleteActionState(event.id));
  }

  FutureOr<void> commentNavigateBackEvent(CommentNavigateBackEvent event, Emitter<CommentState> emit) {
    emit(CommentNavigateBackActionState());
  }
}