module namespace test = 'http://basex.org/modules/xqunit-tests';

(: Are there nine entries in each record? :)
declare %unit:test function test:nine-entries () {
  for $r in collection("cp-cite-lemmata")//record
  return unit:assert-equals(count($r/entry[last()]/preceding-sibling::entry), 8)
};

(: Does entry 1 start with urn:cts:croala: and is it unique? :)
(: Does entry 3 start with urn:cite:croala: and is it unique? :)
(: Does entry 5 start with urn:cite:croala:latmorph.morph. ? :)
(: Does entry 6 start with orcid.org/ ? :)
declare %unit:test function test:first-start () {
  let $r := collection("cp-cite-lemmata")//record
  let $sum := for $rec in $r[entry[3][starts-with(text(),"urn:cite:croala:")] and entry[5][starts-with(text(),"urn:cite:")] and entry[6][starts-with(text(),"orcid.org/")]]/entry[1][starts-with(text(),"urn:cts:croala:")]
  return count($rec)
  return unit:assert-equals(sum($sum), count($r))
};

(: Test for uniqueness :)
declare %unit:test function test:unique-cts () {
  let $r := collection("cp-cite-lemmata")//record
  let $ctsvalues := count(distinct-values($r/entry[1]))
  return unit:assert-equals($ctsvalues, count($r))
};

declare %unit:test function test:unique-cite () {
  let $r := collection("cp-cite-lemmata")//record
  let $ctsvalues := count(distinct-values($r/entry[3][matches(text(), "^urn:cite:croala:loci\.ana\.[0-9]+$")]))
  return unit:assert-equals($ctsvalues, count($r))
};

(: Is entry 8 a date? :)
declare %unit:test function test:entry-date () {
  for $r in collection("cp-cite-morphs")//record/entry[8]
  let $date := try { xs:date($r/string()) } catch  * { "Nije datum!" }
  return unit:assert-equals($date, xs:date($r/string()))
};
