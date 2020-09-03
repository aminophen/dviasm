#!/bin/sh

# command
DVIASM="python3 dviasm.py"

# directory
IN="test"
OUT="output"
mkdir -p $OUT

# debug
set -x

# tb89cho: dump -> DVI
$DVIASM $IN/hello.dump -o $OUT/hello.dump.dvi
cmp $OUT/hello.dump.dvi $IN/hello.dump.dvi || exit 1
$DVIASM $IN/hello5.dump -o $OUT/hello5.dump.dvi
cmp $OUT/hello5.dump.dvi $IN/hello5.dump.dvi || exit 1
$DVIASM $IN/hello6.dump -o $OUT/hello6.dump.dvi
cmp $OUT/hello6.dump.dvi $IN/hello6.dump.dvi || exit 1

# ajt0201cho: DVI -> dump
$DVIASM $IN/ajt01lig.dvi >$OUT/ajt01lig.dump
diff $OUT/ajt01lig.dump $IN/ajt01lig.dump || exit 1

# ajt0201cho: dump -> DVI
$DVIASM $IN/ajt01lig.dump -o $OUT/ajt01lig.dump.dvi
cmp $OUT/ajt01lig.dump.dvi $IN/ajt01lig.dump.dvi || exit 1
$DVIASM $IN/ajt02omega.dump -o $OUT/ajt02omega.dump.dvi
cmp $OUT/ajt02omega.dump.dvi $IN/ajt02omega.dump.dvi || exit 1

# simple: DVI -> dump
$DVIASM $IN/test.dvi >$OUT/test.dump
diff $OUT/test.dump $IN/test.dump || exit 1
$DVIASM $IN/test-ja.dvi >$OUT/test-ja.dump
diff $OUT/test-ja.dump $IN/test-ja.dump || exit 1
$DVIASM -p $IN/test-ja-p.dvi >$OUT/test-ja-p.dump
diff $OUT/test-ja-p.dump $IN/test-ja-p.dump || exit 1

# simple: dump -> DVI
$DVIASM -o $OUT/test.dump.dvi $IN/test.dump
cmp $OUT/test.dump.dvi $IN/test.dump.dvi || exit 1
$DVIASM -o $OUT/test-ja.dump.dvi $IN/test-ja.dump
cmp $OUT/test-ja.dump.dvi $IN/test-ja.dump.dvi || exit 1
$DVIASM -p -o $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump
cmp $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump.dvi || exit 1

# finish
echo success!
