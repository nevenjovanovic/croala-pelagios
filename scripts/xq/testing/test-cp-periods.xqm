module namespace test = 'http://basex.org/modules/xqunit-tests';

(: do we have a cp-aetates database? :)

declare %unit:test function test:db-cp-aetates-local () {
  unit:assert(db:exists("cp-aetates"))
};

(: does it validate with cpplaces.rng? :)

declare %unit:test function test:cp-aetates-local-valid () {
  for $doc in db:open('cp-aetates')
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpperiods.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};

(: do we have a croala-pelagios/csv/cpplaces.xml file in the Github repo? :)
(: does it validate with cpplaces.rng? :)
declare %unit:test function test:cp-file-validates () {
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/cpperiods.xml"
  for $doc in doc($fileuri)
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpperiods.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};



(: is the cp-loci db younger than the cpplaces.xml file? :)
declare %unit:test function test:db-is-uptodate () {
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/cpperiods.xml"
  let $filedate := file:last-modified($fileuri)
  let $dbdate := db:info("cp-aetates")//databaseproperties/timestamp/string()
  let $status := if (xs:dateTime($dbdate) lt xs:dateTime($filedate)) then "db older than file" else "db newer than file"
return 
  unit:assert-equals($status, "db newer than file")
};

(: do we have a cp-loci database on server? :)
(: is it up to date? :)
declare %unit:test function test:cp-aetates-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-aetates')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-aetates")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};



(: do we have a page at citelocus/ZZZZZ? :)

declare %unit:test function test:citelocus-page-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/citeaetas/ZZZZZ")
  return unit:assert($doc//table/tbody/tr/td[1][.="Lemma deest in collectionibus nostris."])
};

(: do we have a tbody/tr/td result at citelocus/Mediolan? :)

declare %unit:test function test:citeaetas-table-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/citeaetas/Medieval")
  return unit:assert($doc//table/tbody/tr/td)
};

(: do we have a input field at citelocus/Mediolan? :)