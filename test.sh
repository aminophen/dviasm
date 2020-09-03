#!/bin/sh
IN=test
OUT=output

mkdir -p output
set -x

# tb89cho: dump -> DVI
python3 dviasm.py $IN/hello.dump -o $OUT/hello.dump.dvi
cmp $OUT/hello.dump.dvi $IN/hello.dump.dvi || exit 1
python3 dviasm.py $IN/hello5.dump -o $OUT/hello5.dump.dvi
cmp $OUT/hello5.dump.dvi $IN/hello5.dump.dvi || exit 1
python3 dviasm.py $IN/hello6.dump -o $OUT/hello6.dump.dvi
cmp $OUT/hello6.dump.dvi $IN/hello6.dump.dvi || exit 1

# simple: DVI -> dump
python3 dviasm.py $IN/test.dvi >$OUT/test.dump
diff $OUT/test.dump $IN/test.dump || exit 1
python3 dviasm.py $IN/test-ja.dvi >$OUT/test-ja.dump
diff $OUT/test-ja.dump $IN/test-ja.dump || exit 1
python3 dviasm.py -p $IN/test-ja-p.dvi >$OUT/test-ja-p.dump
diff $OUT/test-ja-p.dump $IN/test-ja-p.dump || exit 1

# simple: dump -> DVI
python3 dviasm.py -o $OUT/test.dump.dvi $IN/test.dump
cmp $OUT/test.dump.dvi $IN/test.dump.dvi || exit 1
python3 dviasm.py -o $OUT/test-ja.dump.dvi $IN/test-ja.dump
cmp $OUT/test-ja.dump.dvi $IN/test-ja.dump.dvi || exit 1
python3 dviasm.py -p -o $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump
cmp $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump.dvi || exit 1

# finish
echo success!
