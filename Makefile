.PHONY:clean all install

all:bibdb-filter

bibdb-filter:

install:bibdb-filter
	mkdir -p /usr/share/texmf/bibtex/bst
	cp dbalpha{,5}.bst /usr/share/texmf/bibtex/bst/
	mktexlsr
	cp bibdb bibdb-filter /usr/bin/

uninstall:
	rm -rf /usr/share/texmf/bibtex/bst/dbalpha{,5}.bst
	mktexlsr
	rm -rf /usr/bin/{bibdb,bibdb-filter} 

clean:
	rm -rf bibdb-filter bibdb-filter.c 

clean-bibdb-output:
	rm -rf bibdb.{aux,bbl,blg}
