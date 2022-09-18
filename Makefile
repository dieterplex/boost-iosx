mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

.PHONY: build clean

build:
	cd ${mkfile_dir} && scripts/build.sh && scripts/create.sh >/dev/null 2>&1

clean:
	cd ${mkfile_dir} && rm -rf *.tar.bz2 boost frameworks.built frameworks >/dev/null 2>&1
	