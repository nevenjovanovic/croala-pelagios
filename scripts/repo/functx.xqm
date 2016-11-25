module namespace functx = "http://www.functx.com";

declare function functx:escape-for-regex
  ( $arg ) {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
 
declare function functx:substring-after-last
  ( $arg ,
    $delim ) {

   replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;
 
 declare function functx:substring-before-last
  ( $arg ,
    $delim ) {

   if (matches($arg, functx:escape-for-regex($delim)))
   then replace($arg,
            concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
   else ''
 } ;
