{
  lib,
  stdenv,
  fetchFromGitHub,
  glib,
  gettext,
  replaceVars,
  gnome-menus,
}:

stdenv.mkDerivation rec {
  pname = "nautilus-backspace";
  version = "1";

  src = fetchFromGitLab {
    owner = "TheWeirdDev";
    repo = "nautilus-backspace";
    rev = "5d20ba25c0178b4358c9e9d52d386b6b9f1d723f";
    hash = "sha256-EEK600DwIQAPWR07IMPNZFiWWkiG0blp/D0VKAcc7ns=";
  };

  patches = [
    (replaceVars ./fix_gmenu.patch {
      gmenu_path = "${gnome-menus}/lib/girepository-1.0";
    })
  ];

  buildInputs = [
    glib
    gettext
  ];

  makeFlags = [ "INSTALLBASE=${placeholder "out"}/share/gnome-shell/extensions" ];

  passthru = {
    extensionUuid = "arcmenu@arcmenu.com";
    extensionPortalSlug = "arcmenu";
  };

  meta = with lib; {
    description = "Application menu for GNOME Shell, designed to provide a more traditional user experience and workflow";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ dkabot ];
    homepage = "https://gitlab.com/arcmenu/ArcMenu";
  };
}