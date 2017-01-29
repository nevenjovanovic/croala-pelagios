(: CroALa Pelagios :)
(: Exploratory data analysis of annotations / estlocus :)
import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace croala = "http://www.ffzg.unizg.hr/klafil/croala" at "../../repo/croala.xqm";
import module namespace cp = "http://croala.ffzg.unizg.hr/croalapelagios" at "../../repo/croalapelagios.xqm";
import module namespace cite = "http://croala.ffzg.unizg.hr/cite" at '../../repo/croalacite.xqm';

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Exploratory data analysis - CroALa index locorum';
declare variable $content := "An initial breakdown of certainty levels of placeness, as annotated in the first round of the CroALa index locorum project.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Pelagios historical places, gazetteer, literary analysis, scholarly edition, exploratory data analysis, place certainty level, annotation, CroALa";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("cp-eda/estlocus")
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
  function page:cpedaestlocus()
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
<p>Exploratory data analysis of certainty level annotations for the category "placeness" (estlocus0-estlocus4).</p>
<p>Displayed are the totals and percentages for all annotations in a document (including ratio of annotated words to all words of the document), and totals and percentages of individual certainty levels in the document. In the latter, the first percentage shows ratio of the level to all annotated place references, the second the ratio of the level to all <b>marked</b> place references (some of which have not been annotated yet).</p>


</div>
<div class="col-md-6">
<div class="container-fluid">
{croala:infodb('cp-div-cts')}
</div>
<p>Functio nominatur: {rest:uri()}.</p>
<div class="container-fluid">
{ cp:table(("Place certainty code", "Meaning") , cp:estlocus_info_all()) }
</div>
</div>
</div>
</div>

<div class="container-fluid">
<blockquote class="croala">

{ cp:eda_estlocus_table($cp:editions)  }

</blockquote>
     <p/>
     </div>
<hr/>
{ cp:footerserver() }
</body>
</html>
};

return
