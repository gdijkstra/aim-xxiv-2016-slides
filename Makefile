TEX=slides.tex
TEXMAIN=$(basename $(TEX))
PDF=build/$(subst .tex,.pdf,$(TEX))
LOG=build/$(subst .tex,.log,$(TEX))
SRC=$(shell find src/ -name \"\*.tex\")

default: slides

slides: dirs $(src)
	xelatex -file-line-error -output-directory=build --halt-on-error $(TEX)
	sh -c ' \
	  i=2; \
	  while [ $$i -lt 5 ] && ( \
	       grep -c "undefined citations" $(LOG) \
	    || grep -c "undefined references" $(LOG) ); \
	  do xelatex -file-line-error -output-directory=build --halt-on-error $(TEX); \
	     i=`expr $$i + 1`; \
	     done; \
          echo "Iterations: $$i"'

dirs:
	mkdir -p build

clean:
	rm -rf build/
