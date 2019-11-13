#!/bin/sh

python3 dviasm.py test/hello.dvi
python3 dviasm.py test/hello-ja.dvi
python3 dviasm.py -p test/hello-ja-iso2022-jp.dvi
