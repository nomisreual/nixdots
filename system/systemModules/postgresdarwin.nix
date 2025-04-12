let
  dataDir = "/var/lib/postgresql/17";
  logDir = "/var/log/postgresql";
  user = "simon";
  port = 5432;
in
  {
    config,
    pkgs,
    ...
  }: {
    services = {
      postgresql = {
        inherit dataDir port;
        enable = true;
        package = pkgs.postgresql_17;
        initdbArgs = ["-D" dataDir];
      };
    };

    users = {
      knownUsers = ["postgres"];
      users = {
        postgres = {
          shell = "/bin/bash";
          uid = 1001;
        };
      };
    };

    # Create the PostgreSQL data directory, if it does not exist.
    system.activationScripts.preActivation = {
      enable = true;
      text = ''
        if [ ! -d "${dataDir}" ]; then
          echo "creating PostgreSQL data directory..."
          sudo mkdir -m 700 -p "${dataDir}/"
          chown -R ${user}:staff "${dataDir}/"
        fi

        if [ ! -d "/var/log/postgresql" ]; then
          echo "creating PostgreSQL log directory..."
          sudo mkdir -m 700 -p "${logDir}/"
          chown -R ${user}:staff "${logDir}/"
        fi
      '';
    };

    launchd.user.agents.postgresql.serviceConfig = {
      StandardErrorPath = "${logDir}/postgres.error.log";
      StandardOutPath = "${logDir}/postgres.out.log";
    };
  }
