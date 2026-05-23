{
  config,
  ...
}:

{
  sops = {
    secrets = {
      "mcaptcha/salt" = {};
      "mcaptcha/cookie_secret" = {};
    };

    templates."mcaptcha.env" = {
      # owner = "mcaptcha";
      # group = "mcaptcha";
      content = ''
        MCAPTCHA_debug=false
        MCAPTCHA_commercial=false
        MCAPTCHA_source_code=https://github.com/mCaptcha/mCaptcha
        MCAPTCHA_allow_registration=false
        MCAPTCHA_allow_demo=false

        DATABASE_URL=postgres://mcaptcha@postgres:5432/mcaptcha
        MCAPTCHA_database_POOL=4

        MCAPTCHA_redis_URL=redis://127.0.0.1:6001
        MCAPTCHA_redis_POOL=4

        PORT=7000
        MCAPTCHA_server_DOMAIN=captcha.lunya.pet
        MCAPTCHA__server_COOKIE_SECRET=${config.sops.placeholder."mcaptcha/cookie_secret"}
        MCAPTCHA__server_IP= 0.0.0.0

        MCAPTCHA_captcha_SALT=${config.sops.placeholder."mcaptcha/salt"}
        MCAPTCHA_captcha_GC=30
        MCAPTCHA_captcha_RUNNERS=4
        MCAPTCHA_captcha_QUEUE_LENGTH=2000
        MCAPTCHA_captcha_ENABLE_STATS=true
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_avg_traffic_difficulty=50000
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_peak_sustainable_traffic_difficulty=3000000
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_broke_my_site_traffic_difficulty=5000000
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_duration=30
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_avg_traffic_time=1
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_peak_sustainable_traffic_time=3
        MCAPTCHA_captcha_DEFAULT_DIFFICULTY_STRATEGY_broke_my_site_traffic_time=5
      '';
    };
  };

  # users.groups.mcaptcha = {};
  # users.users.mcaptcha = {
  #   isSystemUser = true;
  #   group = "mcaptcha";
  # };

  # services.redis.servers."mcaptcha" = {
  #   enable = true;
  #   user = "mcaptcha";
  # };

  # Install mCaptcha in a container as I'm not making a derivation

  virtualisation.oci-containers.containers = {
    mcaptcha = {
      image = "mcaptcha/mcaptcha:latest";
      environmentFiles = [
        config.sops.templates."mcaptcha.env".path
      ];
    };
    mcaptcha_redis = {
      image = "mcaptcha/cache:latest";
    };
  };
}
