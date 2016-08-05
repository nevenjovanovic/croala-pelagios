#!/usr/bin/python
from __future__ import print_function
"""index-csv2rdf.py: Parse CSV. Output RDF to address the CITE object and CTS: 
"""


__author__ = "Neven Jovanovic"
__copyright__ = ["Neven Jovanovic, Zagreb, Croatia"]
__credits__ = ["Neven Jovanovic"]
__license__ = "CC-BY"
__version__ = "0.0.1"
__maintainer__ = "Neven Jovanovic"
__email__ = "neven.jovanovic@ffzg.hr"
__status__ = "Prototype"


import os
import csv
from rdflib import BNode, Literal, Graph, Namespace, XSD
from rdflib.namespace import RDF


# initialize RDF graph and rdfs, oa, olo, and owl namespaces
croala1graph = Graph()
rdfs = Namespace("http://www.w3.org/2000/01/rdf-schema#")
oa = Namespace("http://www.w3.org/ns/oa#")
olo = Namespace("http://purl.org/ontology/olo/core#")
owl = Namespace("http://www.w3.org/2002/07/owl#")

# open file, parse it as CSV object, select necessary fields
with open('../csv/pilot/modruski-cite-analysis-places.csv') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        cts = Literal(row[0])
        sequence = Literal(row[2], datatype=XSD.integer)
        arecord = Literal(row[3])
        abody = Literal(row[4])
        aexemplar = Literal(row[5])
        label = Literal(row[6], lang='la')
        croala1graph.add((arecord,RDF.type,oa.Annotation))
        croala1graph.add((arecord,olo.item,sequence))
        croala1graph.add((arecord,oa.hasBody,abody))
        croala1graph.add((arecord,oa.hasTarget,cts))
        croala1graph.add((arecord,owl.sameAs,aexemplar))
        croala1graph.add((arecord,rdfs.label,label))
# add the RDF statements to our graph file
croalardffile = open("../rdf/croala-cite-ana.ttl", "w")
print(croala1graph.serialize(format='turtle'), file=croalardffile)
