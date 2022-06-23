class LangData {
  const LangData({
    required this.translationPath,
    required this.supplementaryPath,
  });

  const LangData.locale(String locale)
      : this(
          supplementaryPath: 'data/supplementary_data/$locale.yaml',
          translationPath: 'data/translation_data/$locale.json',
        );

  final String translationPath;
  final String supplementaryPath;
}
