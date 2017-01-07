module namespace test = 'http://basex.org/modules/xqunit-tests';

(: does it validate with cpplaces.rng? :)

declare %unit:test function test:cp-latlexents-local-valid () {
  for $doc in db:open('cp-latlexents')
  let $result := validate:rng-report($doc, 'https://github.com/nevenjovanovic/croala-pelagios/raw/master/schemas/cplatlexents.rng')
  let $expected := <report>
  <status>valid</status>
</report>
return 
  unit:assert-equals($result, $expected)
};

(: Test for uniqueness :)
declare %unit:test function test:unique-cts () {
  let $r := collection("cp-latlexents")//record
  let $ctsvalues := count(distinct-values($r/lemma/@citeurn))
  return unit:assert-equals($ctsvalues, count($r))
};


(: do we have an equal count of rows locally and on server? :)
declare %unit:test function test:local-web () {
  let $r := count(collection("cp-latlexents")//record)
  let $w := xs:integer(fetch:text("http://pelagios:nemojdasezezassamnom@croala.ffzg.unizg.hr/basex/rest/cp-latlexents?query=count(//record)"))
  return unit:assert-equals($r, $w)
};