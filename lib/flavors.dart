enum AppFlavor {
  dev,
  prod,
}

class Flavor {
  static AppFlavor appFlavor = AppFlavor.dev;

  static String get baseUrl {
    switch (appFlavor) {
      case AppFlavor.dev:
        return '';
      case AppFlavor.prod:
        return '';
    }
  }

  static String get flavorName {
    switch (appFlavor) {
      case AppFlavor.dev:
        return 'Live Session App';
      case AppFlavor.prod:
        return 'Live Session App';
    }
  }
}
