import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/comment_bloc.dart';
import 'commment_entry_page.dart';

class CommentPage extends StatefulWidget {
  static const routeName = '/comments';
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(CommentLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: BlocConsumer<CommentBloc, CommentState>(
        listener: (context, state) {
          if (state is CommentLoadErrorActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CommentAddedSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Comment added successfully!')),
            );
          } else if (state is CommentNavigateToAddActionState) {
            Navigator.of(context).pushNamed(CommentEntryPage.routeName);
          }
        },
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentLoadedSuccessState) {
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final comment = state.comments[index];
                return ListTile(
                  title: Text(comment.creatorUsername ?? 'Anonymous'),
                  subtitle: Text(comment.content),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                  ),
                  trailing: Text(_dateFormat.format(comment.createdAt)),
                );
              },
            );
          } else if (state is CommentLoadErrorActionState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No comments available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CommentBloc>().add(CommentNavigateToAddEvent());
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
