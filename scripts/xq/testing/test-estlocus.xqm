module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';
(: test database with assertions of place denotations :)
(: test function reporting assertions of place denotations :)
(: do we have a cp-cts-2 database? :)

declare %unit:test function test:db-cp-cts-local () {
  unit:assert(db:exists("cp-2-texts"))
};

(: do we have a function returning total of all estlocus? :)
declare %unit:test function test:db-estlocus-grand-total () {
  unit:assert(xs:integer(cp:estlocus_grand_tot(db:open("cp-2-texts"))//td[2][parent::tr]/string()))
};


(: do we have a function returning totals of different estlocus values? :)

declare %unit:test function test:db-cp-cts-totals () {
  for $s in cp:estlocus_tot(db:open("cp-2-texts"), ())//tbody/tr/td[2]/a/string() return 
  unit:assert(xs:integer($s))
};

declare %unit:test function test:db-cp-cts-totals-link () {
  for $s in cp:estlocus_tot(db:open("cp-2-texts"), "corpus")//tbody/tr/td[2]/a/@href return 
  unit:assert(starts-with($s, "http://croala.ffzg.unizg.hr/basex/cp-loci/corpus/estlocus"))
};

(: do we have a function returning totals of estlocus by work? :)

(: do we have a function returning index of CTS URNs with estlocus values? :)

(: do we have a page with totals of estlocus? :)

declare %unit:test function test:estlocus-page(){
  unit:assert(doc("http://croala.ffzg.unizg.hr/basex/cp-estlocus-omnes"))
};

(: is the texts db on server up to date? :)

declare %unit:test function test:cp-texts-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-2-texts')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-2-texts")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};

(: is the cts urn db on server up to date? :)

declare %unit:test function test:cp-ctsurn-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-cts-urns')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-cts-urns")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};

(: does the page have an explanation of estlocus values? :)

(: do we have a page with totals of estlocus by works? :)

