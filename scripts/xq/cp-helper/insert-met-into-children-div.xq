for $t in //*:text/*:body/*:div[last() and position()=1]/*:div[not(@met)]
let $met := $t/parent::*:div/@met
return if ($met) then insert node $met into $t else()