(: open urn :)
declare namespace cp = 'http://croala.ffzg.unizg.hr/croalapelagios';

(: pretty printing of text :)
declare function cp:prettyp2($settext) {
    element td {
  replace(replace($settext, ' ([,).:;?!])', '$1'), '([(]) ', '$1')
}
};

(: from a CTS URN retrieve text in s parent element :)
declare function cp:openurn2 ($nodeid) {
let $text := db:open-id("tubero-commentarii", $nodeid)/parent::*:s
let $settext := normalize-space(data($text))
return cp:prettyp2($settext)
};

(: function to create csv :)
declare function local:xtocsv ($listofx){
  let $citelist :=
  element csv {
    for $i in $listofx//*:w
  let $sq := data($i/@xml:id)
let $cts := data($i/@n)
let $label := $i/text()
let $citerecord := "urn:cite:croala:loci." || $sq
let $citebodyrecord := "urn:cite:croala:loci.ana." || $sq
let $isplace := data($i/@ana)
let $txt := cp:openurn2($sq)
order by xs:integer($sq)
return element tr {
  element td { $sq },
  element td { $label },
  element td { $isplace },
  $txt,
  element td { $cts },
  element td { $citerecord },
  element td { $citebodyrecord }
}
}
return csv:serialize($citelist)
};
(: from a list of finished entries, return others which are still estlocusX :)
(: list is here :)
let $names := <l>
<n>Saona</n>
<n>Senis</n>
<n>Vicheriae</n>
<n>Ticinium</n>
<n>Patauium</n>
<n>Venetias</n>
<n>Bononiam</n>
<n>Perusium</n>
<n>Senam</n>
<n>Ferrariamque</n>
<n>Romam</n>
<n>Imolam</n>
<n>Bosti</n>
<n>Taruixii</n>
<n>Mediolani</n>
<n>Papiae</n>
<n>Italia</n>
<n>Hungaria</n>
<n>Pragae</n>
<n>Viannam</n>
<n>Norici</n>
<n>Carnici</n>
<n>Europa</n>
<n>Viannae</n>
<n>Austriam</n>
<n>Albam</n>
<n>Hungariam</n>
<n>Alemaniam</n>
<n>Austria</n>
<n>Budam</n>
<n>Datiam</n>
<n>Rhacusa</n>
<n>Dalmatiae</n>
<n>Alba</n>
<n>Rhacosium</n>
<n>Pesto</n>
<n>Budae</n>
<n>Danubii</n>
<n>Danubius</n>
<n>Europae</n>
<n>Adriatico</n>
<n>Istro</n>
<n>Euxino</n>
<n>Drauum</n>
<n>Drauo</n>
<n>Thracia</n>
<n>Macedonia</n>
<n>Hyllirico</n>
<n>Pannoniis</n>
<n>Vistulaque</n>
<n>Albim</n>
<n>Illyricum</n>
<n>Illyrici</n>
<n>Raxia</n>
<n>Danubium</n>
<n>Rhipheos</n>
<n>Vrbe</n>
<n>Asiam</n>
<n>Rha</n>
<n>Moschouiam</n>
<n>Scythiae</n>
<n>Hyrcanum</n>
<n>Illiricum</n>
<n>Scythia</n>
<n>Tanai</n>
<n>Latio</n>
<n>Dacico</n>
<n>Hungariae</n>
<n>Polonia</n>
<n>Roma</n>
<n>Poloniam</n>
<n>Alemmaniae</n>
<n>Boemiae</n>
<n>Adriaticum</n>
<n>Praghae</n>
<n>Valdanum</n>
<n>Hunnam</n>
<n>Drinum</n>
<n>Bossinae</n>
<n>Illyrico</n>
<n>Iaizam</n>
<n>Rhodum</n>
<n>Lyciae</n>
<n>Pestano</n>
<n>Scaruisium</n>
<n>Romae</n>
<n>Batha</n>
<n>Danubio</n>
<n>Visegradum</n>
<n>Pragam</n>
<n>Vngaria</n>
<n>Strigonium</n>
</l>
let $placesx := element l { collection("tub-com-placename-idx")//*:w[@ana='estlocusX' and text() contains text { $names//n } ] }
return local:xtocsv($placesx)