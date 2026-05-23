{...}:

let
  mainDomainName = "lunya.pet";
  theWiredDomainName = "the-wired.club";
in
{
  services.prosody = {
    enable = true;
    admins = [ "lunya@${mainDomainName}" "lain@${theWiredDomainName}" ];
    allowRegistration = false;
    authentication = "internal_plain";
    s2sSecureAuth = true;
    c2sRequireEncryption = true;
    modules = {
      disco = true;
      roster = true;
      saslauth = true;
      tls = true;
      http_files = true;
      blocklist = true;
      bookmarks = true;
      carbons = true;
      limits = true;
      pep = true;
      private = true;
      smacks = true;
      vcard = true;
      vcard_legacy = true;
      cloud_notify = true;
      csi = true;
      invites = true;
      invites_adhoc = true;
      invites_register = true;
      ping = true;
      time = true;
      uptime = true;
      version = true;
      mam = true;
      admin_adhoc = true;
      groups = true;
      mimicking = true;
      motd = true;
      s2s_bidi = true;
      tombstones = true;
      watchregistrations = true;
      welcome = true;
      http_file_share = true;
      muc = true;
    };

    xmppComplianceSuite = true;

    muc = [
      {
        domain = "muc.${mainDomainName}";
        restrictRoomCreation = false;
      }
      {
        domain = "muc.${theWiredDomainName}";
        restrictRoomCreation = false;
      }
    ];

    extraConfig = ''
      limits = {
          c2s = {
              rate = "10kb/s";
          };
          s2sin = {
              rate = "30kb/s";
          };
      }
    '';

    httpPorts = [ 5280 ];
    httpInterfaces = [ "*" "::" ];
    httpFileShare.domain = "xmpp-files.lunya.pet";
  };
}
