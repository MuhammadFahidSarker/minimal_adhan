import 'package:flutter/material.dart';

abstract class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;

  const SettingsTile(
    this.title,
    this.subtitle,
    this.leading,
  );

}



class SettingsClickable extends SettingsTile {
  final void Function() onClick;
  final Widget? trailing;
  final bool selected;

  const SettingsClickable(
      {required this.onClick,
      required String title, String? subtitle,
      Widget? leading,
      this.trailing, this.selected = false})
      : super(title, subtitle, leading);

  @override
  Widget build(BuildContext context) {


    return ListTile(
      leading: leading,
      onTap: onClick,
      trailing: trailing,
      title: Text(title),
      selected: selected,
      subtitle: subtitle != null ? Text(subtitle!) : null,
    );
  }
}

class SettingsToggle extends SettingsTile {
  final void Function(bool)? onToggle;
  final bool value;
  @override
  final String? subtitle;

  const SettingsToggle(
      {required this.onToggle,
      required String title,
      required this.value,
      Icon? leading,
      this.subtitle})
      : super(title, null, leading);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onToggle,
      title: Text(title),
      secondary: leading,
      subtitle: subtitle != null ? Text(subtitle!) : null,
    );
  }
}
