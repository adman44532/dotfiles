{
  myLib,
  pkgs,
  user,
  ...
}: let
  inherit (myLib) mkModule;
in
  mkModule "uutils" ["terminal"] {
    environment.systemPackages = with pkgs; [uutils-coreutils];
    home-manager.users.${user}.programs = {
      fish.shellAliases = {
        arch = "uutils-arch";
        b2sum = "uutils-b2sum";
        b3sum = "uutils-b3sum";
        base32 = "uutils-base32";
        base64 = "uutils-base64";
        basename = "uutils-basename";
        basenc = "uutils-basenc";
        # cat is handled by bat (see bat.nix)
        chcon = "uutils-chcon";
        chgrp = "uutils-chgrp";
        chmod = "uutils-chmod";
        chown = "uutils-chown";
        chroot = "uutils-chroot";
        cksum = "uutils-cksum";
        comm = "uutils-comm";
        cp = "uutils-cp";
        csplit = "uutils-csplit";
        cut = "uutils-cut";
        date = "uutils-date";
        dd = "uutils-dd";
        df = "uutils-df";
        dir = "uutils-dir";
        dircolors = "uutils-dircolors";
        dirname = "uutils-dirname";
        du = "uutils-du";
        echo = "uutils-echo";
        env = "uutils-env";
        expand = "uutils-expand";
        expr = "uutils-expr";
        factor = "uutils-factor";
        false = "uutils-false";
        fmt = "uutils-fmt";
        fold = "uutils-fold";
        groups = "uutils-groups";
        hashsum = "uutils-hashsum";
        head = "uutils-head";
        hostid = "uutils-hostid";
        hostname = "uutils-hostname";
        id = "uutils-id";
        install = "uutils-install";
        join = "uutils-join";
        kill = "uutils-kill";
        link = "uutils-link";
        ln = "uutils-ln";
        logname = "uutils-logname";
        # ls is handled by eza (see eza.nix)
        md5sum = "uutils-md5sum";
        mkdir = "uutils-mkdir";
        mkfifo = "uutils-mkfifo";
        mknod = "uutils-mknod";
        mktemp = "uutils-mktemp";
        more = "uutils-more";
        mv = "uutils-mv";
        nice = "uutils-nice";
        nl = "uutils-nl";
        nohup = "uutils-nohup";
        nproc = "uutils-nproc";
        numfmt = "uutils-numfmt";
        od = "uutils-od";
        paste = "uutils-paste";
        pathchk = "uutils-pathchk";
        pinky = "uutils-pinky";
        pr = "uutils-pr";
        printenv = "uutils-printenv";
        printf = "uutils-printf";
        ptx = "uutils-ptx";
        pwd = "uutils-pwd";
        readlink = "uutils-readlink";
        realpath = "uutils-realpath";
        rm = "uutils-rm";
        rmdir = "uutils-rmdir";
        runcon = "uutils-runcon";
        seq = "uutils-seq";
        sha1sum = "uutils-sha1sum";
        sha224sum = "uutils-sha224sum";
        sha256sum = "uutils-sha256sum";
        sha3-224sum = "uutils-sha3-224sum";
        sha3-256sum = "uutils-sha3-256sum";
        sha3-384sum = "uutils-sha3-384sum";
        sha3-512sum = "uutils-sha3-512sum";
        sha384sum = "uutils-sha384sum";
        sha3sum = "uutils-sha3sum";
        sha512sum = "uutils-sha512sum";
        shake128sum = "uutils-shake128sum";
        shake256sum = "uutils-shake256sum";
        shred = "uutils-shred";
        shuf = "uutils-shuf";
        sleep = "uutils-sleep";
        sort = "uutils-sort";
        split = "uutils-split";
        stat = "uutils-stat";
        stdbuf = "uutils-stdbuf";
        stty = "uutils-stty";
        sum = "uutils-sum";
        sync = "uutils-sync";
        tac = "uutils-tac";
        tail = "uutils-tail";
        tee = "uutils-tee";
        # Cannot alias 'test' - reserved keyword in Fish, use builtin test
        timeout = "uutils-timeout";
        touch = "uutils-touch";
        tr = "uutils-tr";
        true = "uutils-true";
        truncate = "uutils-truncate";
        tsort = "uutils-tsort";
        tty = "uutils-tty";
        uname = "uutils-uname";
        unexpand = "uutils-unexpand";
        uniq = "uutils-uniq";
        unlink = "uutils-unlink";
        uptime = "uutils-uptime";
        users = "uutils-users";
        vdir = "uutils-vdir";
        wc = "uutils-wc";
        who = "uutils-who";
        whoami = "uutils-whoami";
        yes = "uutils-yes";
      };
    };
  }
