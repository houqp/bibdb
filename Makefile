.PHONY:clean all install

DESTDIR=/usr/bin
TEXPATH=/usr/share/texmf/bibtex/bst

all:bibdb-filter

bibdb-filter:

install:bibdb-filter
	test -d $(TEXPATH) || mkdir -p $(TEXPATH)
	cp dbalpha{,5}.bst $(TEXPATH)/
	mktexlsr
	test -d $(DESTDIR) || mkdir -p $(DESTDIR)
	cp bibdb bibdb-filter $(DESTDIR)/

uninstall:
	rm -rf $(TEXPATH)/dbalpha{,5}.bst
	mktexlsr
	rm -rf $(DESTDIR)/{bibdb,bibdb-filter} 

clean:
	rm -rf bibdb-filter bibdb-filter.c 

clean-bibdb-output:
	rm -rf bibdb.{aux,bbl,blg}
