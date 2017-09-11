Cornell-Notes
=============

Makefile-based fast cornell-style note creation

## Requirements

- **pdflatex**
- **latexmk** For the Live Preview
- **zathura** For preview (Can be changed inside the makefile)

## Commands

`make preamble` Precompiles the preamble, necessary to do it at least once to use all the other commands

`make pdf` Creates the full pdf, with all the chapters one after the other, in order (called notes.pdf)

`make last` Creates a pdf with only the last chapter (called last.pdf)

`make lastpreview` Does "make last" and opens the viewer

`make pdfpreview` Does "make pdf" and opens the viewer

`make livepreview` Prepares a "last.latex" file and makes latexmk generate a live preview of it, opens the viewer set in ~/.latexmkrc

`make clean` Cleans out all the *.log *.aux *.fdb_latexmk and *.fls files

`make cleaner` Does a "make clean" and deletes the generated pdf files

`make cleanest` Does a "make cleaner" and deletes the precompiled preamble
