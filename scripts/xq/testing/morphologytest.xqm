module namespace test = 'http://basex.org/modules/xqunit-tests';
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../xqm/croalacite.xqm';
import module namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios' at '../xqm/croalapelagios.xqm';

(: Do we have a cp-cite-morphs db? :)
declare %unit:test function test:find-dbs() {
  unit:assert(db:exists("cp-cite-morphs"))
};
(: Do we have CITE annotations there? :)
declare %unit:test function test:find-morphs-records() {
  unit:assert(collection("cp-cite-morphs")//record[parent::csv]/entry)
};
(: Function: retrieve all CITE morphological annotations from the db :)
declare %unit:test function test:retrieve-morphs-records() {
  unit:assert(cite:getmorphanno()//entry[parent::record])
};
(: Function: display matches for first letters with morphological annotations :)
(: Function: display CITE URN, form, morphological code, value of code :)
declare %unit:test function test:retrieve-morphs-table() {
  let $csv := cite:getmorphanno()
  return unit:assert(
    cite:getmorphtable($csv)//tr[parent::tbody]/td
  )
};
(: Function: order by morphological codes :)