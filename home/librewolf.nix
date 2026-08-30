{
  config,
  pkgs,
  ...
}: let
  shimmer = pkgs.fetchFromGitHub {
    owner = "nuclearcodecat";
    repo = "shimmer";
    rev = "c346a37";
    sha256 = "sha256-z3yEiKFkuQNOzdaAt7vGsB3V/7XgcaFN48uihjSFoz8=";
  };

  colors = config.lib.stylix.colors;
  hex = name: "#${colors.${name}}";

  patchCss = content:
    builtins.replaceStrings
    [
      "#f7e617" # starred bookmark fill
      "#000" # starred bookmark stroke/shadow
      "#aaa" # urlbar separator line / newtab footer text
      "#fc5753" # macOS traffic light: close (red)
      "#fdbc40" # macOS traffic light: minimize (yellow)
      "#33c748" # macOS traffic light: maximize (green)
    ]
    [
      (hex "base0B")
      (hex "base00")
      (hex "base04")
      (hex "base09")
      (hex "base0F")
      (hex "base0E")
    ]
    content;

  # browser chrome: toolbar, urlbar, popups, tab groups, scrollbars
  extraOverrides = ''
    :root {
      --toolbar-background-color: ${hex "base01"} !important;
      --toolbar-field-background-color: ${hex "base02"} !important;
      --toolbar-field-border-color: ${hex "base04"} !important;
      --arrowpanel-background: ${hex "base02"} !important;
      --lwt-text-color: ${hex "base05"} !important;
      --lwt-accent-color: ${hex "base01"} !important;

      /* tab group swatches */
      --color-blue-50: ${hex "base0D"} !important;
      --color-purple-50: ${hex "base0C"} !important;
      --color-cyan-50: ${hex "base08"} !important;
      --color-orange-50: ${hex "base09"} !important;
      --color-yellow-50: ${hex "base0F"} !important;
      --color-pink-50: ${hex "base0B"} !important;
      --color-green-50: ${hex "base0E"} !important;
      --color-red-50: ${hex "base0A"} !important;

      scrollbar-color: ${hex "base04"} ${hex "base01"} !important;
    }

    #urlbar[focused] .urlbar-background {
      border-color: ${hex "base03"} !important;
    }
  '';

  # new tab page
  newtabOverrides = ''
    :root {
      --newtab-background-color: ${hex "base02"} !important;
    }
    body.activity-stream, .activity-stream {
      background-color: ${hex "base02"} !important;
    }
    html {
      scrollbar-color: ${hex "base04"} ${hex "base00"} !important;
    }
  '';
  # This is for if you want to change the repo to my patched version
  # better to use the offical becuase it might be updated
  # stylixVars = ''
  #   :root {
  #     --sx-base00: #${colors.base00};
  #     --sx-base01: #${colors.base01};
  #     --sx-base02: #${colors.base02};
  #     --sx-base03: #${colors.base03};
  #     --sx-base04: #${colors.base04};
  #     --sx-base05: #${colors.base05};
  #     --sx-base06: #${colors.base06};
  #     --sx-base07: #${colors.base07};
  #     --sx-base08: #${colors.base08};
  #     --sx-base09: #${colors.base09};
  #     --sx-base0A: #${colors.base0A};
  #     --sx-base0B: #${colors.base0B};
  #     --sx-base0C: #${colors.base0C};
  #     --sx-base0D: #${colors.base0D};
  #     --sx-base0E: #${colors.base0E};
  #     --sx-base0F: #${colors.base0F};
  #   }
  # '';
in {
  programs.librewolf = {
    enable = true;
    profiles.byte = {
      id = 0;
      isDefault = true;
      path = "default";
      extensions.force = true;

      settings = {
        ui.systemUsesDarkTheme = 1;
        toolkit.legacyUserProfileCustomizations.stylesheets = true;
        svg.context-properties.content.enabled = true;
        browser.urlbar.scotchBonnet.enableOverride = false;
        sidebar.revamp = false;
        extensions.autoDisableScopes = 0; # firfox colors needs to be automaticly on
      };
      userChrome = patchCss (builtins.readFile "${shimmer}/userChrome.css") + "\n" + extraOverrides;
      userContent = patchCss (builtins.readFile "${shimmer}/userContent.css") + "\n" + newtabOverrides;
    };

    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      darkreader
      sidebery
    ];
  };

  home.file.".librewolf/default/chrome/assets" = {
    source = "${shimmer}/assets";
    recursive = true;
  };
}
