#!/bin/sh
# requires curlftpfs

# file list: http://www.ncbi.nlm.nih.gov/pmc/about/ftp.html#XML_for_Data_Mining

# mount path
mountpath=mount
# output path
outputpath=output
# generate output file name
outputfile=${ftp}.$(echo $ftppath|sed 's/\//./g').$(date +%s).tsv

# ftp server and remote path
ftp=ftp.ncbi.nlm.nih.gov
ftppath=pub/pmc

# create mount point
mkdir -p $mountpath

# mount ftp with curlftpfs
curlftpfs $ftp $mountpath

# create output path
mkdir -p $outputpath

# output file list
tar -tvf $mountpath/$ftppath/articles.A-B.tar.gz >> $outputpath/$outputfile 2>> errors.txt
tar -tvf $mountpath/$ftppath/articles.C-H.tar.gz >> $outputpath/$outputfile 2>> errors.txt
tar -tvf $mountpath/$ftppath/articles.I-N.tar.gz >> $outputpath/$outputfile 2>> errors.txt
tar -tvf $mountpath/$ftppath/articles.O-Z.tar.gz >> $outputpath/$outputfile 2>> errors.txt

# unmount
fusermount -uz $mountpath

# remove mount path
rmdir $mountpath
