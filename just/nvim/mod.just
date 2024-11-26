nvim_config_dir := join(config_directory(), "nvim")

import '../lib.just'
import './install.just'
import './version.just'

default:
  @just --justfile {{source_file()}} --choose


config:
  @cd {{nvim_config_dir}} && nvim



