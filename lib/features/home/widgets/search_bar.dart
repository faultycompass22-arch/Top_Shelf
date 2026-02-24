// lib/features/home/widgets/search_bar.dart
import 'package:flutter/material.dart';
import '../../../theme/tokens.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.initialValue = '',
  });

  final ValueChanged<String> onChanged;
  final String initialValue;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _c;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textMuted),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _c,
                onChanged: widget.onChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search strain, scent, type…',
                  hintStyle: TextStyle(color: AppColors.textMuted),
                ),
              ),
            ),
            if (_c.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textMuted),
                onPressed: () {
                  _c.clear();
                  widget.onChanged('');
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}