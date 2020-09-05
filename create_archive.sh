#!/bin/sh

PROJECT=dviasm
TMP=/tmp
PWDF=`pwd`
LATESTRELEASEDATE=`git tag | sort -r | head -n 1`
RELEASEDATE=`git tag --points-at HEAD | sort -r | head -n 1`

if [ -z "$RELEASEDATE" ]; then
    RELEASEDATE="**not tagged**; later than $LATESTRELEASEDATE?"
fi

echo " * Create $PROJECT.zip ($RELEASEDATE)"
git archive --format=tar --prefix=$PROJECT/ HEAD | (cd $TMP && tar xf -)
rm $TMP/$PROJECT/.gitignore
rm $TMP/$PROJECT/create_archive.sh
rm $TMP/$PROJECT/test.sh
rm -rf $TMP/$PROJECT/test
rm -rf $TMP/$PROJECT/archive
perl -pi.bak -e "s/\\\$RELEASEDATE/$RELEASEDATE/g" $TMP/$PROJECT/dviasm.py
rm -f $TMP/$PROJECT/dviasm.py.bak

cd $TMP && zip -r $PWDF/$PROJECT.zip $PROJECT
rm -rf $TMP/$PROJECT
echo
echo " * Done: $PROJECT.zip ($RELEASEDATE)"
