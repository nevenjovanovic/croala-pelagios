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

declare function local:locus_lemma() {
let $join_locus_lemma := element list {
let $set := (collection("cp-cite-lemmata-2"), collection("cp-cite-loci"))
for $record in $set//record
let $citeurn := $record/citeurn
group by $citeurn
where $record/citelocus and $record/citelemma
return element r { 
$record/citelocus, 
$record/citelemma }
}
let $loci := element l {
for $r in $join_locus_lemma//r
let $locus := $r/citelocus
group by $locus
return element l {
  element citelocus { $locus } ,
  $r/citelemma
}
}
let $la := element result {
for $l in $loci//l
where $l/citelemma[2] and $l/citelocus[text()]
return element tr  {
  element td {
    local:simple_link(
      "http://croala.ffzg.unizg.hr/basex/cite/" || $l/citelocus/string() ,
local:label("cp-loci" , $l/citelocus/string())
) } , 
element td {
for $a in distinct-values($l/citelemma)
return element citelemma { 
local:simple_link("http://croala.ffzg.unizg.hr/basex/cite/" || $a , local:label2("cp-latlexents" , $a)) }
 } }
} 
for $lar in $la//tr
where $lar/td[2]/citelemma[2]
let $c := count($lar/td[2]/citelemma)
order by $c descending
return $lar 
};
local:locus_lemma()