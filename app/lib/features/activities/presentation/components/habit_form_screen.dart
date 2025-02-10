import 'package:flutter/material.dart';

class HabitFormScreen extends StatelessWidget {
  const HabitFormScreen({
    super.key,
    this.enabled = true,
    this.titleController,
    this.maxGapDaysController,
    this.title,
    this.onConfirm,
    this.onCancel,
  });

  final TextEditingController? titleController;
  final TextEditingController? maxGapDaysController;
  final String? title;
  final bool enabled;
  final void Function()? onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? 'Форма привычки',
            style: TextTheme.of(context).headlineSmall,
          ),
          const SizedBox(height: 16),
          TextField(
            enabled: enabled,
            decoration: InputDecoration(
              label: Text('Название привычки'),
            ),
            controller: titleController,
          ),
          const SizedBox(height: 12),
          TextField(
            enabled: enabled,
            decoration: InputDecoration(
              label: Text(
                'Допустимый перерыв (Дни)',
              ),
            ),
            controller: maxGapDaysController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 4),
          Text(
            'Допустимый перерыв между активностями для стрика в днях',
            style: textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: enabled ? onCancel : null,
                  style: ButtonStyle(
                    backgroundColor: enabled
                        ? WidgetStatePropertyAll(ColorScheme.of(context).error)
                        : null,
                  ),
                  child: Text('Отмена'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: enabled ? onConfirm : null,
                  child: Text('Подтвердить'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
