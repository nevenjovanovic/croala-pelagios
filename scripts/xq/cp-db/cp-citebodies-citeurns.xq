let $places := collection("cp-places")
let $periods := collection("cp-periods")
for $p in ($places, $periods)//w
let $citebodies := $p/citebodies
order by $citebodies
return element w {
  $citebodies
}