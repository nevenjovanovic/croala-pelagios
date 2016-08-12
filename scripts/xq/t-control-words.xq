(: compare word counts in documents to control for loss :)
declare function local:doccount($doc) {
  let $counts :=
for $d in $doc//*:text//*:div[not(*:div)]//text()
let $t := ft:tokenize($d)
return count($t)
return sum($counts)
};
let $file := "/home/neven/rad/croala-pelagios/editions/XML/tubero-commentarii-rezar-paragraphi.xml"
let $dbfile := "tubero-commentarii-rezar-p-s-w-n.xml"
for $doc in (doc($file), db:open("tubero-commentarii", $dbfile))
return element count { local:doccount($doc) }