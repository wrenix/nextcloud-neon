import 'package:flutter/material.dart';
import 'package:neon_framework/models.dart';
import 'package:neon_framework/theme.dart';
import 'package:neon_framework/utils.dart';
import 'package:neon_framework/widgets.dart';
import 'package:nextcloud/dashboard.dart' as dashboard;

/// A single item in the dashboard widget.
class DashboardWidgetItem extends StatelessWidget {
  /// Creates a new dashboard widget item.
  const DashboardWidgetItem({
    required this.item,
    required this.roundIcon,
    super.key,
  });

  /// The dashboard widget item to be displayed.
  final dashboard.WidgetItem item;

  /// Whether the leading icon should have round corners.
  final bool roundIcon;

  @override
  Widget build(BuildContext context) {
    Widget leading = SizedBox.square(
      dimension: largeIconSize,
      child: NeonImageWrapper(
        borderRadius: roundIcon ? BorderRadius.circular(largeIconSize) : null,
        child: item.iconUrl.isNotEmpty
            ? NeonUriImage(
                uri: Uri.parse(item.iconUrl),
                size: const Size.square(largeIconSize),
                account: NeonProvider.of<Account>(context),
              )
            : Icon(
                AdaptiveIcons.question_mark,
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );

    final overlayIconUrl = item.overlayIconUrl;
    if (overlayIconUrl.isNotEmpty) {
      leading = Stack(
        children: [
          leading,
          SizedBox.square(
            dimension: largeIconSize,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox.square(
                dimension: smallIconSize,
                child: NeonUriImage(
                  uri: Uri.parse(overlayIconUrl),
                  size: const Size.square(smallIconSize),
                  account: NeonProvider.of<Account>(context),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return ListTile(
      title: Text(
        item.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        item.subtitle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      leading: leading,
      onTap: item.link.isNotEmpty ? () async => launchUrl(NeonProvider.of<Account>(context), item.link) : null,
    );
  }
}
