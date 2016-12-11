(: CroALa Pelagios :)
(: Report counts of identified places and occurrences in the corpus and in individual documents :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'CroALa: loca in textibus';
declare variable $content := "Display counts of identified places and their occurrences, in the whole CroALa Pelagios corpus and in a specific document.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, analytical exemplar, place name, URN";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp-locorum-numeri")
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
  function page:cplocorumnumeri()
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Index locorum in <a href="http://croala.ffzg.unizg.hr">CroALa</a> sub specie <a href="http://commons.pelagios.org/">Pelagii</a>, { current-date() }: locorum numeri.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>Basic statistics of the CroALa index locorum.</p>

<p>Function name: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{croala:infodb('cp-cite-loci')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
<h2>Current counts of entities and annotations in the system</h2>
{ element h3 { "Entities: " || cp:sum_annotations_db(cp:count_entities_db ())} }

{ element h3 { "Annotations: " || cp:sum_annotations_db(cp:count_annotations_db ()) } }

</blockquote>
<p/>
</div>
<div class="container-fluid">
<blockquote class="croala">
<h2>Entities in the system by category</h2>
{ cp:count_annotations_table ( cp:count_entities_db () )
 }
</blockquote>
<p/>
</div>
<div class="container-fluid">
<blockquote class="croala">
<h2>Annotations in the system by category</h2>
{ cp:count_annotations_table ( cp:count_annotations_db () )
 }
</blockquote>
<p/>
</div>
<div class="container-fluid">
<blockquote class="croala">

  { cp:report_count_places() }

</blockquote>
<p/>
</div>
<hr/>
{ cp:footerserver() }

</body>
</html>
};

return
