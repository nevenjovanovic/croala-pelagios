(: read a CSV of place identifications :)
(: group by place and by period :)
let $csv := file:read-text("/home/neven/rad/croala-pelagios/csv/cp-cite-cts-100-finished-estlocus1.csv")
let $grouped := element list { for $c in csv:parse($csv)//record
let $ana := $c/entry[8]
let $period := $c/entry[9]
group by $ana , $period
return element r { 
for $n in element n { $c/entry[6] } return element note { replace($n/entry[1], ':loci', ':loci.ana-nota') } ,
element place { $ana } , element period { $period } , element anno { $c/entry[7] } }
}
return $grouped