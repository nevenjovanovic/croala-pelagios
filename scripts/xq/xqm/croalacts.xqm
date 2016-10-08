module namespace cts = "http://croala.ffzg.unizg.hr/cts";
import module namespace functx = "http://www.functx.com" at "functx.xqm";
declare namespace ti = "http://chs.harvard.edu/xmlns/cts";


(: list all available CTS URNs of text elements :)
declare function cts:getcapabilities(){
  let $tbody := element tbody {
  for $t in collection("croala-cts-1")//*:TEI/*:text
let $urn := $t/@xml:base/string()
for $node in $t//*
let $cts := $urn || $node/@n/string()
let $href := "http://croala.ffzg.unizg.hr/basex/cts/" || $cts
return element tr {
  element td {
    element a { 
    attribute href { $href} , 
    $cts }
  }
}
}
return $tbody
};

(: list available textgroups as rows and cells :)
declare function cts:listtextgroupurns () {
  for $tg in collection("croala-cts-1")//ti:textgroup
  let $groupurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/" || $tg/@urn/string() } , 
    $tg/@urn/string() 
  }
  let $grouplabel := string-join(
    for $a in $tg/ti:groupname/* 
    return normalize-space(data($a)), '; '
  )
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctsconglomeratio/" || $groupurn
  let $groupcount := element a { 
  attribute href { $editionhref } ,
  count(collection("croala-cts-1")//ti:work[@groupUrn=$groupurn]) }
  order by $grouplabel collation "?lang=hr"
  return element tr { 
    element td {$grouplabel},
    element td {$groupurn},
    element td { $groupcount }
     }
};

(: Make a table displaying available textgroups :)
(: Label, CTS URN, count of available works :)
(: CTS URN of textgroup links to a list of works :)
(: and to the first edition available? :)
(: count of works links to available works :)
declare function cts:gettextgroups(){
  let $table := 
  let $dbname := "croala-cts-1"
  let $dateupdated := db:info($dbname)//databaseproperties/timestamp/string()
  let $head := cts:tablecaption("Textgroups" , $dbname, $dateupdated)
  let $label := "Label"
  let $ctsurn := "CTS URN"
  let $count := "Available works"
  let $theadrow := cts:returnheadrow($label, $ctsurn, $count)
  let $textgroupurns := cts:listtextgroupurns()
  return cts:returntable($head, $theadrow, $textgroupurns )
  return $table
};

(: from a CTS URN, retrieve a single passage :)
declare function cts:getpassage($ctsurn) {
  let $edition := functx:substring-before-last($ctsurn, ":") || ":"
  let $path := functx:substring-after-last($ctsurn, ":")
  return collection("croala-cts-1")//*:text[@xml:base=$edition]//*[@n=$path]
};

(: list available works :)

declare function cts:getworks($workurn1){
  let $dbname := "croala-cts-1"
  let $dateupdated := db:info($dbname)//databaseproperties/timestamp/string()
  let $head := if ($workurn1="index") then cts:tablecaption("Works" , $dbname, $dateupdated) else let $frbr := $workurn1 || ": works" return cts:tablecaption($frbr, $dbname, $dateupdated)
  let $label := "Label"
  let $ctsurn := "CTS URN"
  let $count := "Editions available"
  let $theadrow := cts:returnheadrow($label, $ctsurn, $count)
  let $urnlist := cts:listworkurns ($workurn1)
  return cts:returntable($head, $theadrow, $urnlist )
};

declare function cts:returntable($head, $theadrow, $urnlist ) {
  let $table :=
  element table {
    attribute class {"table-striped table-hover table-centered"},
    element caption { $head },
    element thead {
   $theadrow
    },
    element tbody {
      $urnlist
    }
  }
  return $table
};

declare function cts:tablecaption($frbr, $dbname, $date){
  let $head := $frbr || " available in CroALa db " || $dbname || ", updated on " || $date
  return $head
};

declare function cts:returnheadrow($label, $ctsurn, $count){
  element tr { 
    element td { $label }, 
    element td { $ctsurn }, 
    element td { $count }
  }
};

(: list available works as rows and cells :)
declare function cts:listworkurns ($groupurn1) {
  if ($groupurn1="index") then 
  for $tg in collection("croala-cts-1")//ti:work
  let $workurnstring := $tg/@urn/string()
  let $workurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctsopus/" || $workurnstring } , 
    $workurnstring 
  }
  let $worklabel := string-join(
    for $a in $tg/ti:title
    return normalize-space(data($a)), '; '
  )
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctsopus/" || $workurnstring
  let $editioncount := element a { 
  attribute href { $editionhref } ,
  count(collection("croala-cts-1")//ti:edition[@workUrn=$workurnstring]) }
  order by $worklabel collation "?lang=hr"
  return element tr { 
    element td {$worklabel},
    element td {$workurn},
    element td { $editioncount }
     }
 else
  for $tg in collection("croala-cts-1")//ti:work[@groupUrn=$groupurn1]
  let $workurnstring := $tg/@urn/string()
  let $workurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctsopus/" || $workurnstring } , 
    $workurnstring 
  }
  let $worklabel := string-join(
    for $a in $tg/ti:title
    return normalize-space(data($a)), '; '
  )
  let $editionhref := "http://croala.ffzg.unizg.hr/basex/ctsopus/" || $workurn
  let $editioncount := element a { 
  attribute href { $editionhref } ,
  count(collection("croala-cts-1")//ti:edition[@workUrn=$workurn]) }
  order by $worklabel collation "?lang=hr"
  return element tr { 
    element td {$worklabel},
    element td {$workurn},
    element td { $editioncount }
     }
};

declare function cts:geteditions($workcts){
  let $dbname := "croala-cts-1"
  let $dateupdated := db:info($dbname)//databaseproperties/timestamp/string()
  let $head := if ($workcts="index") then cts:tablecaption("Editions" , $dbname, $dateupdated) else let $frbr := $workcts || ", editions" return cts:tablecaption($frbr, $dbname, $dateupdated)
  let $label := "Label"
  let $ctsurn := "CTS URN"
  let $count := "Nodes available"
  let $theadrow := cts:returnheadrow($label, $ctsurn, $count)
  let $urnlist := cts:listeditionurns ($workcts)
  return cts:returntable($head, $theadrow, $urnlist )
};

declare function cts:listeditionurns ($workcts) {
   if ($workcts="index") then 
  for $tg in collection("croala-cts-1")//ti:edition
  let $editionurnstring := $tg/@urn/string()
  let $nodesurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctseditio/" || $editionurnstring } , 
    $editionurnstring 
  }
  let $editionlabel := string-join(
    for $a in $tg/ti:label
    return normalize-space(data($a)), '; '
  )
  let $nodeshref := "http://croala.ffzg.unizg.hr/basex/ctseditio/" || $editionurnstring
  let $editionurnstring1 := $editionurnstring || ":"
  let $nodecount := element a { 
  attribute href { $nodeshref } ,
  count(collection("croala-cts-1")//*:text[@xml:base=$editionurnstring1 ]//*) }
  order by $editionlabel collation "?lang=hr"
  return element tr { 
    element td {$editionlabel},
    element td { $nodesurn },
    element td { $nodecount }
     }
 else if (collection("croala-cts-1")//ti:edition[@workUrn=$workcts]) then
  for $tg in collection("croala-cts-1")//ti:edition[@workUrn=$workcts]
  let $editionurnstring := $tg/@urn/string()
  let $nodesurn := element a { 
    attribute href { 
    "http://croala.ffzg.unizg.hr/basex/ctseditio/" || $editionurnstring } , 
    $editionurnstring 
  }
  let $editionlabel := string-join(
    for $a in $tg/ti:label
    return normalize-space(data($a)), '; '
  )
  let $nodeshref := "http://croala.ffzg.unizg.hr/basex/ctseditio/" || $editionurnstring
  let $editionurnstring1 := $editionurnstring || ":"
  let $nodecount := element a { 
  attribute href { $nodeshref } ,
  count(collection("croala-cts-1")//*:text[@xml:base=$editionurnstring1 ]//*) }
  order by $editionlabel collation "?lang=hr"
  return element tr { 
    element td {$editionlabel},
    element td {$nodesurn },
    element td { $nodecount }
     } 
     else
     let $message := element tr { 
    element td { "URN deest in collectione." }
     } 
     return $message
};

(: for a CTS edition URN, return list of nodes available :)
declare function cts:getnodes ($urn){
  let $dbname := "croala-cts-1"
  let $dateupdated := db:info($dbname)//databaseproperties/timestamp/string()
  let $urn1 := $urn || ":"
  let $head := if (collection($dbname)//*:text[matches(@xml:base, $urn1)]) then cts:tablecaption("Edition " || $urn || "; text nodes" , $dbname, $dateupdated) else element caption { "CTS URN deest in collectione." }
  let $theadrow := cts:returnheadrow("Nodus CTS URN", (), ())
  let $urnlist := cts:listnodesurns($urn1)
  return cts:returntable($head, $theadrow, $urnlist )
};

declare function cts:listnodesurns($editionurn){
  for $node in collection("croala-cts-1")//*:text[matches(@xml:base, $editionurn)]//*
  let $ctsurn := $node/@n/string()
  return element tr {
    element td {
      element a {
        attribute href {"http://croala.ffzg.unizg.hr/basex/cts/" || $editionurn || $ctsurn },
        $editionurn || $ctsurn
      }
    }
  }
};