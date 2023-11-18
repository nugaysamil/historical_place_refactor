class Onboard {
  final String image;
  final String title;
  final String description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> data = [
  Onboard(
      image:
          'https://lottie.host/6fa07390-9b88-474f-961b-657b6e334119/yez2N92fNw.json',
      title: 'dil',
      description: 'dil_description'),
  Onboard(
    image:
        'https://lottie.host/8bccaed5-a4fc-4b83-ba8b-946ae3a9b44c/6jN6ELICFl.json',
    title: 'about_us',
    description: 'abouts_us_description',
  ),
  Onboard(
    image:
        'https://lottie.host/00b62ff4-c794-441a-a67d-69a4e8131e3f/xj1fLsOsfD.json',
    title: 'create_account',
    description: 'create_account_description',
  )
];
