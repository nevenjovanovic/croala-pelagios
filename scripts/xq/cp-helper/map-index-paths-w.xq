declare namespace functx = "http://www.functx.com";
declare function functx:index-of-node
  ( $nodes as node()* ,
    $nodeToFind as node() )  as xs:integer* {

  for $seq in (1 to count($nodes))
  return $seq[$nodes[$seq] is $nodeToFind]
 } ;
declare function functx:path-to-node-with-pos
  ( $node as node()? )  as xs:string {

string-join(
  for $ancestor in $node/ancestor-or-self::*[not(name()="TEI")]
  let $sibsOfSameName := $ancestor/../*[name() = name($ancestor)]
  return concat(name($ancestor),
   if (count($sibsOfSameName) <= 1)
   then ''
   else functx:index-of-node($sibsOfSameName,$ancestor))
 , '.')
 } ;
 (: let $doc := "/home/neven/rad/croalapelagiosxml/crijev-i-carm-1678-w.xml" :)
 (: let $doc := "/home/neven/rad/croala-r/basex/txts/marul-mar-carmina.xml" :)
copy $cr := doc("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-w.xml")
modify for $e in $cr//*:text//*[not(@n)]
let $n := functx:path-to-node-with-pos($e)
return insert node attribute n { $n } into $e
return $cr