TEX := $(shell find target/xprocspec/tmp/ -name '*.tex')
PDF := $(TEX:%.tex=%.pdf)

pdf : $(PDF)

target/xprocspec/%.pdf : target/xprocspec/%.tex
	cd $(dir $<) && xelatex $(notdir $<) && xelatex $(notdir $<)

.PHONY : pdf
