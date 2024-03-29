#!/bin/bash
 
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
	echo usage: shrinkpdf \<filename\> \<resolution\> \[\<output\>\]
	exit
fi
 
if [ ! -e "$1" ]; then
	echo "$1" does not exist. Exiting.
	exit
fi
 
if [ $# = 3 ]; then
	NEWNAME=$3
else
	NEWNAME=`basename $1 .pdf`_shrinked.pdf
fi
 
if [ "$1 " = "$NEWNAME " ]; then
	echo Input and output are identical. Won\'t overwrite---exiting.
	exit
fi
 
if [ -e "$NEWNAME" ]; then
	echo "$NEWNAME" exists. Delete? \(y/n\)
	read ANS
	if [ "$ANS " = "y " ]; then
		rm "$NEWNAME"
	else
		exit
	fi
fi
 
gs	-q -dNOPAUSE -dBATCH -dSAFER \
	-sDEVICE=pdfwrite \
	-dCompatibilityLevel=1.3 \
	-dPDFSETTINGS=/screen \
	-dEmbedAllFonts=true \
	-dSubsetFonts=true \
	-dColorImageDownsampleType=/Bicubic \
	-dColorImageResolution=$2 \
	-dGrayImageDownsampleType=/Bicubic \
	-dGrayImageResolution=$2 \
	-dMonoImageDownsampleType=/Bicubic \
	-dMonoImageResolution=$2 \
	-sOutputFile="$NEWNAME" \
	 "$1"
 
echo $1: $((`wc -c "$1" | cut -d \  -f 1` / 1024 )) kb
echo $NEWNAME: $((`wc -c "$NEWNAME" | cut -d \  -f 1` / 1024 )) kb

exit 0


##!/bin/sh
#
#if [ "$2" = "" ] ; then
#	echo "usage: $0 <input> <output>"
#	exit
#fi
#
#gs	-q -dNOPAUSE -dBATCH -dSAFER \
#	-sDEVICE=pdfwrite \
#	-dCompatibilityLevel=1.3 \
#	-dPDFSETTINGS=/screen \
#	-dEmbedAllFonts=true \
#	-dSubsetFonts=true \
#	-dColorImageDownsampleType=/Bicubic \
#	-dColorImageResolution=72 \
#	-dGrayImageDownsampleType=/Bicubic \
#	-dGrayImageResolution=72 \
#	-dMonoImageDownsampleType=/Bicubic \
#	-dMonoImageResolution=72 \
#	-sOutputFile=$2 \
#	 $1
