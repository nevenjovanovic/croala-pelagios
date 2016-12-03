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

declare %unit:test function test:cp-grouplemmata-online () {
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cp-cite-lemmata/corpus")
  return unit:assert($doc//tbody[parent::table]/tr/td[2]/a/@href)
};

(: does it work for a single document? :)

declare %unit:test function test:cp-grouplemmata-online-doc () {
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cp-cite-lemmata/urn:cts:croala:crije01.croala789994.croala-lat2w")
  return unit:assert($doc//tbody[parent::table]/tr/td[2]/a/@href)
};

(: does it return a message for an non-existent URN? :)

declare %unit:test function test:cp-grouplemmata-online-error () {
  let $doc := doc("http://croala.ffzg.unizg.hr/basex/cp-cite-lemmata/ZZZZZZZ")
  return unit:assert($doc//tbody[parent::table]/tr/td/b/text())
};

(: do we have a function returning count of lemmata, count of lemmatized words for the corpus and for each document? :)


(: do we have the function for counts online? :)


(: do we have a function returning list of lemmata and occurrences for individual documents? :)

declare %unit:test function test:cp-indexlemmata-local () {
  unit:assert(cp:index_lemmata("urn:cts:croala:bunic02.croala1761880.croala-lat2w","urn:cite:croala:latlexent.lex515444058")//tbody[parent::table]/tr/td[2]/a/@href)
};

(: is the list of all lemmata in document online? :)