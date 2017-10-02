FILES = $(shell ls --color=never -v chapters)
LASTFILE = $(shell ls --color=never -v chapters | tail -n1)
VIEWER = zathura
MATERIA = Nessuna Materia
STDHEADER='%%Note di $(MATERIA)\n%%Sommario: <+SOMMARIO+>\n\n\n'

preparefull:
	@rm -f notes.tex
	@echo "%&preamble" >> notes.tex
	@echo "\begin{document}" >> notes.tex
	@echo "\maketitle" >> notes.tex
	@echo "\SetBgContents{\rule[0em]{4pt}{\textheight}}" >> notes.tex
	@for i in $(FILES); do \
		echo "\input{chapters/$$i}" >> notes.tex; \
	done
	@echo "\end{document}" >> notes.tex

preparelast:
	@rm -f last.tex
	@echo "%&preamble" >> last.tex
	@echo "\begin{document}" >> last.tex
	@echo "\maketitle" >> last.tex
	@echo "\SetBgContents{\rule[0em]{4pt}{\textheight}}" >> last.tex
	@echo "\input{chapters/$(LASTFILE)}" >> last.tex
	@echo "\end{document}" >> last.tex

preamble: preamble.tex
	-pdflatex -ini -jobname="preamble" "&pdflatex preamble.tex\dump"

pdf: preparefull
	-pdflatex --interaction batchmode -output-format pdf notes.tex
	-pdflatex --interaction batchmode -output-format pdf notes.tex

last: preparelast
	-pdflatex -draftmode --interaction batchmode -output-format pdf last.tex
	-pdflatex -draftmode --interaction batchmode -output-format pdf last.tex

lastpreview: last
	$(VIEWER) last.pdf

pdfpreview: pdf
	$(VIEWER) notes.pdf

livepreview: preparelast
	latexmk -pdf -pvc -interaction=nonstopmode -e '$$latex=q/latex %O -shell-escape %S/' last.tex

new:
	@if [ ! -f chapters/1.tex ]; then \
		printf $(STDHEADER) >> chapters/1.tex; \
		$(EDITOR) chapters/1.tex; \
	else \
		f=$(shell expr $(basename $(LASTFILE)) + 1); \
		printf $(STDHEADER) > chapters/$$f.tex; \
		$(EDITOR) chapters/$$f.tex; \
	fi

clean:
	rm -f *.log *.aux *.fdb_latexmk *.fls
	@echo "Pulizia Completa"

cleaner: clean
	rm -f notes.pdf last.pdf notes.tex last.tex
	@echo "Pulizia profonda completa"

cleanest: cleaner
	rm -f *.fmt
	@echo "Pulizia profondissima completa"
