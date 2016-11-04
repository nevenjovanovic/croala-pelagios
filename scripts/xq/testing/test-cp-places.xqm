module namespace test = 'http://basex.org/modules/xqunit-tests';

(: do we have a cp-loci database? :)

declare %unit:test function test:db-cp-loci-local () {
  unit:assert(db:exists("cp-loci"))
};

(: does it validate with cpplaces.rng? :)

declare %unit:test function test:cp-loci-local-valid () {
  for $doc in db:open('cp-loci')
  let $result := validate:rng-report($doc, '/home/neven/rad/croala-pelagios/schemas/cpplaces.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};

(: do we have a croala-pelagios/csv/cpplaces.xml file? :)
(: does it validate with cpplaces.rng? :)
declare %unit:test function test:cp-file-local-validates () {
  for $doc in doc("/home/neven/rad/croala-pelagios/csv/cpplaces.xml")
  let $result := validate:rng-report($doc, '/home/neven/rad/croala-pelagios/schemas/cpplaces.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};



(: is the cp-loci db younger than the cpplaces.xml file? :)
declare %unit:test function test:db-is-uptodate () {
  let $filedate := file:last-modified("/home/neven/rad/croala-pelagios/csv/cpplaces.xml")
  let $dbdate := db:info("cp-loci")//databaseproperties/timestamp/string()
  let $status := if (xs:dateTime($dbdate) lt xs:dateTime($filedate)) then "older" else "newer"
return 
  unit:assert-equals($status, "newer")
};

(: do we have a cp-loci database on server? :)
(: is it up to date? :)
declare %unit:test function test:cp-loci-online () {
  let $r := count(collection("cp-latlexents")//record)
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-loci')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-loci")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "older" else "newer"
return 
  unit:assert-equals($status, "newer")
};



(: do we have a page at citelocus/ZZZZZ? :)

declare %unit:test function test:citelocus-page-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/citelocus/ZZZZZ")
  return unit:assert($doc//table/tbody/tr/td)
};

(: do we have a tbody/tr/td result at citelocus/Mediolan? :)

declare %unit:test function test:citelocus-table-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/citelocus/Mediolan")
  return unit:assert($doc//table/tbody/tr/td)
};

(: do we have a input field at citelocus/Mediolan? :)