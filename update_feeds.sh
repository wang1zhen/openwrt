#!/bin/bash

rm -rf ./feeds/packages
./scripts/feeds update -a
rm -rf ./feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
./scripts/feeds install -a
