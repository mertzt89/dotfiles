import '../lib.just'

import 'latest.just'

install_tar_file := join(just_cache_dir, 'lazygit.tar.gz')
install_bin_path := local_bin_dir

version:
  @lazygit --version

[unix]
install VERSION="": fetch_latest
  #!/usr/bin/env bash
  VERSION={{VERSION}}
  if [ -z $VERSION ]; then
    VERSION=$(cat {{latest_file}})
  fi

  echo "{{GREEN}}Installing lazygit version $VERSION{{NORMAL}}"

  curl -Lo {{install_tar_file}} "https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/lazygit_${VERSION}_Linux_x86_64.tar.gz"
  tar -C {{install_bin_path}} -xf {{install_tar_file}} lazygit
  echo "{{GREEN}}Done installing lazygit version $VERSION.{{NORMAL}}"

  rm {{latest_file}}
  rm {{install_tar_file}}

[unix]
uninstall:
  @(rm {{join(install_bin_path, "lazygit")}} && echo "{{GREEN}}Lazygit uninstalled{{NORMAL}}") || echo "{{RED}}Failed to uninstall lazygit{{NORMAL}}"
