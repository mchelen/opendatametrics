#!/bin/sh
# author: Michael Chelen http://mikechelen.com http://twitter.com/mikechelen
# license: Creative Commons Zero
# saves file structure of Pubmed Central XML archives
# requires curlftpfs
# file list: http://www.ncbi.nlm.nih.gov/pmc/about/ftp.html#XML_for_Data_Mining

# output path with current date
outputdir=output
outputpath=$outputdir/$(date +%s)
# ftp server and remote path
ftp=ftp.ncbi.nlm.nih.gov
ftppath=pub/pmc
# generate output file name
filename=pmc.ftp.articles.xml.list
outputfile=$filename.tsv
outputerror=$filename.error.txt
# create mount point
mkdir -p $ftp
# mount ftp with curlftpfs
echo Mounting $ftp
curlftpfs $ftp $ftp
# create output path
mkdir -p $outputpath
# make symlink for current version (remove old symlink first)
rm current 2> /dev/null
ln -s ../$outputpath $outputdir/current
# full paths for file and error output
outputfilepath=$outputdir/current/$outputfile
outputerrorpath=$outputdir/current/$outputerror
# output file list
for I in A-B C-H I-N O-Z;
do
 curfile=$ftp/$ftppath/articles.$I.tar.gz
 echo "Opening $curfile for output to $outputfilepath"
 tar -tvf $curfile  2>> $outputerrorpath | tee $outputfilepath
# tar -tvf $curfile >> $outputfilepath 2>> $outputerrorpath
 echo Done with $curfile
done
# unmount and remove directory 
fusermount -uz $ftp
rmdir $ftp
