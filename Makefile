FILES = $(shell ls --color=never -v chapters)
LASTFILE = $(shell ls --color=never -v chapters | tail -n1)
VIEWER = zathura

preparefull:
	@rm -f notes.latex
	@echo "%&preamble" >> notes.latex
	@echo "\begin{document}" >> notes.latex
	@echo "\maketitle" >> notes.latex
	@echo "\SetBgContents{\rule[0em]{4pt}{\textheight}}" >> notes.latex
	@for i in $(FILES); do \
		echo "\input{chapters/$$i}" >> notes.latex; \
	done
	@echo "\end{document}" >> notes.latex

preparelast:
	@rm -f last.latex
	@echo "%&preamble" >> last.latex
	@echo "\begin{document}" >> last.latex
	@echo "\maketitle" >> last.latex
	@echo "\SetBgContents{\rule[0em]{4pt}{\textheight}}" >> last.latex
	@echo "\input{chapters/$(LASTFILE)}" >> last.latex
	@echo "\end{document}" >> last.latex

preamble: preamble.latex
	-pdflatex -ini -jobname="preamble" "&pdflatex preamble.latex\dump"

pdf: preparefull
	-pdflatex --interaction batchmode -output-format pdf notes.latex
	-pdflatex --interaction batchmode -output-format pdf notes.latex

last: preparelast
	-pdflatex -draftmode --interaction batchmode -output-format pdf last.latex
	-pdflatex -draftmode --interaction batchmode -output-format pdf last.latex

lastpreview: last
	$(VIEWER) last.pdf

pdfpreview: pdf
	$(VIEWER) notes.pdf

livepreview: preparelast
	latexmk -pdf -pvc -e '$$latex=q/latex %O -shell-escape %S/' last.latex

clean:
	rm -f *.log *.aux *.fdb_latexmk *.fls
	echo "Pulizia Completa"

cleaner: clean
	rm -f notes.pdf last.pdf
	echo "Pulizia profonda completa"

cleanest: moreclean
	rm -f *.fmt
	echo "Pulizia profondissima completa"
