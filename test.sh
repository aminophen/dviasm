#!/bin/sh

# command
DVIASM="python3 dviasm.py"
#DVIASM="python archive/dviasm2-final.py"
#DVIASM="python archive/dviasm-chof.py"

# directory
IN="test"
OUT="output"
mkdir -p $OUT

# debug
set -x

#####

# simple: DVI -> dump (file)
$DVIASM $IN/test.dvi -o $OUT/testo.dump
diff $OUT/testo.dump $IN/test.dump || exit 1
$DVIASM $IN/test-ja.dvi -o $OUT/testo-ja.dump
diff $OUT/testo-ja.dump $IN/test-ja.dump || exit 1
$DVIASM -p $IN/test-ja-p.dvi -o $OUT/testo-ja-p.dump
diff $OUT/testo-ja-p.dump $IN/test-ja-p.dump || exit 1

# simple: DVI -> dump (stdout)
$DVIASM $IN/test.dvi >$OUT/test.dump
diff $OUT/test.dump $IN/test.dump || exit 1
$DVIASM $IN/test-ja.dvi >$OUT/test-ja.dump
diff $OUT/test-ja.dump $IN/test-ja.dump || exit 1
$DVIASM -p $IN/test-ja-p.dvi >$OUT/test-ja-p.dump
diff $OUT/test-ja-p.dump $IN/test-ja-p.dump || exit 1

# simple: dump -> DVI (file)
$DVIASM -o $OUT/test.dump.dvi $IN/test.dump
cmp $OUT/test.dump.dvi $IN/test.dump.dvi || exit 1
$DVIASM -o $OUT/test-ja.dump.dvi $IN/test-ja.dump
cmp $OUT/test-ja.dump.dvi $IN/test-ja.dump.dvi || exit 1
$DVIASM -p -o $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump
cmp $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump.dvi || exit 1

# simple: dump -> DVI (stdout)
$DVIASM $IN/test.dump >$OUT/testo.dump.dvi
cmp $OUT/testo.dump.dvi $IN/test.dump.dvi || exit 1
$DVIASM $IN/test-ja.dump >$OUT/testo-ja.dump.dvi
cmp $OUT/testo-ja.dump.dvi $IN/test-ja.dump.dvi || exit 1
$DVIASM -p $IN/test-ja-p.dump >$OUT/testo-ja-p.dump.dvi
cmp $OUT/testo-ja-p.dump.dvi $IN/test-ja-p.dump.dvi || exit 1

#####

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
$DVIASM --ptex $IN/ajt03jp.dvi >$OUT/ajt03jp.dump
diff $OUT/ajt03jp.dump $IN/ajt03jp.dump || exit 1

# ajt0201cho: dump -> DVI
## ajt05jt.dump -> ajt05jt.dump.dvi was wrong (DVIV_ID)
## => fixed in py3-20191126
$DVIASM $IN/ajt01lig.dump -o $OUT/ajt01lig.dump.dvi
cmp $OUT/ajt01lig.dump.dvi $IN/ajt01lig.dump.dvi || exit 1
$DVIASM $IN/ajt02omega.dump -o $OUT/ajt02omega.dump.dvi
cmp $OUT/ajt02omega.dump.dvi $IN/ajt02omega.dump.dvi || exit 1
$DVIASM --ptex $IN/ajt03jp.dump -o $OUT/ajt03jp.dump.dvi
cmp $OUT/ajt03jp.dump.dvi $IN/ajt03jp.dump.dvi || exit 1
$DVIASM --ptex $IN/ajt04jy.dump -o $OUT/ajt04jy.dump.dvi
cmp $OUT/ajt04jy.dump.dvi $IN/ajt04jy.dump.dvi || exit 1
$DVIASM --ptex $IN/ajt05jt.dump -o $OUT/ajt05jt.dump.dvi
cmp $OUT/ajt05jt.dump.dvi $IN/ajt05jt.dump.dvi || exit 1
$DVIASM --subfont=outbtm,outgtm, $IN/ajt06kr.dump -o $OUT/ajt06kr.dump.dvi
cmp $OUT/ajt06kr.dump.dvi $IN/ajt06kr.dump.dvi || exit 1

#####

# checklength: dump -> DVI -> dump
## checklength.dump ->...-> checklength.dump.dump was different
## => fixed in py2-20191202
$DVIASM -u sp $IN/checklength.dump -o $OUT/checklength.dump.dvi
$DVIASM -u sp $OUT/checklength.dump.dvi >$OUT/checklength.dump.dump
diff $OUT/checklength.dump.dump $IN/checklength.dump || exit 1

#####

# gh0012: DVI -> dump
## gh0012.dvi -> gh0012.dump caused error with --ptex
## => [TODO]
$DVIASM $IN/gh0012.dvi >$OUT/gh0012.dump
diff $OUT/gh0012.dump $IN/gh0012.dump || exit 1
$DVIASM --ptex $IN/gh0012.dvi >$OUT/gh0012-p.dump
diff $OUT/gh0012-p.dump $IN/gh0012.dump || exit 1

# gh0012: dump -> DVI
## gh0012.dump -> gh0012.dump.dvi caused error with --ptex
## => [TODO]
$DVIASM $IN/gh0012.dump -o $OUT/gh0012.dump.dvi
cmp $OUT/gh0012.dump.dvi $IN/gh0012.dump.dvi || exit 1
$DVIASM --ptex $IN/gh0012.dump -o $OUT/gh0012-p.dump.dvi
cmp $OUT/gh0012-p.dump.dvi $IN/gh0012.dump.dvi || exit 1

# finish
echo success!
