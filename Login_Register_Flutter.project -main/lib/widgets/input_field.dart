import 'package:flutter/material.dart';
import '../main.dart' show appTextMain, appTextSecondary;

/// Reusable text form field used across Login and Register pages.
///
/// When [obscureText] is true the widget converts itself into a
/// [StatefulWidget] internally via [_InputFieldState] and renders a
/// show/hide suffix icon — no changes required at call sites.
class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _hidden; // tracks current visibility for password fields

  @override
  void initState() {
    super.initState();
    _hidden = widget.obscureText; // start hidden only when obscureText=true
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _hidden,
      keyboardType: widget.keyboardType,
      style: const TextStyle(fontSize: 15, color: appTextMain),
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.prefixIcon),
        // ── Show/hide toggle — only rendered for password fields ──────────
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _hidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: appTextSecondary,
                ),
                splashRadius: 18,
                onPressed: () => setState(() => _hidden = !_hidden),
                tooltip: _hidden ? 'Show password' : 'Hide password',
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
