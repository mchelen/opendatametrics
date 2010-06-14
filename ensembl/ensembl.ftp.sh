#!/bin/sh
# requires curlftpfs

ftp=ftp.ensembl.org

rpath=pub/current_fasta

outputpath=output

mountpath=mount

mkdir -p $mountpath

echo Mounting $ftp $rpath on $mountpath ...

curlftpfs $ftp $mountpath

mkdir -p $outputpath

filename=${ftp}.$(echo $rpath|sed 's/\//./g').$(date +%s).tsv

echo Saving ${rpath} directory structure to $filename ...

du $mountpath/${rpath}/ | tee $outputpath/${filename}

echo Unmounting $mountpath ...

fusermount -uz $mountpath

rmdir $mountpath
