{
  lib,
  enables ? {
    enabledModules = [];
    enabledTags = [];
    disabledModules = [];
  },
  ...
}: let
  inherit (lib) mkIf mkOption;
  inherit (lib.lists) any elem;
  inherit (lib.types) bool;

  byTag = tags: any (t: elem t enables.enabledTags) tags;

  isEnabledFn = name: tags: (elem name enables.enabledModules || byTag tags) && !(elem name enables.disabledModules);

  mkModule = name: tags: body: {
    options.modules.${name}.enable = mkOption {
      type = bool;
      default = isEnabledFn name tags;
      description = "Enable the ${name} module (tags: ${lib.concatStringsSep ", " tags})";
    };

    # The 'config' attribute is now at the same level as 'options'
    # 'config' is a special keyword that the NixOS module system looks for.
    config = mkIf (isEnabledFn name tags) body;
  };

  # optional utility function
  ternary = a: b: cond:
    if cond
    then a
    else b;
in {
  isEnabled = isEnabledFn;
  inherit mkModule;
  inherit ternary;
}
