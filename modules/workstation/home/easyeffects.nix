{
  ...
}:

{

  services.easyeffects = {
    enable = true;

    # Load the input preset automatically
    preset = "noise-cancel";

    # Declarative preset definition
    extraPresets = {
      noise-cancel = {
        input = {
          blocklist = [ ];
          plugins_order = [ "rnnoise#0" ];

          "rnnoise#0" = {
            bypass = false;
            enable-vad = true;
            "input-gain" = 0.0;
            "output-gain" = 0.0;
            "model-path" = "";
            release = 20.0;
            "vad-thres" = 50.0;
            wet = 0.0;
          };
        };
      };
    };
  };

}
