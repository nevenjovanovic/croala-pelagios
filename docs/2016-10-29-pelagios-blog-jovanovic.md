# Interim report on the CroALa Index Locorum for the Pelagios Blog

We have been building the [CroALa Index Locorum](https://github.com/nevenjovanovic/croala-pelagios/wiki) for three months now, and the end is in sight. Our working corpus is ready; it includes five Croatian Latin texts, two prose works -- a funeral speech by Nikola Modruški from 1474 and a history of South-Eastern Europe by Ludovik Crijević Tubero, finished after 1522 -- as well as three poetic texts, a mythological epic by Jakov Bunić (1490) and collected poems by Ilija Crijević (1463-1520) and Marko Marulić (1450-1524). Each of these works exists in a special XML edition [tokenized](https://en.wikipedia.org/wiki/Tokenization_(lexical_analysis)) to the level of words; each word has been assigned its own unique CTS URN address.

Looking at what we have learned (and what we're still learning), the stuff seems to fall into one of three categories. There were *technical* problems to be solved, *linked data* infrastructure and sources that we were lucky to be able to build on and reuse, and *conceptual issues* -- main sources of our headaches and just-don't-get-into-metaphysics agonies during meetings. Below are highlights from each category, for you to choose according to preferences and inclinations.

![Indexing the Mediterranean](https://github.com/nevenjovanovic/croala-pelagios/blob/master/img/pexels-photo-66107.jpeg?raw=true)

## Conceptual

### Five degrees of place names

The initial set of potential place names included 12,022 words; the first step of our annotating team was to decide whether a word actually is a place name. The world is a complicated place, and we could not always make a simple binary decision ("yes, this one is a place name" -- "no, that one isn't"). We have prepared a [five-degree scale](https://github.com/nevenjovanovic/croala-pelagios/wiki/Annotating-workflow-guidelines#annotating-place-names), where *estlocus0* meant "not a place name", *estlocus1* meant "yes, it is a place name", and other values marked different interpretative issues. It turned out that some place names are [multi-word expressions](https://github.com/nevenjovanovic/croala-pelagios/wiki/Place-qualifiers), others are *rhetorical references* (metonymies or other figurative usages of words which are not place names to signify place names), while a large group consists of *complicated situations*. This initial triage enabled us to concentrate, in the first round of annotation, on unequivocal and multi-word place references, but it also brought us a valuable set of "hard" place name usages, to which we can turn when we will be looking for challenges to our model.

At the moment (the sets still have to be completed and reviewed) there are **1,185** unequivocal place name usages and **320** multi-word ones; 1,146 text segments have been excluded from annotation of place names, and there are **457** complicated cases. The ratio of complicated to multi-word to unequivocal denotations is interesting in itself.

Place names have been annotated grammatically (we have identified their lemmata and their morphological features), and now we are working on identifying places denoted by the words: *post verba, res*.

### Qui bene distinguit...

In preparing annotations, it turned out to be imperative to think precisely and clearly ([qui bene distinguit...](http://www.textlog.de/1963.html)); for example, [clarifying the aims through discussion](https://github.com/nevenjovanovic/croala-pelagios/issues/19) has led us to better see the purpose of our lemmatization phase -- there are may be multiple *meanings* of the same string of letters, but in this phase we are not annotating *meanings*, we are simply connecting a word to its canonical form.

Another important insight was that there are to be distinguished at least two types of multi-word expressions: some function on the lexical level (a multi-word place name, such as *Stratford-upon-Avon*), some denote part of a whole (as in [Osip Mandelstam's](https://en.wikipedia.org/wiki/Osip_Mandelstam) beloved verse by Catullus, [ad claras Asiae volemus urbes](http://data.perseus.org/citations/urn:cts:latinLit:phi0472.phi001.perseus-lat1:46)). More about this distinction can be read in [our Github documentation](https://github.com/nevenjovanovic/croala-pelagios/wiki/Place-qualifiers#two-levels-of-part-whole-relations-in-place-references).

## Technical

### Database

Our annotation system is a database -- an XML database built using [XQuery](https://en.wikipedia.org/wiki/XQuery) and [BaseX](http://basex.org/), to be more precise -- in which each set of annotations (lexical, morphological, identifying places, periods, rhetorical status) is a table. What connects the tables are unique identifiers for annotations -- they, or their parts, serve as [primary keys](https://en.wikipedia.org/wiki/Unique_key) of our records. This means that, in parallel with annotating places, we have been busy *modeling a database* which will bring together various types of annotations. As the annotations will be revised, it was vital to define [tests](https://github.com/nevenjovanovic/croala-pelagios/tree/master/scripts/xq/testing) and [validation rules](https://github.com/nevenjovanovic/croala-pelagios/tree/master/schemas) for each table. Eventually, we hope to automate fully the processes of testing and rebuilding the database, so that we can easily add new annotations or revise existing ones.

### Github

While in the beginning the annotators were working in Google Spreadsheets (and their primary work still happens there), as the job goes on, we are beginning to move our discussions and collaboration [to our Github repository](https://github.com/nevenjovanovic/croala-pelagios/issues). I am happy to report that the team is constantly improving their Github skills!


### CTS / CITE Architecture

Our database and our project would not be possible without the ability to point precisely towards a specific word in a specific edition of our texts. For that, the concept of [CTS / CITE Architecture](http://cite-architecture.github.io/), developed by Neel Smith and Christopher Blackwell, has been indispensable. Our texts exist in [special XML editions](https://github.com/nevenjovanovic/croala-pelagios/tree/master/data) tokenized to the level of sentences (or verse lines) and words; each segment of these editions has been assigned a CTS URN; towards these URNs point all our annotations (which themselves have CITE URN identificators).

## Linked data

One (famous) definition of philology sees it as [Erkentniss des Erkannten](http://www.uni-heidelberg.de/fakultaeten/philosophie/skph/seminar/fazboeckh.html), "knowledge of what is known"; the essence of our philological work in the *CroALa index locorum* may be defined as a variation of it, as *linking what has to be linked*. We are establishing links not only *inside* our system -- from the text segments towards their annotations -- but we are also reaching out, trying to connect our annotations to other people's [linked data](https://en.wikipedia.org/wiki/Linked_data).

We are not doing this because we are lazy (though I, personally, would like to be), or because we are trendy (though...). In my opinion, scholarship rests on *consensus*; if I can get people to agree with my thesis, that thesis is worth something -- but, also, if people have already agreed on something (and have published the result of their agreement), we want to build further on that.

Sources of data the *CroALa index locorum* will be linking to are: for linguistic data, the [Perseus Lexical Inventory](https://sites.tufts.edu/perseusupdates/2014/03/21/announcing-the-perseus-lexical-inventory-an-open-linked-data-set/) and their [morphology tagset](https://github.com/PerseusDL/treebank_data/blob/master/v2.1/Latin/TAGSET.txt); for place identification, the [Pleiades](https://pleiades.stoa.org/) and [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page) -- we expect lots of fun with the imaginary places and with temporally bound spatial entities such as the [Kingdom of Hungary](https://www.wikidata.org/wiki/Q171150); for periods, we will start from [PeriodO](http://perio.do/) -- though we will probably end up composing and publishing our own period identification set for the [mythical time](https://en.wikipedia.org/wiki/Ages_of_Man), and probably one for Croatian history as well.

