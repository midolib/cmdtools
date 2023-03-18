#!/bin/bash
sqlite3 :memory: ".separator \t" \
".nullvalue null" \
"create table stdin ($1);" \
".import /dev/stdin stdin" "$2"
