module namespace cite = "http://croala.ffzg.unizg.hr/cite";
import module namespace functx = "http://www.functx.com" at "functx.xqm";
declare namespace ti = "http://chs.harvard.edu/xmlns/cts";

(: helper function for header, with meta :)
declare function cite:htmlheadtsorter($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, CroALa" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/basexc.css"/>
<script src='/basex/static/dist/js/tablesort.min.js'></script>
<script>
  new Tablesort(document.getElementById('sort'));
</script>
</head>

};


declare function cite:validate-cts($cts){
  let $result :=
    if (matches($cts, "urn:cts:croala:[a-z0-9.\-]+:[a-z0-9.\-]+$")) then true()
    else if  (matches($cts, "urn:cts:croala:[a-z0-9.\-]+$")) then true()
    else false()
  return $result
};

declare function cite:validate-cite($cite){
  let $result :=
    if (matches($cite, "urn:cite:croala:[a-z0-9.]+[0-9]+$")) then true()
    else if  (matches($cite, "^[A-Z][a-z]+$")) then true()
    else false()
  return $result
};

declare function cite:urn-exists($urn){
    
  if (starts-with($urn, "urn:cts:croala:")) then 
     if (collection("cp-cts-urns")//w[@n=$urn]) then collection("cp-cts-urns")//w[@n=$urn]/@xml:id/string()
     else "URN deest in collectionibus nostris."
     
  else if (starts-with($urn, "urn:cite:croala:loci")) then 
    if (collection("cp-cite-urns")//w[@citeurn=$urn]) then collection("cp-cite-urns")//w[@citeurn=$urn]
    else "URN deest in collectionibus nostris."
    
  else if (matches($urn, "^[A-Z]")) then 
    if (collection("cp-loci")//w[label=$urn]) then collection("cp-loci")//w[label=$urn]/citebody/string()
    else  "URN deest in collectionibus nostris."
    
  else if (starts-with($urn, "urn:cite:croala:latlexent.") or starts-with($urn, "urn:cite:perseus:latlexent.")) then
    if (collection("cp-latlexents")//record[entry[1]=$urn]) then collection("cp-latlexents")//record[entry[1]=$urn]/entry[2]
    else "URN deest in collectionibus nostris."
  else if ($urn=()) then "URN deest in collectionibus nostris."
  else "URN deest in collectionibus nostris."
};

declare function cite:geturn($urn) {
  element table {
    element thead {
      element tr {
        element td { "URN"},
        element td { "Name"},
        element td { "Short definition"}
      }
    },
    element tbody {
let $dbs := (collection("cp-latlexents"), collection("cp-latmorph"))
for $r in $dbs//record
let $id := generate-id($r)
where $r/entry[1][string()=$urn]
return element tr {
  element td { cite:input-field($id, $r) },
  element td { $r/entry[2]/string() },
  element td { $r/entry[3]/string() }
}
}
}
};

declare function cite:queryname ($q) {
  let $dbs := (collection("cp-latlexents"))
  let $list := $dbs//record
  let $result := $list[entry[2][matches(string(), '^' || $q )]]
  return if ($result) then
  element table {
    element thead {
      element tr {
        element td { "URN"},
        element td { "Name"},
        element td { "Short definition"}
      }
    },
    element tbody {

for $r in $result
let $id := generate-id($r)
return element tr {
  element td { 
    cite:input-field($id, $r)
    },
  element td { $r/entry[2]/string() },
  element td { $r/entry[3]/string() }
}
}
}
else element p { "Nomen deest in collectionibus nostris." }
};

declare function cite:input-field($id, $r){
  element input { 
      attribute size { "45"},
      attribute id { $id },
      attribute value { $r/entry[1]/string() } } , 
    element button { 
      attribute class { "btn" } ,
      attribute aria-label { "Recordare!"},
      attribute data-clipboard-target { "#" || $id },
      element span { 
        attribute class { "glyphicon glyphicon-copy"},
        attribute aria-hidden {"true"},
        attribute aria-label { "Recordare!" }
      }
    }
};

declare function cite:listlemmata(){
for $r in collection("cp-cite-lemmata")//record
  let $citeurn := $r/entry[3]
  let $word := $r/entry[2]
  let $lemma := $r/entry[4]
  let $lemmaurn := $r/entry[5]
  return
  element tbody {
    element tr {
      element td { $citeurn/string() },
      element td { $word/string() },
      element td { $lemma/string() },
      element td { $lemmaurn/string() }
    }
  }
};