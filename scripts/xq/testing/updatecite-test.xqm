module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace uc = "http://croala.ffzg.unizg.hr/uc" at '../xqm/updatecite.xqm';

(: update CITE URNs for Tubero with new URNs and node ids :)

(: check for backup of cp-cts-cite-idx :)

declare %unit:before-module function test:check-backups() {
  for $dbname in ("cp-cts-cite-idx", "cp-citebody")
  return unit:assert(db:backups($dbname), true())
};

(: check whether entry[4] is a CapiTainS CTS URN :)

declare %unit:test function test:check-entry4() {
  for $e in collection("cp-cts-cite-idx")//record/entry[4]
  where $e[matches(string(), ":body1.div1.div1.p1.s2.placeName4")]
  return unit:assert-equals($e/string(), "urn:cts:croala:crije01.croala789994.croala-lat2w:body1.div1.div1.p1.s2.placeName4")
};

(: from entry[4] return @xml:id :)

declare %unit:test function test:call-xml-id() {
  for $e in collection("cp-cts-cite-idx")//record/entry[4]
  let $xmlid := collection("cp-cts-urns")//w[@n=$e/string()]
  return unit:assert($xmlid/@xml:id)
  
};

(: check whether @xml:id is equal to entry[1] :)

declare %unit:test function test:compare-xmlid-entry1() {
  for $e in collection("cp-cts-cite-idx")//record
  let $xmlid := collection("cp-cts-urns")//w[@n=$e/entry[4]/string()]/@xml:id/string()
  let $id := $e/entry[1]/string()
  return if ($xmlid = $id) then unit:assert($e)
  else unit:fail($e)
};

(: from entry[5] loci.ana, return cp-citebody entry :)

declare %unit:test function test:entry5-to-citebody() {
  for $e in collection("cp-cts-cite-idx")//record
  let $loci := $e/entry[5]/string()
  let $result := collection("cp-citebody")//r[anno/entry[.=$loci]]
  return unit:assert($result)
};

(: from cp-cts-cite-idx entry1, open cp-2-texts node :)

declare %unit:test function test:entry1-open-node() {
  for $r in collection("cp-cts-cite-idx")//record
  let $nodeid := $r/entry[1]
  let $node := db:open-id("cp-2-texts", $nodeid)
  return unit:assert($node)
};

(: from CTS URN, return cp-citebody entry :)