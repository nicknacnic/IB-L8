#!/usr/bin/env python3

import io
from PyPDF2 import PdfFileWriter, PdfFileReader

# Open the PDF template
pdf_template = PdfFileReader(open('template.pdf', 'rb'))

# Get the first page of the template
page = pdf_template.getPage(0)

# Fill in the form field with the content
page['/FieldName'] = 'Content'

# Create a new PDF file with the filled-in fields
output = PdfFileWriter()
output.addPage(page)
with open('output.pdf', 'wb') as f:
    output.write(f)
