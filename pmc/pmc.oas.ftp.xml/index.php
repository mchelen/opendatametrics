<?php
/*
 * Downloads compressed XML archives from PMC FTP
 * Extracts archives
 * Stores archive structure in text file
 * Save PMC IDs and paths into XML
 */
  // list of xml files
  $sourcefile = "output/pmc.ftp.articles.xml.list.tsv";
  $outputfile = "output/pmc.ftp.articles.xml.list.xml";

  $myarray = array();

  // read file
  print "loading $sourcefile\n";
  $lines = file($sourcefile);
  foreach ($lines as $line) {
    // match PMC id
    preg_match('/[0-9]+\.nxml$/', $line,$matches);
    // pull out pmc id from regex match
    $pmcid = substr($matches[0],0,strlen($matches[0])-5);
    // match file path
    preg_match('/[^\.]+\.nxml$/', $line,$matches);
    $filepath = $matches[0];
    // add to array
    $myarray[$pmcid] = $filepath;
  }

// build xml


$xmlstr = <<<XML
<?xml version='1.0'?>
<root>
<node>test</node>
</root>
XML;

// new xml
print "Building xml \n";
$sxe = new SimpleXMLElement($xmlstr);

foreach ($myarray as $key => $value) {
  // add pmc child with the path as value
//  print "Path: $value\n";
  $pmc = $sxe->addChild('pmc',$value);
  // add attribute with the pmc id as id
//  print "PMC ID: $key\n";
  $pmc->addAttribute('id',$key);
}

print "Saving xml to file $outputfile \n";

$sxe->asXML($outputfile);


?>
