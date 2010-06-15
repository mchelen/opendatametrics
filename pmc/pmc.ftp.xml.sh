#!/bin/sh
# requires curlftpfs
# author: Michael Chelen http://mikechelen.com http://twitter.com/mikechelen
# license: Creative Commons Zero
# file list: http://www.ncbi.nlm.nih.gov/pmc/about/ftp.html#XML_for_Data_Mining
# output path
outputpath=output
# ftp server and remote path
ftp=ftp.ncbi.nlm.nih.gov
ftppath=pub/pmc
# generate output file name
outputfile=${ftp}.$(echo $ftppath|sed 's/\//./g').$(date +%s).tsv
outputerror=${ftp}.$(echo $ftppath|sed 's/\//./g').$(date +%s).error.txt
# create mount point
mkdir -p $ftp
# mount ftp with curlftpfs
echo Mounting $ftp
curlftpfs $ftp $ftp
# create output path
mkdir -p $outputpath
# output file list
outputpathfile=$outputpath/$outputfile
outputerrorpathfile=$outputpath/$outputerror
for I in A-B C-H I-N O-Z;
do
 echo $I;
 curpath=$ftp/$ftppath/articles.$I.tar.gz
 echo Opening $curpath for output to $outputpathfile
 tar -tvf $curpath >> $outputpathfile 2>> $outputerrorpathfile
 echo Done with $curpath
done
# unmount and remove directory 
fusermount -uz $ftp
rmdir $ftp
