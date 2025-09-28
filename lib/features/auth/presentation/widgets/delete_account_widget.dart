import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/widgets/dialogs/confirmation_dialog.dart';
import '../cubits/delete_account/delete_account_cubit.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          // يمكن إضافة navigation هنا للعودة لصفحة تسجيل الدخول
        } else if (state is DeleteAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed:
              state is DeleteAccountLoading
                  ? null
                  : () => _showDeleteConfirmationDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child:
              state is DeleteAccountLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : const Text(
                    'حذف الحساب',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => ConfirmationDialog(
            alertMsg:
                'هل أنت متأكد من رغبتك في حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه.',
            onTapConfirm: () {
              Navigator.of(context).pop();
              context.read<DeleteAccountCubit>().deleteAccount();
            },
          ),
    );
  }
}
