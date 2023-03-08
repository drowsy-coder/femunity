enum ThemeMode {
  light,
  dark,
}

enum UserKarma {
  comment(2),
  textPost(3),
  linkPost(4),
  imagePost(5),
  deletePost(-1);

  final int karma;
  const UserKarma(this.karma);
}
