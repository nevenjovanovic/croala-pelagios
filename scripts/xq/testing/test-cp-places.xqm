module namespace test = 'http://basex.org/modules/xqunit-tests';

(: do we have a cp-loci database? :)

declare %unit:test function test:db-cp-loci-local () {
  unit:assert(db:exists("cp-loci"))
};

(: does it validate with cpplaces.rng? :)

declare %unit:test function test:cp-loci-local-valid () {
  for $doc in db:open('cp-loci')
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};

(: do we have a croala-pelagios/csv/cpplaces2.xml file in the Github repo? :)
(: does it validate with cpplaces.rng? :)
declare %unit:test function test:cp-file-validates () {
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cpplaces2.xml"
  for $doc in doc($fileuri)
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpplaces.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};



(: is the cp-loci db younger than the cpplaces.xml file? :)
declare %unit:test function test:db-is-uptodate () {
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cpplaces2.xml"
  let $filedate := file:last-modified($fileuri)
  let $dbdate := db:info("cp-loci")//databaseproperties/timestamp/string()
  let $status := if (xs:dateTime($dbdate) lt xs:dateTime($filedate)) then "db older than file" else "db newer than file"
return 
  unit:assert-equals($status, "db newer than file")
};

(: do we have a cp-loci database on server? :)
(: is it up to date? :)
declare %unit:test function test:cp-loci-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-loci')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-loci")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};



(: do we have a page at citelocus/ZZZZZ? :)

declare %unit:test function test:citelocus-page-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/citelocus/ZZZZZ")
  return unit:assert($doc//table/tbody/tr/td[1][.="URN deest in collectionibus nostris."])
};

(: do we have a tbody/tr/td result at citelocus/Mediolan? :)

declare %unit:test function test:citelocus-table-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/citelocus/Mediolan")
  return unit:assert($doc//table/tbody/tr/td)
};

(: do we have a input field at citelocus/Mediolan? :)