module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../../repo/croalapelagios.xqm';
(: test reporting of lemmata :)

(: do we have a cp-cite-lemmata database? :)

declare %unit:test function test:db-cp-citelemmata-local () {
  unit:assert(db:exists("cp-cite-lemmata"))
};

(: is the db with lemmata online, is it older than the local one? :)

declare %unit:test function test:cp-citelemmata-online () {
  let $onlinedate := fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest?query=db:info('cp-cite-lemmata')//resourceproperties/timestamp/string()")
  let $dbdate := db:info("cp-cite-lemmata")//resourceproperties/inputdate/string()
  let $status := if (xs:dateTime($onlinedate) lt xs:dateTime($dbdate)) then "online older" else "online newer"
return 
  unit:assert-equals($status, "online newer")
};

(: do we have a function returning list of lemmata in the corpus and count of occurrences? :)

declare %unit:test function test:cp-grouplemmata-local () {
  unit:assert(cp:group_lemmata("corpus")//tbody[parent::table]/tr/td[2]/a/@href)
};

(: is the list of all lemmata online? :)

(: do we have a function returning list of lemmata and occurrences for individual documents? :)

(: is the list of all lemmata in document online? :)