#!/bin/sh
# requires 10-20+ gb disk space

# Download NXML archives

# file list: http://www.ncbi.nlm.nih.gov/pmc/about/ftp.html#XML_for_Data_Mining

tmppath=tmp
outputpath=output

mkdir -p $tmppath

cd $tmppath


# download xml archives
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/articles.A-B.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/articles.C-H.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/articles.I-N.tar.gz
wget ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/articles.O-Z.tar.gz



# Extract them



# remove temporary files
cd ..
rm -r $tmppath
