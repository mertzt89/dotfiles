import '../lib.just'

latest_file := join(just_cache_dir, 'nvim.latest')
ver_file := join(just_cache_dir, 'nvim.current')

# Latest version
[unix]
get_latest: ensure_just_cache_dir
  #!/usr/bin/env bash
  NVIM_VERSION=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  echo $NVIM_VERSION > {{latest_file}}

rm_latest:
  @[ -f {{latest_file}} ] && rm {{latest_file}}

latest: get_latest && rm_latest
  @cat {{latest_file}}

# Current version
get_version: ensure_just_cache_dir
  @nvim --version | grep -Po "NVIM v\K.*" > {{ver_file}}

rm_version:
  @[ -f {{ver_file}} ] && rm {{ver_file}}

version: get_version && rm_version
  @cat {{ver_file}}
