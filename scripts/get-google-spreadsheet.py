# -*- coding: utf-8 -*-
'''
    File name: get-google-spreadsheet.py
    Author: Neven Jovanović
    Date created: 25/7/2016
    Date last modified: 2/8/2016
    Download CSV from a Google Spreadsheet (viewable by anyone)
    TODO: the same script for two sheets
'''
import requests
csvfile = 'https://docs.google.com/spreadsheets/d/1N-31GC_dd7kP4X1a4_pUAzuuDcay5DEycVpMjToFQMw/export?format=csv&gid='
csvlist = ['1731124717', '633798167']
for csv in csvlist:
    csvtab = csvfile + csv
    csvfilename = csv + 'm.csv'
    response = requests.get(csvtab)
    assert response.status_code == 200, 'Wrong status code'
    f = open(csvfilename, 'w')
    f.write(response.content)
    f.close()