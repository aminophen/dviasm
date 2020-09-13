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
$DVIASM $IN/test.dvi -o $OUT/testo.dump || exit 2
diff $IN/test.dump $OUT/testo.dump || exit 1
$DVIASM $IN/test-ja.dvi -o $OUT/testo-ja.dump || exit 2
diff $IN/test-ja.dump $OUT/testo-ja.dump || exit 1
$DVIASM -p $IN/test-ja-p.dvi -o $OUT/testo-ja-p.dump || exit 2
diff $IN/test-ja-p.dump $OUT/testo-ja-p.dump || exit 1

# simple: DVI -> dump (stdout)
$DVIASM $IN/test.dvi >$OUT/test.dump || exit 2
diff $IN/test.dump $OUT/test.dump || exit 1
$DVIASM $IN/test-ja.dvi >$OUT/test-ja.dump || exit 2
diff $IN/test-ja.dump $OUT/test-ja.dump || exit 1
$DVIASM -p $IN/test-ja-p.dvi >$OUT/test-ja-p.dump || exit 2
diff $IN/test-ja-p.dump $OUT/test-ja-p.dump || exit 1

# simple: dump -> DVI (file)
$DVIASM -o $OUT/test.dump.dvi $IN/test.dump || exit 2
cmp $IN/test.dump.dvi $OUT/test.dump.dvi || exit 1
$DVIASM -o $OUT/test-ja.dump.dvi $IN/test-ja.dump || exit 2
cmp $IN/test-ja.dump.dvi $OUT/test-ja.dump.dvi || exit 1
$DVIASM -p -o $OUT/test-ja-p.dump.dvi $IN/test-ja-p.dump || exit 2
cmp $IN/test-ja-p.dump.dvi $OUT/test-ja-p.dump.dvi || exit 1

# simple: dump -> DVI (stdout)
$DVIASM $IN/test.dump >$OUT/testo.dump.dvi || exit 2
cmp $IN/test.dump.dvi $OUT/testo.dump.dvi || exit 1
$DVIASM $IN/test-ja.dump >$OUT/testo-ja.dump.dvi || exit 2
cmp $IN/test-ja.dump.dvi $OUT/testo-ja.dump.dvi || exit 1
$DVIASM -p $IN/test-ja-p.dump >$OUT/testo-ja-p.dump.dvi || exit 2
cmp $IN/test-ja-p.dump.dvi $OUT/testo-ja-p.dump.dvi || exit 1

##### from https://github.com/aminophen/tex-assort

# font/native: DVI/XDV -> dump
$DVIASM $IN/font.dvi -o $OUT/font.dump || exit 2
diff $IN/font.dump $OUT/font.dump || exit 1
$DVIASM $IN/font.xdv -o $OUT/font.xdump || exit 2
diff $IN/font.xdump $OUT/font.xdump || exit 1
$DVIASM $IN/native.xdv -o $OUT/native.xdump || exit 2
diff $IN/native.xdump $OUT/native.xdump || exit 1

# font/native: dump -> DVI/XDV
$DVIASM $IN/font.dump -o $OUT/font.dump.dvi || exit 2
cmp $IN/font.dump.dvi $OUT/font.dump.dvi || exit 1
$DVIASM $IN/font.xdump -o $OUT/font.xdump.xdv || exit 2
cmp $IN/font.xdump.xdv $OUT/font.xdump.xdv || exit 1
$DVIASM $IN/native.xdump -o $OUT/native.xdump.xdv || exit 2
cmp $IN/native.xdump.xdv $OUT/native.xdump.xdv || exit 1

##### documented behavior by Jin-Hwan Cho (ChoF)

# tb89cho: dump -> DVI
$DVIASM $IN/hello.dump -o $OUT/hello.dump.dvi || exit 2
cmp $IN/hello.dump.dvi $OUT/hello.dump.dvi || exit 1
$DVIASM $IN/hello5.dump -o $OUT/hello5.dump.dvi || exit 2
cmp $IN/hello5.dump.dvi $OUT/hello5.dump.dvi || exit 1
$DVIASM $IN/hello6.dump -o $OUT/hello6.dump.dvi || exit 2
cmp $IN/hello6.dump.dvi $OUT/hello6.dump.dvi || exit 1

# ajt0201cho: DVI -> dump
$DVIASM $IN/ajt01lig.dvi -o $OUT/ajt01lig.dump || exit 2
diff $IN/ajt01lig.dump $OUT/ajt01lig.dump || exit 1
$DVIASM --ptex $IN/ajt03jp.dvi -o $OUT/ajt03jp.dump || exit 2
diff $IN/ajt03jp.dump $OUT/ajt03jp.dump || exit 1

# ajt0201cho: dump -> DVI
## ajt05jt.dump -> ajt05jt.dump.dvi was wrong (DVIV_ID)
## => fixed in py3-20191126 (#10, #11)
$DVIASM $IN/ajt01lig.dump -o $OUT/ajt01lig.dump.dvi || exit 2
cmp $IN/ajt01lig.dump.dvi $OUT/ajt01lig.dump.dvi || exit 1
$DVIASM $IN/ajt02omega.dump -o $OUT/ajt02omega.dump.dvi || exit 2
cmp $IN/ajt02omega.dump.dvi $OUT/ajt02omega.dump.dvi || exit 1
$DVIASM --ptex $IN/ajt03jp.dump -o $OUT/ajt03jp.dump.dvi || exit 2
cmp $IN/ajt03jp.dump.dvi $OUT/ajt03jp.dump.dvi || exit 1
$DVIASM --ptex $IN/ajt04jy.dump -o $OUT/ajt04jy.dump.dvi || exit 2
cmp $IN/ajt04jy.dump.dvi $OUT/ajt04jy.dump.dvi || exit 1
$DVIASM --ptex $IN/ajt05jt.dump -o $OUT/ajt05jt.dump.dvi || exit 2
cmp $IN/ajt05jt.dump.dvi $OUT/ajt05jt.dump.dvi || exit 1
$DVIASM --subfont=outbtm,outgtm, $IN/ajt06kr.dump -o $OUT/ajt06kr.dump.dvi || exit 2
cmp $IN/ajt06kr.dump.dvi $OUT/ajt06kr.dump.dvi || exit 1

# ajt0201cho: DVI -> dump (back)
$DVIASM $IN/ajt02omega.dump.dvi -o $OUT/ajt02omega.dump.dump || exit 2
diff $IN/ajt02omega.dump.dump $OUT/ajt02omega.dump.dump || exit 1
$DVIASM --subfont=outbtm,outgtm, $IN/ajt06kr.dump.dvi -o $OUT/ajt06kr.dump.dump || exit 2
diff $IN/ajt06kr.dump.dump $OUT/ajt06kr.dump.dump || exit 1

##### from GitHub PR 5 by Masamichi Hosoda

# checklength: dump -> DVI -> dump
## checklength.dump ->...-> checklength.dump.dump was different
## => fixed in py2-20190202 (#3, #5)
$DVIASM -u sp $IN/checklength.dump -o $OUT/checklength.dump.dvi || exit 2
$DVIASM -u sp $OUT/checklength.dump.dvi -o $OUT/checklength.dump.dump || exit 2
diff $IN/checklength.dump $OUT/checklength.dump.dump || exit 1

##### from GitHub Issue 6/7

# overbmp: DVI -> dump -> DVI
## set3 was unsupported in Python 2.x
## => fixed in py3-20191126 (#6, #7)
$DVIASM $IN/overbmp-up.dvi -o $OUT/overbmp-up.dump || exit 2
diff $IN/overbmp-up.dump $OUT/overbmp-up.dump || exit 1
$DVIASM $IN/overbmp-up.dump -o $OUT/overbmp-up.dump.dvi || exit 2
cmp $IN/overbmp-up.dump.dvi $OUT/overbmp-up.dump.dvi || exit 1

##### from GitHub Issue 12

# gh0012: DVI -> dump
## gh0012.dvi -> gh0012.dump caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM $IN/gh0012.dvi -o $OUT/gh0012.dump || exit 2
diff $IN/gh0012.dump $OUT/gh0012.dump || exit 1
$DVIASM --ptex $IN/gh0012.dvi -o $OUT/gh0012-p.dump || exit 2
diff $IN/gh0012.dump $OUT/gh0012-p.dump || exit 1

# gh0012: dump -> DVI
## gh0012.dump -> gh0012.dump.dvi caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM $IN/gh0012.dump -o $OUT/gh0012.dump.dvi || exit 2
cmp $IN/gh0012.dump.dvi $OUT/gh0012.dump.dvi || exit 1
$DVIASM --ptex $IN/gh0012.dump -o $OUT/gh0012-p.dump.dvi || exit 2
cmp $IN/gh0012.dump.dvi $OUT/gh0012-p.dump.dvi || exit 1

##### user-defined subfont

# ipxm: DVI -> dump
$DVIASM --subfont=ipxm-r-u,ipxg-r-u, $IN/ipxm.dvi -o $OUT/ipxm.dump || exit 2
diff $IN/ipxm.dump $OUT/ipxm.dump || exit 1

# ipxm: dump -> DVI
$DVIASM --subfont=ipxm-r-u,ipxg-r-u, $IN/ipxm.dump -o $OUT/ipxm.dump.dvi || exit 2
cmp $IN/ipxm.dump.dvi $OUT/ipxm.dump.dvi || exit 1

##### inputenc and fontenc

# varenc: DVI -> dump
## varenc-p.dvi -> varenc-p.dump caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM -p $IN/varenc-p.dvi -o $OUT/varenc-p.dump || exit 2
diff $IN/varenc-p.dump $OUT/varenc-p.dump || exit 1
$DVIASM $IN/varenc-up.dvi -o $OUT/varenc-up.dump || exit 2
diff $IN/varenc-up.dump $OUT/varenc-up.dump || exit 1

# varenc: dump -> DVI
## varenc-p.dump -> varenc-p.dump.dvi caused error with --ptex
## => [TODO] workaround in py3-20200905, needs reconsider (#13)
$DVIASM -p $IN/varenc-p.dump -o $OUT/varenc-p.dump.dvi || exit 2
cmp $IN/varenc-p.dump.dvi $OUT/varenc-p.dump.dvi || exit 1
$DVIASM $IN/varenc-up.dump -o $OUT/varenc-up.dump.dvi || exit 2
cmp $IN/varenc-up.dump.dvi $OUT/varenc-up.dump.dvi || exit 1

##### command-line encoding option

# Note: The original ChoF version supported only
#         * DVI ->(-e sjis -p)-> dump(file)
#         * DVI ->(-e sjis -p)-> dump(stdout)
#       The current version by HY supports
#         * DVI ->(-e sjis/eucjp -p)-> dump(file)
#         * dump(file) ->(-e sjis/eucjp -p)-> DVI

# first, ordinary UTF-8 dump/compile
$DVIASM -p $IN/jisx0208.dvi -o $OUT/jisx0208.dump || exit 2
diff $IN/jisx0208.dump $OUT/jisx0208.dump || exit 1
$DVIASM -p $IN/jisx0208.dump -o $OUT/jisx0208.dump.dvi || exit 2
cmp $IN/jisx0208.dump.dvi $OUT/jisx0208.dump.dvi || exit 1

# next, Shift-JIS dump/compile
$DVIASM -e sjis -p $IN/jisx0208.dvi -o $OUT/jisx0208-sjp.dump || exit 2
iconv -f UTF-8 -t SHIFT-JIS $IN/jisx0208.dump >$OUT/jisx0208-s.dump || exit 3
diff $OUT/jisx0208-s.dump $OUT/jisx0208-sjp.dump || exit 1
$DVIASM -e sjis -p $OUT/jisx0208-sjp.dump -o $OUT/jisx0208-sjp.dump.dvi || exit 2
cmp $IN/jisx0208.dump.dvi $OUT/jisx0208-sjp.dump.dvi || exit 1

# then, EUC-JP dump/compile
$DVIASM -e eucjp -p $IN/jisx0208.dvi -o $OUT/jisx0208-ejp.dump || exit 2
iconv -f UTF-8 -t EUC-JP $IN/jisx0208.dump >$OUT/jisx0208-e.dump || exit 3
diff $OUT/jisx0208-e.dump $OUT/jisx0208-ejp.dump || exit 1
$DVIASM -e eucjp -p $OUT/jisx0208-ejp.dump -o $OUT/jisx0208-ejp.dump.dvi || exit 2
cmp $IN/jisx0208.dump.dvi $OUT/jisx0208-ejp.dump.dvi || exit 1

##### from GitHub Issue 16

# spcj: DVI -> dump
$DVIASM -p $IN/spcj-ep.dvi -o $OUT/spcj-ep.dump || exit 2
diff $IN/spcj-ep.dump $OUT/spcj-ep.dump || exit 1
$DVIASM -p $IN/spcj-ep.dump -o $OUT/spcj-ep.dump.dvi || exit 2
cmp $IN/spcj-ep.dump.dvi $OUT/spcj-ep.dump.dvi || exit 1
$DVIASM -p $IN/spcj-sp.dvi -o $OUT/spcj-sp.dump || exit 2
diff $IN/spcj-sp.dump $OUT/spcj-sp.dump || exit 1

# spcj: dump -DVI
$DVIASM $IN/spcj.dvi -o $OUT/spcj.dump || exit 2
diff $IN/spcj.dump $OUT/spcj.dump || exit 1
$DVIASM $IN/spcj.dump -o $OUT/spcj.dump.dvi || exit 2
cmp $IN/spcj.dump.dvi $OUT/spcj.dump.dvi || exit 1
$DVIASM -p $IN/spcj-sp.dump -o $OUT/spcj-sp.dump.dvi || exit 2
cmp $IN/spcj-sp.dump.dvi $OUT/spcj-sp.dump.dvi || exit 1

#####

# finish
echo success!
