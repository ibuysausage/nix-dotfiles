{ config, pkgs, ... }:

{
  systemd.timers."nightly-suspend" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 23:00:00";
      Persistent = true;
    };
  };

  systemd.services."nightly-suspend" = {
    description = "Suspend the system nightly";
    serviceConfig.Type = "oneshot";
    script = "${pkgs.systemd}/bin/systemctl suspend";
  };

  systemd.timers."morning-wake" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 05:00:00";
      Persistent = true;
      WakeSystem = true;
    };
  };

  systemd.services."morning-wake" = {
    description = "Wake-up marker service";
    serviceConfig.Type = "oneshot";
    script = "${pkgs.coreutils}/bin/echo 'Woke up at 5 AM'";
  };
}
