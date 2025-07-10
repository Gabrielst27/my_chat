import 'package:flutter/material.dart';
import 'package:my_chat/widgets/triangle_painter.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.senderName,
    required this.text,
    required this.isMine,
    required this.isFirst,
  });

  final String senderName;
  final String text;
  final bool isMine;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 2, right: 16, left: 16),
          alignment: isMine ? Alignment.topRight : Alignment.topLeft,
          child: Row(
            mainAxisAlignment: isMine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isMine
                        ? Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.primary
                        : Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  child: Column(
                    crossAxisAlignment: isMine
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      isFirst
                          ? Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                senderName,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                    ),
                              ),
                            )
                          : const SizedBox(
                              height: 16,
                            ),
                      Text(
                        text,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isFirst)
          Positioned(
            top: 2,
            left: isMine ? null : 6,
            right: isMine ? 6 : null,
            child: CustomPaint(
              size: const Size(12, 10),
              painter: TrianglePainter(
                isMine: isMine,
                color: Theme.of(context).brightness == Brightness.dark
                    ? isMine
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSecondary
                    : isMine
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
      ],
    );
  }
}
