import 'package:flutter/material.dart';
import '../../core/constants/theme_constants.dart';

class ChatMessage {
  final String id;
  final String message;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final String? teamColor;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    this.teamColor,
  });
}

class TeamChatWidget extends StatefulWidget {
  final List<ChatMessage> messages;
  final String currentUserId;
  final String teamColor;
  final Function(String message) onSendMessage;
  final bool isLoading;
  final String? error;

  const TeamChatWidget({
    super.key,
    required this.messages,
    required this.currentUserId,
    required this.teamColor,
    required this.onSendMessage,
    this.isLoading = false,
    this.error,
  });

  @override
  State<TeamChatWidget> createState() => _TeamChatWidgetState();
}

class _TeamChatWidgetState extends State<TeamChatWidget> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didUpdateWidget(TeamChatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length != oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(ThemeConstants.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ThemeConstants.radiusLg),
                topRight: Radius.circular(ThemeConstants.radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(int.parse(widget.teamColor)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: ThemeConstants.spacingSm),
                Text(
                  'Team Chat',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),

          // Messages
          Expanded(
            child:
                widget.error != null
                    ? _buildErrorState()
                    : widget.messages.isEmpty
                    ? _buildEmptyState()
                    : _buildMessagesList(),
          ),

          // Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: ThemeConstants.spacingMd),
          Text(
            'Failed to load messages',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingSm),
          Text(
            widget.error!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 48,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: ThemeConstants.spacingMd),
          Text(
            'No messages yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingSm),
          Text(
            'Start the conversation!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(ThemeConstants.spacingMd),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        final isCurrentUser = message.senderId == widget.currentUserId;

        return _buildMessageBubble(message, isCurrentUser);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isCurrentUser) {
    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.spacingSm),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser) ...[
            // Avatar for other users
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(int.parse(widget.teamColor)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  message.senderName.isNotEmpty
                      ? message.senderName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: ThemeConstants.spacingSm),
          ],

          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(ThemeConstants.spacingMd),
              decoration: BoxDecoration(
                color:
                    isCurrentUser
                        ? Color(int.parse(widget.teamColor))
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(
                  ThemeConstants.radiusLg,
                ).copyWith(
                  bottomLeft:
                      isCurrentUser
                          ? Radius.circular(ThemeConstants.radiusLg)
                          : Radius.circular(4),
                  bottomRight:
                      isCurrentUser
                          ? Radius.circular(4)
                          : Radius.circular(ThemeConstants.radiusLg),
                ),
                border: Border.all(
                  color:
                      isCurrentUser
                          ? Colors.transparent
                          : Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message text
                  Text(
                    message.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          isCurrentUser
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  // Timestamp
                  const SizedBox(height: ThemeConstants.spacingXs),
                  Text(
                    _formatTimestamp(message.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          isCurrentUser
                              ? Colors.white.withValues(alpha: 0.7)
                              : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isCurrentUser) ...[
            const SizedBox(width: ThemeConstants.spacingSm),
            // Avatar for current user
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(int.parse(widget.teamColor)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(ThemeConstants.spacingMd),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(ThemeConstants.radiusLg),
          bottomRight: Radius.circular(ThemeConstants.radiusLg),
        ),
      ),
      child: Row(
        children: [
          // Message input field
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(
                    color: Color(int.parse(widget.teamColor)),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ThemeConstants.spacingMd,
                  vertical: ThemeConstants.spacingSm,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          const SizedBox(width: ThemeConstants.spacingSm),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: Color(int.parse(widget.teamColor)),
              borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              tooltip: 'Send message',
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      widget.onSendMessage(message);
      _messageController.clear();
      _focusNode.requestFocus();
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}
