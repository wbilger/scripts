#!/bin/bash
find . -exec bash -c 'basename "$0" ".${0##*.}"' {} \; | sort | uniq --repeated
