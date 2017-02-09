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
let $join_locus_aetas := element list {
let $set := (collection("cp-cite-aetates"), collection("cp-cite-loci"))
for $record in $set//record
let $citeurn := $record/citeurn
group by $citeurn
where $record/citelocus and $record/citeaetas
return element r { 
$record/citelocus, 
$record/citeaetas }
}
let $loci := element l {
for $r in $join_locus_aetas//r
let $locus := $r/citelocus
group by $locus
return element l {
  element citelocus { $locus } ,
  $r/citeaetas
}
}
let $la := element result {
for $l in $loci//l
where $l/citeaetas[2] and $l/citelocus[text()]
return element tr  {
  element td {
    local:simple_link(
      "http://croala.ffzg.unizg.hr/basex/cite/" || $l/citelocus/string() ,
local:label("cp-loci" , $l/citelocus/string())
) } , 
element td {
for $a in distinct-values($l/citeaetas)
return element citeaetas { 
local:simple_link("http://croala.ffzg.unizg.hr/basex/cite/" || $a , local:label("cp-aetates" , $a)) } } }
}
for $lar in $la//tr
where $lar/td[2]/citeaetas[2]
let $c := count($lar/td[2]/citeaetas)
order by $c descending
return $lar