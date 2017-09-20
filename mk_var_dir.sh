#!/bin/bash

# creates a directory for script variables if it doesn't already exist
var_dir=~/.scripts_vars

if ! [ -d $var_dir ]; then
    mkdir "$var_dir"
fi
