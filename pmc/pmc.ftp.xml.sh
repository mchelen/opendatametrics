#!/bin/sh
# author: Michael Chelen http://mikechelen.com http://twitter.com/mikechelen
# license: Creative Commons Zero
# saves file structure of Pubmed Central XML archives
# requires curlftpfs
# file list: http://www.ncbi.nlm.nih.gov/pmc/about/ftp.html#XML_for_Data_Mining

# path for temporary files
temppath=tmp
# main directory for output
outputdir=output
# output path with current date
outputpath=$outputdir/$(date +%s)
# ftp server and remote path
ftp=ftp.ncbi.nlm.nih.gov
ftppath=pub/pmc
# generate output file name
filename=pmc.ftp.articles.xml.list
outputfile=$filename.tsv
outputerror=$filename.error.txt
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
 curfile=articles.$I.tar.gz
 cururl=ftp://$ftp/$ftppath/$curfile
 echo "Downloading $cururl to $temppath"
# wget -P $outputpath $temppath
 aria2c -d $outputpath $temppath
 echo "Opening $temppath/$curfile for output to $outputfilepath"
 tar -tvf $temppath/$curfile >> $outputfilepath 2>> $outputerrorpath
# tar -tvf $curfile >> $outputfilepath 2>> $outputerrorpath
 echo Done with $temppath/$curfile
done
# remove temporary files
rm -r $tmp
