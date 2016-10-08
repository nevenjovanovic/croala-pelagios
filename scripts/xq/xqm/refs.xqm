module namespace refs = "http://www.refs.com";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare %updating function refs:addrefs($collection){
  for $f in collection($collection)/*:TEI/*:teiHeader
  let $node := element tei:refsDecl {
    attribute n { "CTS" }
  }
  return insert node $node into $f/*:encodingDesc
};

declare function refs:calldb($collection){
  
};