_: {
  programs.mpv = {
    enable = true;

    bindings = {
      "Alt+l" = "cycle loop-playlist";
    };

    config = {
      autofit-larger = "95%x95%";
      geometry = "50%:70%";
    };
  };
}
