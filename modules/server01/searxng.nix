{...}: {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
  };
}
