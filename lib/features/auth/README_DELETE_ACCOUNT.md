# وظيفة حذف الحساب - Delete Account Feature

## نظرة عامة

تم إضافة وظيفة حذف الحساب باتباع Clean Architecture في تطبيق Ballaghny Al-Islam.

## البنية المتبعة (Clean Architecture)

### 1. Data Layer

- **Remote Data Source**: `AuthRemoteDataSource.deleteAccount()`
- **Repository Implementation**: `AuthRepositoryImpl.deleteAccount()`

### 2. Domain Layer

- **Repository Interface**: `AuthRepository.deleteAccount()`
- **Use Case**: `DeleteAccount`

### 3. Presentation Layer

- **Cubit**: `DeleteAccountCubit`
- **States**: `DeleteAccountState` (Initial, Loading, Success, Error)
- **Widget**: `DeleteAccountWidget`

## كيفية الاستخدام

### في UI:

```dart
// إضافة BlocProvider في الشجرة
BlocProvider(
  create: (context) => sl<DeleteAccountCubit>(),
  child: DeleteAccountWidget(),
)

// أو استخدام مباشر
context.read<DeleteAccountCubit>().deleteAccount();
```

### في Dependency Injection:

تم تسجيل جميع المكونات تلقائياً في `auth_injection_container.dart`

## API Endpoint

```
POST /api/v1/customers/delete
```

## الاستجابة المتوقعة

```json
{
  "status": true,
  "message": "تم حذف الحساب بنجاح"
}
```

## الميزات

- ✅ تأكيد قبل الحذف
- ✅ معالجة حالات التحميل
- ✅ رسائل خطأ واضحة
- ✅ تنظيف البيانات المحلية بعد الحذف
- ✅ اتباع Clean Architecture

## ملاحظات مهمة

- هذه العملية لا يمكن التراجع عنها
- يجب التأكد من تسجيل الخروج من جميع الأجهزة
- يجب حذف البيانات المحلية بعد نجاح العملية
