<?php
/**
 * author: Michael Chelen http://mikechelen.com http://twitter.com/mikechelen
 * license: Creative Commons Zero
 * downloads pmc open access subset ftp file list and computes article counts for each journal
 * source: ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/file_list.txt
 */

// current unix timestamp
$now = time();

// file url
$url = "ftp://ftp.ncbi.nlm.nih.gov/pub/pmc/file_list.txt";

$filename = "file_list.".$now.".txt";

// download file with wget
// $output = `wget -O $filename $url`;

// download file with aria2c
$output = `aria2c -o $filename $url`;


// open file
$handle = fopen($filename, "r");

// initialize journal array
$journals = array();

// read file as csv (tsv)
while (($data = fgetcsv($handle, 0, chr(9))) !== FALSE) {
// loop through the fields in the row
  preg_match('/^[^0-9]+/', $data[1],$matches);
// echo $matches[0];
  $key = $matches[0];
// check if journal count exists
  if (array_key_exists($key,$journals)) {
//  increment journal count
    $journals[$key]=$journals($key)+1;
  }
  else {
//  start new journal count
    $journals[$key]=1;
  }
// show current count
  echo "$key total = ".$journals[$key]."\n";
}
// close file
fclose($handle);




?>
