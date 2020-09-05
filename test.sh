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

##### minimum by Arthur Reutenauer

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

##### from https://github.com/aminophen/tex-assort

# font/native: DVI/XDV -> dump
$DVIASM $IN/font.dvi -o $OUT/font.dump
diff $OUT/font.dump $IN/font.dump || exit 1
$DVIASM $IN/font.xdv -o $OUT/font.xdump
diff $OUT/font.xdump $IN/font.xdump || exit 1
$DVIASM $IN/native.xdv -o $OUT/native.xdump
diff $OUT/native.xdump $IN/native.xdump || exit 1

# font/native: dump -> DVI/XDV
$DVIASM $IN/font.dump -o $OUT/font.dump.dvi
cmp $OUT/font.dump $IN/font.dump || exit 1
$DVIASM $IN/font.xdump -o $OUT/font.xdump.xdv
cmp $OUT/font.xdump.xdv $IN/font.xdump.xdv || exit 1
$DVIASM $IN/native.xdump -o $OUT/native.xdump.xdv
cmp $OUT/native.xdump.xdv $IN/native.xdump.xdv || exit 1

##### documented behavior by Jin-Hwan Cho (ChoF)

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
## => fixed in py3-20191126 (#10, #11)
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

# ajt0201cho: DVI -> dump (back)
$DVIASM $IN/ajt02omega.dump.dvi -o $OUT/ajt02omega.dump.dump
diff $OUT/ajt02omega.dump.dump $IN/ajt02omega.dump.dump || exit 1
$DVIASM --subfont=outbtm,outgtm, $IN/ajt06kr.dump.dvi -o $OUT/ajt06kr.dump.dump
diff $OUT/ajt06kr.dump.dump $IN/ajt06kr.dump.dump || exit 1

##### from GitHub PR 5 by Masamichi Hosoda

# checklength: dump -> DVI -> dump
## checklength.dump ->...-> checklength.dump.dump was different
## => fixed in py2-20191202 (#3, #5)
$DVIASM -u sp $IN/checklength.dump -o $OUT/checklength.dump.dvi
$DVIASM -u sp $OUT/checklength.dump.dvi >$OUT/checklength.dump.dump
diff $OUT/checklength.dump.dump $IN/checklength.dump || exit 1

##### from GitHub Issue 12

# gh0012: DVI -> dump
## gh0012.dvi -> gh0012.dump caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM $IN/gh0012.dvi >$OUT/gh0012.dump
diff $OUT/gh0012.dump $IN/gh0012.dump || exit 1
$DVIASM --ptex $IN/gh0012.dvi >$OUT/gh0012-p.dump
diff $OUT/gh0012-p.dump $IN/gh0012.dump || exit 1

# gh0012: dump -> DVI
## gh0012.dump -> gh0012.dump.dvi caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM $IN/gh0012.dump -o $OUT/gh0012.dump.dvi
cmp $OUT/gh0012.dump.dvi $IN/gh0012.dump.dvi || exit 1
$DVIASM --ptex $IN/gh0012.dump -o $OUT/gh0012-p.dump.dvi
cmp $OUT/gh0012-p.dump.dvi $IN/gh0012.dump.dvi || exit 1

##### user-defined subfont

# ipxm: DVI -> dump
$DVIASM --subfont=ipxm-r-u,ipxg-r-u, $IN/ipxm.dvi >$OUT/ipxm.dump
diff $OUT/ipxm.dump $IN/ipxm.dump || exit 1

# ipxm: dump -> DVI
$DVIASM --subfont=ipxm-r-u,ipxg-r-u, $IN/ipxm.dump -o $OUT/ipxm.dump.dvi
cmp $OUT/ipxm.dump.dvi $IN/ipxm.dump.dvi || exit 1

##### inputenc and fontenc

# varenc: DVI -> dump
## varenc-p.dvi -> varenc-p.dump caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM -p $IN/varenc-p.dvi >$OUT/varenc-p.dump
diff $OUT/varenc-p.dump $IN/varenc-p.dump || exit 1
$DVIASM $IN/varenc-up.dvi >$OUT/varenc-up.dump
diff $OUT/varenc-up.dump $IN/varenc-up.dump || exit 1

# varenc: dump -> DVI
## varenc-p.dump -> varenc-p.dump.dvi caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM -p $IN/varenc-p.dump -o $OUT/varenc-p.dump.dvi
cmp $OUT/varenc-p.dump.dvi $IN/varenc-p.dump.dvi || exit 1
$DVIASM $IN/varenc-up.dump -o $OUT/varenc-up.dump.dvi
cmp $OUT/varenc-up.dump.dvi $IN/varenc-up.dump.dvi || exit 1

#####

# finish
echo success!
