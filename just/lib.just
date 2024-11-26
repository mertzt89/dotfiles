just_config_dir := join(config_directory(), "just")
just_cache_dir := join(cache_directory(), "just")
local_bin_dir := if os_family() == "windows" { error('TODO') } else { "~/.local/bin" } 
local_app_dir := if os_family() == "windows" { '~/apps' } else { "~/.local/apps" } 

[unix]
ensure_just_config_dir: (ensure_dir parent_directory(just_config_dir))
  #!/usr/bin/env bash
  if [ ! -d {{just_config_dir}} ]; then
    echo "{{GREEN}}Linking {{source_directory()}} -> {{just_config_dir}}{{NORMAL}}"
    ln -s {{source_directory()}} {{just_config_dir}}
  fi

ensure_just_cache_dir: (ensure_dir just_cache_dir)

ensure_local_bin_dir: (ensure_dir local_bin_dir)

ensure_local_app_dir: (ensure_dir local_app_dir)

[unix]
ensure_dir DIR:
  @[ -d {{DIR}} ] || (mkdir -p {{DIR}} && echo '{{style('warning')}}Directory "{{DIR}}" did not exist... created.{{NORMAL}}')
  
