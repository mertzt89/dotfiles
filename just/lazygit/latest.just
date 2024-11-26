import '../lib.just'

latest_file := join(just_cache_dir, 'lazygit.latest')

[unix]
fetch_latest: ensure_just_cache_dir
  #!/usr/bin/env bash
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  echo $LAZYGIT_VERSION > {{latest_file}}

latest: fetch_latest
  @cat {{latest_file}}

