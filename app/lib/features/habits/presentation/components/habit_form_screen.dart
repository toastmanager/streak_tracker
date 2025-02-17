import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class HabitFormScreen extends StatelessWidget {
  const HabitFormScreen({
    super.key,
    this.enabled = true,
    this.formKey,
    this.titleController,
    this.maxGapDaysController,
    this.title,
    this.errorMessage,
    this.onConfirm,
    this.onCancel,
  });

  final TextEditingController? titleController;
  final TextEditingController? maxGapDaysController;
  final GlobalKey<FormBuilderState>? formKey;
  final String? title;
  final String? errorMessage;
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
          FormBuilderTextField(
            name: 'name',
            enabled: enabled,
            decoration: InputDecoration(
              label: Text('Название привычки'),
            ),
            controller: titleController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(3),
            ]),
          ),
          const SizedBox(height: 12),
          FormBuilderTextField(
            name: 'maxGapDays',
            enabled: enabled,
            decoration: InputDecoration(
              label: Text(
                'Допустимый перерыв (Дни)',
              ),
            ),
            controller: maxGapDaysController,
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.integer(),
              FormBuilderValidators.min(0),
            ]),
          ),
          const SizedBox(height: 4),
          Text(
            'Допустимый перерыв между активностями для стрика в днях',
            style: textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          if (errorMessage != null && errorMessage != "") ...[
            const SizedBox(height: 8),
            Text(
              errorMessage!,
              style: textTheme.bodyMedium?.copyWith(color: colors.error),
            )
          ],
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
                  onPressed: enabled
                      ? () {
                          if ((formKey?.currentState?.saveAndValidate() ??
                                  true) &&
                              onConfirm != null) {
                            onConfirm!();
                          }
                        }
                      : null,
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
