import 'package:flutter/material.dart';
import '../../core/constants/theme_constants.dart';

class GameLogEntry {
  final String message;
  final DateTime timestamp;
  final GameLogType type;
  final String? playerName;
  final String? teamColor;

  const GameLogEntry({
    required this.message,
    required this.timestamp,
    required this.type,
    this.playerName,
    this.teamColor,
  });
}

enum GameLogType { system, player, team, clue, score, gameEvent }

class GameLogWidget extends StatefulWidget {
  final List<GameLogEntry> entries;
  final bool showTimestamp;
  final bool autoScroll;
  final VoidCallback? onRefresh;
  final bool isLoading;

  const GameLogWidget({
    super.key,
    required this.entries,
    this.showTimestamp = true,
    this.autoScroll = true,
    this.onRefresh,
    this.isLoading = false,
  });

  @override
  State<GameLogWidget> createState() => _GameLogWidgetState();
}

class _GameLogWidgetState extends State<GameLogWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.autoScroll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  @override
  void didUpdateWidget(GameLogWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoScroll &&
        widget.entries.length != oldWidget.entries.length) {
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
    _scrollController.dispose();
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
                Icon(
                  Icons.history,
                  size: 20,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                const SizedBox(width: ThemeConstants.spacingSm),
                Text(
                  'Game Log',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.onRefresh != null)
                  IconButton(
                    onPressed: widget.isLoading ? null : widget.onRefresh,
                    icon:
                        widget.isLoading
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Icon(Icons.refresh, size: 20),
                    tooltip: 'Refresh',
                  ),
              ],
            ),
          ),

          // Log Entries
          Expanded(
            child:
                widget.entries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(ThemeConstants.spacingMd),
                      itemCount: widget.entries.length,
                      itemBuilder: (context, index) {
                        final entry = widget.entries[index];
                        return _buildLogEntry(entry);
                      },
                    ),
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
            Icons.history_outlined,
            size: 48,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: ThemeConstants.spacingMd),
          Text(
            'No events yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingSm),
          Text(
            'Game events will appear here',
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

  Widget _buildLogEntry(GameLogEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.spacingSm),
      padding: const EdgeInsets.all(ThemeConstants.spacingMd),
      decoration: BoxDecoration(
        color: _getEntryBackgroundColor(entry.type),
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
        border: Border.all(color: _getEntryBorderColor(entry.type), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _getEntryIconColor(entry.type),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getEntryIcon(entry.type),
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: ThemeConstants.spacingMd),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message
                Text(
                  entry.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _getEntryTextColor(entry.type),
                  ),
                ),

                // Player name and timestamp
                if (entry.playerName != null || widget.showTimestamp) ...[
                  const SizedBox(height: ThemeConstants.spacingXs),
                  Row(
                    children: [
                      if (entry.playerName != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: ThemeConstants.spacingSm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                entry.teamColor != null
                                    ? Color(int.parse(entry.teamColor!))
                                    : Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            entry.playerName!,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  entry.teamColor != null
                                      ? Colors.white
                                      : Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: ThemeConstants.spacingSm),
                      ],
                      if (widget.showTimestamp)
                        Text(
                          _formatTimestamp(entry.timestamp),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getEntryBackgroundColor(GameLogType type) {
    switch (type) {
      case GameLogType.system:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
      case GameLogType.player:
        return Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.3);
      case GameLogType.team:
        return Theme.of(
          context,
        ).colorScheme.secondaryContainer.withValues(alpha: 0.3);
      case GameLogType.clue:
        return Theme.of(
          context,
        ).colorScheme.tertiaryContainer.withValues(alpha: 0.3);
      case GameLogType.score:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
      case GameLogType.gameEvent:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  Color _getEntryBorderColor(GameLogType type) {
    switch (type) {
      case GameLogType.system:
        return Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);
      case GameLogType.player:
        return Theme.of(context).colorScheme.primary.withValues(alpha: 0.3);
      case GameLogType.team:
        return Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3);
      case GameLogType.clue:
        return Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3);
      case GameLogType.score:
        return Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);
      case GameLogType.gameEvent:
        return Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);
    }
  }

  Color _getEntryIconColor(GameLogType type) {
    switch (type) {
      case GameLogType.system:
        return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);
      case GameLogType.player:
        return Theme.of(context).colorScheme.primary;
      case GameLogType.team:
        return Theme.of(context).colorScheme.secondary;
      case GameLogType.clue:
        return Theme.of(context).colorScheme.tertiary;
      case GameLogType.score:
        return Theme.of(context).colorScheme.primary;
      case GameLogType.gameEvent:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color _getEntryTextColor(GameLogType type) {
    switch (type) {
      case GameLogType.system:
        return Theme.of(context).colorScheme.onSurface;
      case GameLogType.player:
        return Theme.of(context).colorScheme.onSurface;
      case GameLogType.team:
        return Theme.of(context).colorScheme.onSurface;
      case GameLogType.clue:
        return Theme.of(context).colorScheme.onSurface;
      case GameLogType.score:
        return Theme.of(context).colorScheme.onSurface;
      case GameLogType.gameEvent:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  IconData _getEntryIcon(GameLogType type) {
    switch (type) {
      case GameLogType.system:
        return Icons.info;
      case GameLogType.player:
        return Icons.person;
      case GameLogType.team:
        return Icons.group;
      case GameLogType.clue:
        return Icons.psychology;
      case GameLogType.score:
        return Icons.star;
      case GameLogType.gameEvent:
        return Icons.event;
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
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
