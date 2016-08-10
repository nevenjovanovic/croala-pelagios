declare function local:pretty ($text){
  let $settext := normalize-space($text)
return replace(replace($settext, ' ([,).:;])', '$1'), '([(]) ', '$1')
};
for $list in doc("/home/neven/rad/croala-pelagios/csv/tuberoidx-placenames2.xml")//*:placeName
let $ctsadr := data($list/@n)
for $pre in data(db:open("tub-com-idx")//*:w[@n=$ctsadr]/@xml:id)
let $text := data(db:open-pre("tubero-commentarii", $pre)/parent::*:s)
return element tr {
  element td { $ctsadr },
  element td { data($list )},
  element td { local:pretty($text) }
}