{
  # NixOS and Nix-related commands
  swnix = "darwin-rebuild switch --verbose --show-trace --flake .";
  drynix = "darwin-rebuild dry-build --verbose --show-trace --flake .";
  bootnix = "darwin-rebuild boot --verbose --show-trace --flake .";
  rbnix = "darwin-rebuild build --rollback --flake .";
  schnix = "nix search nixpkgs";
  replnix = "nix repl '<nixpkgs>'";
  updatanix = "darwin-rebuild switch --upgrade --flake .";
  nupdate = "nix-channel --update && nix-env -u '*'";
  cleanix = "nix-collect-garbage -d";
  nix-store-du = "nix-store --gc --print-dead";
  nixdev = "nix develop /Users/wm/.nix-darwin-config";

  # Kubernetes-related commands
  k = "kubectl";
  kg = "kubectl get";
  kd = "kubectl describe";
  kap = "kubectl apply -f";
  kgaa = "kubectl get all -A";
  kgpsn = "kubectl get pods --namespace";
  ksysgpoyamll = "kubectl --namespace=kube-system get pods -o=yaml -l";
  kdaa = "kubectl delete all --all -n";
  kgctx = "kubectl config get-contexts";
  kuc = "kubectl config use-context";
  krestartpo = "kubectl rollout restart deployment";

  # Podman
  pps = "podman ps --format 'table {{ .Names }}\t{{ .Status }}' --sort names";
  pclean = "podman ps -a | grep -v 'CONTAINER\|_config\|_data\|_run' | cut -c-12 | xargs podman rm 2>/dev/null";
  piclean = "podman images | grep '<none>' | grep -P '[1234567890abcdef]{12}' -o | xargs -L1 podman rmi 2>/dev/null";
  pi = "podman images";
  pcomp = "podman-compose";
  prestart = "podman-compose down && podman-compose up -d";

  # Get resource information
  kgps = "kubectl get pods --sort-by=.metadata.name";
  kgsvc = "kubectl get svc --sort-by=.metadata.name";
  kgns = "kubectl get namespaces";
  kgpojson = "kubectl get pods -o json";
  kgnodes = "kubectl get nodes -o wide";

  # Create, apply, and edit resources
  kapp = "kubectl apply -f";
  kedit = "kubectl edit";
  kset = "kubectl set";

  # Delete resources
  kdel = "kubectl delete";
  kdelall = "kubectl delete all --all";

  # Logs and events
  klogs = "kubectl logs";
  kevents = "kubectl get events --sort-by=.metadata.creationTimestamp";

  # Exec into containers and debugging
  kexec = "kubectl exec -it";
  kdescribe = "kubectl describe";
  kshell = "kubectl exec -it -- /bin/sh";

  # Manage contexts and namespaces
  kctx = "kubectl config get-contexts";
  kusectx = "kubectl config use-context";
  knschange = "kubectl config set-context --current --namespace";

  # Deployment management
  kroll = "kubectl rollout restart";
  kstatus = "kubectl rollout status";
  kscale = "kubectl scale --replicas";

  # Port forwarding
  kfwd = "kubectl port-forward";

  # Useful lists and all-resources views
  kall = "kubectl get all --all-namespaces";
  kga = "kubectl get all";
  ksvcns = "kubectl get svc -n";

  # Pod troubleshooting
  ktop = "kubectl top pods";
  ktopnodes = "kubectl top nodes";
  kdebug = "kubectl run debug --rm -it --restart=Never --image=busybox -- /bin/sh";

  # Miscellaneous shortcuts
  kapplyd = "kubectl apply -k .";
  kapprove = "kubectl certificate approve";

  # Git-related commands
  gaa = "git add .";
  gcmsg = "git commit -m";
  gst = "git status .";
  gitsave = "gaa && gcmsg '.' && gpush";
  gco = "git checkout";
  gcb = "git checkout -b";
  gcm = "git checkout main";
  gl = "git log --oneline --graph";
  gpull = "git pull --rebase";
  gpush = "git push";
  glast = "git log -1 HEAD";

  # System and utility commands
  kbrestart = "systemctl --user restart keybase";
  restartemacs = "systemctl --user restart emacs";
  edit = "emacsclient -n -c";
  ednix = "emacsclient -nw /Users/wm/.nix-darwin-config/flake.nix";
  ec = "emacsclient -nw";
  ecx = "emacsclient -n -c";
  eterm = "emacsclient -nw -e '(vterm)'";
  sgrep = "rg -M 200 --hidden";
  cat = "bat";
  ls = "eza --icons -l -T -L=1";
  l = "ls -l";
  ll = "ls -alh";
  lsa = "ls -a";
  lstree = "ls -R | tree";
  clr = "clear";
  hist = "history | grep";
  diff = "colordiff";

  # Networking and system monitoring
  psg = "ps aux | grep";
  netstat = "sudo netstat -tulnp";
  ss = "sudo ss -tulw";
  ipinfo = "ip addr show";
  myip = "curl ifconfig.me";
  pingg = "ping google.com";
  topd = "du -sh * | sort -h";

  # File and process management
  mkd = "mkdir -p";
  vi = "nvim";
  files = "yazi";
  untar = "tar -xvf";

  # Alias management
  aliasadd = "echo 'alias $1=\"$2\"' >> ~/.bash_aliases && source ~/.bash_aliases";
  aliaslist = "cat ~/.bash_aliases | grep alias";

  # AI tools
  ai = "aichat";

  # Tmux aliases
  ta = "tmux attach -t";
  tad = "tmux attach -d -t";
  ts = "tmux new-session -s";
  tl = "tmux list-sessions";
  tksv = "tmux kill-server";
  tkss = "tmux kill-session -t";
}