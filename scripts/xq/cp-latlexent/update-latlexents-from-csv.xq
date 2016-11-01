declare function local:e($e){
  element entry { data($e) }
};
declare function local:check($a, $b) {
  if ($a/text()=$b) then local:e($a) else "ERROR!"
};
let $csv := file:read-text("/home/neven/rad/croalapelagiosxml/oznaceno/cp-croala-latlexents-novi.csv")
let $result := element csv {
for $parsed in csv:parse($csv, map { 'header': true() })//record
let $cite := local:e($parsed/CITE_URN)
let $lemma := local:e($parsed/Latin_lemma)
let $shortdef := local:e($parsed/Short_description)
let $createdby := $parsed/Created_by
let $createdon := $parsed/Created_on
return element record {
  $cite ,
  $lemma ,
  $shortdef ,
  element entry {"proposed"},
  element entry {},
  local:e(normalize-space(replace($createdby, 'http://', ''))) ,
  element entry {},
  local:e($createdon),
  element entry {}
}
}
for $r in $result//record
let $db := db:open("cp-latlexents", "cp-croala-latlexents.xml")//csv/record
where $r[entry[1][not(text()=$db/entry[1]/text())]]
return insert node $r as last into $db/..