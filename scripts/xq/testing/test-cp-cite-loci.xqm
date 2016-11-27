module namespace test = 'http://basex.org/modules/xqunit-tests';
(: test database with identifications of places for individual segments :)
(: do we have a cp-cite-loci database? :)

declare %unit:test function test:db-cp-cite-loci-local () {
  unit:assert(db:exists("cp-cite-loci"))
};

(: does it validate with cpciteloci-record.rng? :)

declare %unit:test function test:cp-cite-loci-local-valid () {
  for $doc in db:open('cp-cite-loci')
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpciteloci-record.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};

(: does it point at appropriate segments of texts? :)

(: does it point at appropriate places? :)

(: do we have a croala-pelagios/csv/loci/cp-cite-loci.xml file in the Github repo? :)
(: does it validate with cpplaces.rng? :)
declare %unit:test function test:cp-file-validates () {
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cp-cite-loci.xml"
  for $doc in doc($fileuri)
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cpciteloci-record.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};



(: is the cp-cite-loci db newer than the cpplaces.xml file? :)
declare %unit:test function test:db-is-uptodate () {
  let $fileuri := substring-before(file:base-dir(), 'scripts/') || "csv/loci/cite-loci.xml"
  let $filedate := file:last-modified($fileuri)
  let $dbdate := db:info("cp-cite-loci")//databaseproperties/timestamp/string()
  let $status := if (xs:dateTime($dbdate) lt xs:dateTime($filedate)) then "db older than file" else "db newer than file"
return 
  unit:assert-equals($status, "db newer than file")
};

(: do we have a cp-cite-loci database on server? :)
(: is it up to date? :)
declare %unit:test function test:cp-cite-loci-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-cite-loci')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-cite-loci")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};



(: do we have a page at cite-loci? :)

declare %unit:test function test:citeloci-page-exists (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cite-loci")
  return unit:assert($doc//table/tbody/tr/td[1])
};

(: does the urn field have a input element ? :)

declare %unit:test function test:citeloci-link-uri (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cite-loci")
  return unit:assert($doc//table/tbody/tr/td[3]/a[@href])
};

declare %unit:test function test:citeloci-input (){
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cite-loci")
  return unit:assert($doc//table/tbody/tr/td[1]/input)
};
