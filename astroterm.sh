#! /usr/bin/env bash

TZ=":Etc/UTC" date +%Y-%m-%dT%T | { read dateAndTime; astroterm -cCu -a 40.88 -o -123.98 -m -d $dateAndTime; }
