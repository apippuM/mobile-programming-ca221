import 'package:flutter/material.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/pages/comment_page.dart';
import 'package:myapp/resources/dimentions.dart';
import 'package:myapp/widgets/post_action.dart';
import 'package:myapp/widgets/post_title.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key, 
    required this.moment,
    required this.onUpdate,
    required this.onDelete,});

  final Moment moment;
  final Function(String id) onUpdate;
  final Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: largeSize,
          vertical: mediumSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: DecorationImage(
            // image: AssetImage('assets/images/moments_background_dark.png'),
            image: NetworkImage(moment.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostTitle(
              moment: moment,
              onUpdate: onUpdate,
              onDelete: onDelete
              ),
            Padding(
              padding: const EdgeInsets.all(smallSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      PostAction(
                        icon: 'assets/icons/fi-br-heart.svg',
                        label: moment.likeCount.toString(),
                        onTap: () {

                        },
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-comment.svg',
                        label: moment.commentCount.toString(),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return CommentPage(id: moment.id, onUpdate: onUpdate, onDelete: onDelete);
                          }));
                        },
                      ),
                      PostAction(
                        icon: 'assets/icons/fi-br-bookmark.svg',
                        label: moment.bookmarkCount.toString(),
                        onTap: () {

                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: largeSize, bottom: smallSize),
                    child: Text(
                      moment.caption,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
