declare namespace functx = "http://www.functx.com";
declare function functx:path-to-node
  ( $nodes as node()* )  as xs:string* {

$nodes/string-join(ancestor-or-self::*[not(name()="TEI")]/name(.), '/')
 } ;
(: let $cr := doc("/home/neven/rad/croala-r/basex/txts/crijev-i-carm-1678.xml") :)
(: let $cr := doc("/home/neven/rad/croala-r/basex/txts/marul-mar-carmina.xml") :)
let $cr := doc("/home/neven/rad/croalapelagiosxml/marul-mar-carmina-nonote-noq.xml")
let $els := for $e in $cr//*:TEI/*:text//*
order by $e
return functx:path-to-node($e)
return distinct-values($els)