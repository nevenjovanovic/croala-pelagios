(: XQuery module for Vitezovic :)
module namespace vit = 'http://croala.ffzg.unizg.hr/vit';
(: helper function for links :)
declare function vit:links0($urn, $text) {
  element a { 
attribute href { $urn },
$text }
};

(: helper function for node :)
(: make link to file in philologic :)
declare function vit:localnode ($db, $txtnode) { 
  attribute href { "/basex/node/" || $db || "/" || data($txtnode) } 

 };

(: helper function to return rows :)

declare function vit:rows2($td1 , $td2 ){

element tr { 
  element td { $td1 },
  element td { $td2 }
 }
};


(: helper function for header, with meta :)
declare function vit:htmlheadserver($title, $content, $keywords) {
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
</head>

};

(: vit:versecount = return counts of verse lines in Ovid and Vitezovic :)
declare function vit:versecount($collection) {
  (: How many verses in Riter Vitezović's letters? :)
let $textcounts := element table { for $text in collection($collection)//*:TEI
let $title := $text/*:teiHeader/*:fileDesc/*:titleStmt/*:title
let $versecount := count($text//*:text//*:l)
return vit:rows2(data($title), $versecount)
}
let $totalcount := sum(data($textcounts//tr/td[2]))
return element tbody { $textcounts//tr ,
element tr { 
element td { element em { "Omnes versus" } },
element td { $totalcount } }
}
};

(: group repeated 3-word clausulae, order by count of repetitions :)
declare function vit:group3 ($collection, $maincollection) {
  (: return three words at the end of Ovid's or Ritter's lines :)
(: group by repetitions, most of them first :)

let $cl3 := element claus {
for $aa in 
for $e in collection($collection)//*:v
return if (matches($e//text(), '[a-z]')) then element c { 
$e/@vid ,
$e/@target ,
ft:tokenize($e)[last() - 2] , ft:tokenize($e)[last() - 1] , ft:tokenize($e)[last()] }
else()
order by $aa
return $aa
}
let $versecount := count($cl3//c)
let $clbody := element span {
for $clausula in $cl3//c
let $text := $clausula/text()
group by $text
order by count($clausula/@vid) descending , $text
return element tr {
element td { $text } ,
element td { 
  for $id in $clausula/@vid 
  let $nodeid := data($id)
  return element a { 
  vit:localnode($maincollection,$nodeid),
  $nodeid }  }
}
}
let $uniqclcount := count($clbody//tr)
return element tbody { element tr { 
element td { "Clausulae " || $uniqclcount }, 
element td { "Versus " || $versecount }
} ,
$clbody
}
};