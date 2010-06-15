#!/bin/sh
# requires curlftpfs

# ftp server
ftp=ftp.ensembl.org

# ftp path
ftppath=pub/current_fasta

# output path
outputpath=output

# mount point
mountpath=mount

# create mount point
mkdir -p $mountpath

# mount ftp
echo Mounting $ftp on $mountpath ...
curlftpfs $ftp $mountpath

# create output directory
mkdir -p $outputpath

# generate output file name
filename=${ftp}.$(echo $ftppath|sed 's/\//./g').$(date +%s).tsv

# save ftp directory structure and sizes
echo Saving ${ftppath} directory structure to $filename ...
du $mountpath/${ftppath}/ | tee $outputpath/${filename}

# unmount ftp
echo Unmounting $mountpath ...
fusermount -uz $mountpath

# remove mount point
rmdir $mountpath
