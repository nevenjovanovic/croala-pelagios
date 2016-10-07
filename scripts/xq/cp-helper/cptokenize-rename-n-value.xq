declare default element namespace "http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:substring-after-last
  ( $arg ,
    $delim ) {

   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;
 declare function functx:escape-for-regex
  ( $arg as xs:string? )  as xs:string {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
for $p in collection("cp-tokenize")//*:text//*[@n]
let $newn := functx:substring-after-last($p/@n, '.')
return replace value of node $p/@n with $newn