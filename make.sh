#!/bin/bash

make download -j$(nproc) && time (make -j$(nproc) V=s | tee ./compile.log)
