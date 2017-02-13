declare function local:simple_link($link, $word){
  element a {
    attribute href { $link },
    $word
  }
};

declare function local:label($collection , $citeurn){
  let $l := collection($collection)//record[citebody/@citeurn=$citeurn]
  return $l/label/string()
};

declare function local:label2($collection , $citeurn){
  let $l := collection($collection)//record[lemma/@citeurn=$citeurn]
  return $l/lemma/string()
};

declare function local:label3($collection , $citeurn){
  let $l := collection($collection)//w[@locusurn=$citeurn]
  return $l/@ana/string()
};


declare function local:locus_estlocus() {
let $join_locus_lemma := element list {
let $set := (collection("cp-cite-estlocus"), collection("cp-cite-loci"))
for $record in $set//record
let $citeurn := $record/ctsurn
group by $citeurn
where $record/citelocus and $record/locusurn
return element r { 
$record/citelocus, 
$record/locusurn }
}
let $loci := element l {
for $r in $join_locus_lemma//r
let $locus := $r/citelocus
group by $locus
return element l {
  element citelocus { $locus } ,
  $r/locusurn
}
}
let $la := element result {
for $l in $loci//l
where $l/locusurn[2] and $l/citelocus[text()]
return element tr  {
  element td {
    local:simple_link(
      "http://croala.ffzg.unizg.hr/basex/cite/" || $l/citelocus/string() ,
local:label("cp-loci" , $l/citelocus/string())
) } , 
element td {  
  for $d in distinct-values(
    for $locus in $l/locusurn
    return element locusurn { local:label3("cp-cite-urns", $locus) } )
  return element locusurn { $d } }
 } 
} 
for $lar in $la//tr
where $lar/td[2]/locusurn[2]
let $c := count($lar/td[2]/locusurn)
order by $c descending
return $lar 
};
local:locus_estlocus()