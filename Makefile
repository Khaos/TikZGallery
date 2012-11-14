
main = TikZGallery

latexcmd := pdflatex
# latexcmden := pdflatex
# latexcmden := xelatex

# stydir = /Users/Khaos/Library/texmf/tex/latex/DJThesis/PhDThesis01
# stydir := $(shell dirname $(shell kpsewhich SUACSEThesis.sty))
stydir := ./Sty
stydirlocal = ./Sty

styfile = TikZGallery-Preamble.tex
support := $(styfile:%=$(stydir)/%)
# /Users/Khaos/Library/texmf/tex/latex/pmat/pmat.sty
supportlocal := $(styfile:%=$(stydirlocal)/%)
# pkgsupport := $(shell cat SUACSEThesis.pkgs)

figsrcdir = Figs/Src
figpdfdir = Figs/pdf
figpngdir = Figs/png

tikzDeviceFig := $(patsubst %, $(figsrcdir)/%, \
  )

gnuplotFig := $(patsubst %, $(figsrcdir)/%, \
  )

fig-tmp := $(patsubst %, $(figpdfdir)/%, \
  )

figures := $(fig-tmp)

# algdir = ./Algs
# algorithm := $(shell ls ./Algs/*.algx)
# algorithm := $(patsubst %, $(algdir)/%, FPFastICA.tex FPFastICA_modified.tex)

# TEXINPUTS := $(stydirlocal):$(TEXINPUTS):$(shell echo $TEXINPUTS)
TEXINPUTS := $(stydirlocal):$(TEXINPUTS)
# TEXINPUTS.xelatex := $(TEXINPUTS)
# tmpvar := $(chapters:$(main)-%=fig%)
# tmpvar := $(addsuffix .tex,$(chapters))
# tmpvar := $(filter $(figpdfdir)/pgf-o-%.pdf, $(figures))
tmpvar := $(stydir)

.PHONY: show clean test tmp cleanroot pgf pngfig

# $(chapters) show clean glotest bibtextest bibertest pdflatexonly pgffig cpsty

show: $(main).pdf
	open -a Skim.app $^
	osascript -e 'tell application "Skim" to revert item 1 of (every window whose name contains "'$<'")'

test: $(main).tex
	@TEXINPUTS="$(TEXINPUTS)" \
	echo $(TEXINPUTS)
	# @TEXINPUTS.xelatex="$(TEXINPUTS.xelatex)"; \
	# echo $(TEXINPUTS.xelatex);

	# @echo $(algorithm);

	# @echo $(tmpvar);
	# echo $(support);
	# echo $(supportlocal);
	# echo $(TEXINPUTS)

$(main).pdf: $(main).tex $(support) $(figures)
	@TEXINPUTS="$(TEXINPUTS)" \
	$(latexcmd) -shell-escape -file-line-error $(main);
	make -f $(main).makefile
	$(latexcmd) -shell-escape -file-line-error -synctex=1 $(main)

tmp:
	@TEXINPUTS="$(TEXINPUTS)" \
	$(latexcmd) -shell-escape -file-line-error -synctex=1 $(main)


pgf:
	make -f $(main).makefile

pgnfig:
	# convert -density 300 -transparent white "\image.pdf" "\image.png"


clean:
	-rm -f *.pdf *.log *.aux *.out *.bbl *.bcf *.blg \
		*.figlist *.glo *.gls *.lof *.lot *.xml *.gz *.toc \
		*.acn *.acr *.alg *.glg *.ilg *.ist
	-rm -f Figs/pdf/pgf-*.*

cleanroot:
	-rm -f *.pdf *.log *.aux *.out *.bbl *.bcf *.blg \
		*.figlist *.glo *.gls *.lof *.lot *.xml *.gz *.toc \
		*.acn *.acr *.alg *.glg *.ilg *.ist

$(supportlocal):
