nvim_install_dir := join(local_app_dir, "nvim")
archive_name := if os_family() == "windows" { 'nvim-win64.zip' } else { "nvim-linux64.tar.gz" } 
archive := join(just_cache_dir, archive_name)
nvim_bin := join(executable_directory(), "nvim")

import './version.just'

ensure_install_dir: (ensure_dir nvim_install_dir)

[unix]
install VERSION="": get_latest ensure_install_dir && rm_latest
  #!/usr/bin/env bash
  VERSION={{VERSION}}
  if [ -z $VERSION ]; then
    VERSION=$(cat {{latest_file}})
  fi

  echo "{{GREEN}}Installing Neovim version $VERSION{{NORMAL}}"

  TAR_URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/{{archive_name}}"
  curl -Lo {{archive}} $TAR_URL
  tar --strip-components=1 -C {{nvim_install_dir}} -xf {{archive}}
  ln -sf {{join(nvim_install_dir, "bin/nvim")}} {{nvim_bin}}
  rm {{archive}}
  echo "{{GREEN}}Done installing Neovim version $VERSION.{{NORMAL}}"

[windows]
install VERSION="":
  @Write-Output "{{RED}}TODO{{NORMAL}}"

uninstall:
  (rm -r -f {{nvim_install_dir}} && rm {{nvim_bin}} && echo "{{GREEN}}Neovim uninstalled{{NORMAL}}") || echo "{{RED}}Failed to uninstall Neovim{{NORMAL}}"
