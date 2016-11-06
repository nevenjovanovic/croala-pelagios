module namespace test = 'http://basex.org/modules/xqunit-tests';

(: Are there seven entries in each record? :)
declare %unit:test function test:seven-entries () {
  for $r in db:open("cp-latlexents")//record
  return unit:assert-equals(count($r/entry[last()]/preceding-sibling::entry), 6)
};

declare %unit:test function test:nine-entries () {
  for $r in db:open("cp-latlexents","cp-croala-latlexents.xml")//record
  return unit:assert-equals(count($r/entry[last()]/preceding-sibling::entry), 8)
};

(: Does entry 1 start with urn:cts:croala: and is it unique? :)
(: Does entry 3 start with urn:cite:croala: and is it unique? :)
(: Does entry 5 start with urn:cite:croala:latmorph.morph. ? :)
(: Does entry 6 start with orcid.org/ ? :)
declare %unit:test function test:first-start () {
  let $r := collection("cp-latlexents")//record
  let $sum := for $rec in $r/entry[1][starts-with(text(),"urn:cite:")]
  return count($rec)
  return unit:assert-equals(sum($sum), count($r))
};

(: Test for uniqueness :)
declare %unit:test function test:unique-cts () {
  let $r := collection("cp-latlexents")//record
  let $ctsvalues := count(distinct-values($r/entry[1]))
  return unit:assert-equals($ctsvalues, count($r))
};


(: do we have an equal count of rows locally and on server? :)
declare %unit:test function test:local-web () {
  let $r := count(collection("cp-latlexents")//record)
  let $w := xs:integer(fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest/cp-latlexents?query=count(//record)"))
  return unit:assert-equals($r, $w)
};