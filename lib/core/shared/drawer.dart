import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppDrawer extends StatelessWidget {
  final Widget body;
  const AppDrawer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const _DrawerHeader(),

            const SizedBox(height: 8),

            body,

            Divider(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(50),),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DrawerItem(
                icon: Icons.settings_outlined,
                title: "Settings", onTap: () {  },
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colors.primary,
            ),
            child: const Center(
              child: Icon(
                LucideIcons.stethoscope,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                const TextSpan(text: 'EG'),
                TextSpan(
                  text: 'healthcare',
                  style: TextStyle(color:colors.primary,
                      fontWeight:FontWeight.bold ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final void Function() onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? colors.primary.withAlpha(20) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(

          icon,
          color: isActive ? colors.primary : colors.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: isActive ? colors.primary : colors.onSurface,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap:onTap,
      ),
    );
  }
}

