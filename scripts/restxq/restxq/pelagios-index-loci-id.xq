(: CroALa Pelagios :)
(: Report an index of identified places and occurrences in the corpus or in individual documents :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'CroALa: loca in textibus';
declare variable $content := "Display index of identified places and their occurrences, in the whole CroALa Pelagios corpus or in a specific document.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp-loci-id/{$urn}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:cplociidurn($urn)
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Index locorum in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }: loca et loci.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>An index of identified places and locations of their occurrences in the whole corpus or in a document. The index is shown for {$urn}.</p>

<p>Function name: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-cite-loci')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">

  { 
  element div {
    attribute class {"table-responsive"},
  element table {
    attribute class {"table-striped  table-hover table-centered"},
    element caption {
      attribute class {"heading"},
      $urn
    },
  element thead {
    element tr {
      element th { "Place name" },
      element th { "Place CITE URN"},
      element th { "Occurrences"},
      element th { "CTS URN list"}
    }
  },
  element tbody {
    attribute class { "cp-loci-index"},
  cp:loci-id-index($urn)
}
} 
} }

</blockquote>
<p/>
</div>
<hr/>
{ cp:footerserver() }

</body>
</html>
};

return
