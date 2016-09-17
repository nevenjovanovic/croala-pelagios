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
(: copy $cr := doc("/home/neven/rad/croala-r/basex/txts/crijev-i-carm-1678.xml") :)
copy $cr := doc("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-w.xml")
modify for $e in $cr//*:TEI/*:text//*
let $n := functx:path-to-node-with-pos($e)
return if ($e/@n) then replace value of node $e/@n with $n
else insert node attribute n { $n } into $e
return file:write("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-w-n.xml", $cr)