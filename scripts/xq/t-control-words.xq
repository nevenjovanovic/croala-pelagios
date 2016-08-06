(: compare word counts in documents to control for loss :)
declare function local:doccount($doc) {
  let $counts :=
for $d in $doc//*:text//*:div[not(*:div)]//text()
let $t := ft:tokenize($d)
return count($t)
return sum($counts)
};
for $doc in (doc("/home/neven/rad/croala-pelagios/editions/XML/tubero-commentarii-rezar-paragraphi.xml"), db:open("tubero-commentarii"))
return element count { local:doccount($doc) }