(: make node quickly :)
declare function local:td($node) {
  element td {
    data($node)
  }
};
(: pretty printing of CTS URN list :)
(: send to /$domain/$urn, where the CITE body or CTS is displayed :)
declare function local:prettycitebody($citeadr, $domain) {
  element td {
    element a { 
    attribute href { "http://croala.ffzg.unizg.hr/basex/" || $domain || $citeadr } , 
    data($citeadr) }
  }
};
(: list CITE URNs linking to their bodies, and their CTS equivalents :)
declare function local:citelist(){
let $citedb := collection("cp-cts-cite-idx")
let $citelistbody := element tbody { for $r in $citedb//record
let $ctsurn := local:prettycitebody($r/entry[4], "cts/")
let $citeurn := local:prettycitebody($r/entry[5], "cite/")
let $label := local:td($r/entry[2])
let $citeanaex := element td { "CITE Analytical exemplar" }
return element tr {
  $label , $citeurn , $ctsurn
}
}
return $citelistbody
};
local:citelist()