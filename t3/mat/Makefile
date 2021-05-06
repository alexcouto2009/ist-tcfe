all: octave.log ex1 

ex1: ngspice1.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)


octave.log: lab3.m
	    octave $< > $@ 



ngspice1.log: ../mat/lab3.net 
	ngspice -b $< -o $@


clean:
	@rm -f *.log *.tex *.pdf *.ps *~
	@rm -f octave.log octave-workspace *.txt *.tex *eps *~

.PHONY: all clean
