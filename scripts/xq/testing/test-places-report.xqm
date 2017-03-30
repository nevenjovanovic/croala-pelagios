module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';
(: test reporting of place identifications :)

(: do we have a cp-cite-loci database? :)

declare %unit:test function test:db-cp-citeloci-local () {
  unit:assert(db:exists("cp-cite-loci"))
};


(: do we have a cp-loci database? :)

declare %unit:test function test:db-cp-loci-local () {
  unit:assert(db:exists("cp-loci"))
};

(: is the db with places online, is it older than the local one? :)

declare %unit:test function test:cp-citeloci-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-cite-loci')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-cite-loci")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};

(: is the db with place identifications online, is it older than the local one? :)

declare %unit:test function test:cp-loci-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-loci')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-loci")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};

(: How many distinct places? How many mentions of places in our texts? :)
(: Output a row: DISTINCT PLACES - corpus, each text :)

declare %unit:test function test:count-distinct-places-local () {
  unit:assert(cp:report_count_places())
};

(: Which places are mentioned, how many times? In whole corpus, in individual text? :)

(: Is the page with indices online? :)

declare %unit:test function test:index-places-online () {
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cp-loci-id/corpus")
  return unit:assert($doc)
};

declare %unit:test function test:index-places-doc-online () {
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cp-loci-id/urn:cts:croala:bunic02.croala1761880.croala-lat2w")
  return unit:assert($doc)
};

(: Index of mentions of a place in a text (or in the whole corpus)? :)