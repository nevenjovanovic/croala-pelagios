(: CroALa Pelagios :)
(: Visualize annotated CTS URNs in a segment :)
(: Use CTS URN of the segment and an index db :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../../repo/croalacite.xqm';

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Notarum schemata - CroALa index locorum';
declare variable $content := "A simple visualization of words in a text segment, showing annotated words.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, text visualization, annotation, CroALa";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("graph/{$ctsdiv}")
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
  function page:visualizediv($ctsdiv)
{
  (: HTML template starts here :)

<html>
{ cp:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>Annotationes in <a href="http://croala.ffzg.unizg.hr">CroALa</a>, { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and the <a href="https://github.com/nevenjovanovic/croala-pelagios/wiki#the-team">CroALa-Pelagios team</a>.</p>
<p>Verba significantur signis "+" et "-". Annotatio indicata est signo "+". Sequere nexum ut annotationes videas.</p>
<p>Functio nominatur: {rest:uri()}.</p>

</div>
<div class="col-md-6">
{croala:infodb('cp-div-cts')}
</div>
</div>
</div>
<div class="graph-outer">
<blockquote class="croala">

{ cp:plus(cp:openctsdiv($ctsdiv), $ctsdiv) }

</blockquote>
     <p/>
     </div>
<hr/>
{ cp:footerserver() }
</body>
</html>
};

return