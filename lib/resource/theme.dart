import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get theme {
    var typography = Typography.material2021(platform: defaultTargetPlatform);
    var textTheme = typography.black.apply(
      fontFamily: 'Poppins',
      bodyColor: Colors.black,
      displayColor: Colors.black,
    );

    var titleLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins',
      color: Colors.black,
      height: 34 / 24,
      letterSpacing: 0,
    ); //done

    var titleMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      height: 20 / 14,
      color: Colors.black,
      letterSpacing: 0,
    ); //done

    var titleSmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      height: 17 / 14,
      color: Colors.black,
      letterSpacing: 0,
    ); //done

    var labelLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      height: 1,
      color: Colors.black,
      letterSpacing: 0,
    ); //done

    var labelSmall = const TextStyle(
      fontSize: 10,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      height: 15 / 12,
      color: MyColors.primaryColor,
      letterSpacing: 0,
    ); //done

    var bodyLarge = const TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 1,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    );

    var bodyMedium = TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1,
      color: Colors.black.withOpacity(0.7),
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    );

    var bodySmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      letterSpacing: 0,
      color: Colors.black,
    ); //done

    var headlineMedium = const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 32 / 24,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    ); //done

    var headlineSmall = const TextStyle(
      fontSize: 30,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 38 / 30,
      color: Colors.black,
      letterSpacing: 0,
      fontStyle: FontStyle.normal,
    ); //done

    var displaySmall = const TextStyle(
      fontSize: 10,
      fontFamily: 'OutFit',
      fontWeight: FontWeight.w600,
      height: 1.1,
      color: MyColors.primaryColor,
      letterSpacing: 0,
      fontStyle: FontStyle.normal,
    );

    textTheme = textTheme.copyWith(
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelSmall: labelSmall,
      displaySmall: displaySmall,
    );

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: MyColors.border, width: 1),
    );

    return ThemeData(
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: primaryColor.withOpacity(0.3),
        selectionHandleColor: primaryColor,
      ),
      primaryColor: primaryColor,
      indicatorColor: primaryColor,
      canvasColor: Colors.white,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      typography: typography,
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
      ),
      appBarTheme: AppBarTheme(
        elevation: 4,
        shadowColor: Colors.black26,
        titleSpacing: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        titleTextStyle: titleSmall.copyWith(
          color: Colors.black,
          fontSize: 16,
          height: 1.5,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        buttonColor: primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: labelLarge.copyWith(fontWeight: FontWeight.w500),
          fixedSize: const Size(140, 50),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MyColors.primaryColor,
          padding: EdgeInsets.zero,
          textStyle: titleMedium.copyWith(fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: MyColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(width: 1, color: MyColors.primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: labelLarge,
          fixedSize: const Size(140, 50),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: MyColors.divider, width: 1),
        ),
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        iconSize: 22,
        elevation: 0,
        disabledElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        filled: false,
        hintStyle: bodySmall.copyWith(
          color: Colors.black.withOpacity(0.6),
          fontSize: 14,
        ),
        labelStyle: titleSmall.copyWith(
          color: Colors.black.withOpacity(0.7),
          fontSize: 12,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      iconTheme: const IconThemeData(color: Colors.black, size: 24),
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        // color: MyColors.divider,
      ),
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1, color: MyColors.primaryColor),
        ),
        checkColor: WidgetStateProperty.all(MyColors.primaryColor),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return const Color(0xFFFFFFFF);
        }),
        overlayColor: WidgetStateProperty.all(const Color(0xFFFFFFFF)),
      ),
      radioTheme: RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          } else {
            return const Color(0xFFB5B5B5);
          }
        }),
      ).copyWith(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return MyColors.primaryColor;
          }
          return null;
        }),
        trackColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return MyColors.primaryColor;
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        backgroundColor: const Color(0x10E8E8E8),
        disabledColor: Colors.grey,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        padding: const EdgeInsets.all(10),
        labelStyle: bodyLarge.copyWith(height: 1.2, color: Colors.black),
        showCheckmark: false,
        secondaryLabelStyle: bodyLarge.copyWith(
          height: 1.2,
          color: Colors.white,
        ),
        brightness: Brightness.light,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        activeTickMarkColor: primaryColor,
        thumbColor: primaryColor,
        inactiveTrackColor: primaryColor.withOpacity(.2),
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: MyColors.primaryColor,
        indicatorColor: MyColors.primaryColor,
        unselectedLabelColor: Colors.black.withOpacity(0.7),
        labelStyle: titleLarge.copyWith(
          fontWeight: FontWeight.w700,
          color: MyColors.primaryColor,
          fontSize: 13,
        ),
        unselectedLabelStyle: titleLarge.copyWith(
          fontWeight: FontWeight.w700,
          color: MyColors.primaryColor.withOpacity(0.6),
          fontSize: 13,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        onSecondary: Colors.white,
        brightness: Brightness.light,
        surface: Colors.white,
      ).copyWith(surface: Colors.white),
    );
  }

  static Color primaryColor = MyColors.primaryColor;
}
