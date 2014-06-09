#!/bin/sh

while getopts a:r: OPT
do
  case $OPT in
    "a" ) FLG_A="TRUE" ; AUTHOR="$OPTARG";;
    "r" ) FLG_R="TRUE" ; REV="$OPTARG";;
      * ) echo "Usage: $CMDNAME [-a AUTHOR_NAME] [-r FROM_REVISION]" 1>&2
          exit 1 ;;
  esac
done

if [ "$FLG_A" != "TRUE" ]; then
  echo "Usage: $CMDNAME [-a AUTHOR_NAME] [-r FROM_REVISION]"
fi

# TODO:execute directly
echo "svn log -r{$REV}:HEAD -v | sed -n '/$AUTHOR/,/-----$/ p' | grep '^ ' | awk '{ print \$2 }' | sort -u"
#svn log -r{$REV}:HEAD -v | sed -n '/$AUTHOR/,/-----$/ p' | grep '^ ' | awk '{ print $2 }' | sort -u
