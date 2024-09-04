// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Demo Structure`
  String get applicationTitle {
    return Intl.message(
      'Flutter Demo Structure',
      name: 'applicationTitle',
      desc: '',
      args: [],
    );
  }

  /// `The connection has timed out. Please try again`
  String get connectionTimedOut {
    return Intl.message(
      'The connection has timed out. Please try again',
      name: 'connectionTimedOut',
      desc: '',
      args: [],
    );
  }

  /// `There are some problems with the connection. Please try again`
  String get connectionProblem {
    return Intl.message(
      'There are some problems with the connection. Please try again',
      name: 'connectionProblem',
      desc: '',
      args: [],
    );
  }

  /// `Invalid credentials`
  String get invalidCredentials {
    return Intl.message(
      'Invalid credentials',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Geofencing`
  String get geofencing {
    return Intl.message(
      'Geofencing',
      name: 'geofencing',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Count Task`
  String get countTask {
    return Intl.message(
      'Count Task',
      name: 'countTask',
      desc: '',
      args: [],
    );
  }

  /// `All Posts`
  String get allPosts {
    return Intl.message(
      'All Posts',
      name: 'allPosts',
      desc: '',
      args: [],
    );
  }

  /// `All Post Demo`
  String get allPostDemo {
    return Intl.message(
      'All Post Demo',
      name: 'allPostDemo',
      desc: '',
      args: [],
    );
  }

  /// `All Post Demo GetX`
  String get allPostDemoGetx {
    return Intl.message(
      'All Post Demo GetX',
      name: 'allPostDemoGetx',
      desc: '',
      args: [],
    );
  }

  /// `All post demo provider`
  String get allPostDemoProvider {
    return Intl.message(
      'All post demo provider',
      name: 'allPostDemoProvider',
      desc: '',
      args: [],
    );
  }

  /// `All Post provider`
  String get allPostProvider {
    return Intl.message(
      'All Post provider',
      name: 'allPostProvider',
      desc: '',
      args: [],
    );
  }

  /// `Custom Animation`
  String get customAnimation {
    return Intl.message(
      'Custom Animation',
      name: 'customAnimation',
      desc: '',
      args: [],
    );
  }

  /// `Custom Animation Demo`
  String get customAnimationDemo {
    return Intl.message(
      'Custom Animation Demo',
      name: 'customAnimationDemo',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
