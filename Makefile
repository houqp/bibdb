.PHONY: clean all install dist

DESTDIR = /usr/bin
TEXPATH = /usr/share/texmf/bibtex/bst
TAR_NAME = bibdb
VERSION = 0.1.2
DIST_DIR = $(TAR_NAME)-$(VERSION)

all:bibdb-filter

bibdb-filter:

dist:$(DIST_DIR).tar.gz 

$(DIST_DIR).tar.gz:$(DIST_DIR)
	tar --create --dereference --file - $(DIST_DIR) | gzip -9 -c > $@
	rm -rf $(DIST_DIR)

$(DIST_DIR):
	mkdir -p $(DIST_DIR)
	cp *.l bibdb *.bst CHANGELOG Makefile README $(DIST_DIR)

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
	rm -rf bibdb-filter bibdb-filter.c *.tar.gz

clean-bibdb-output:
	rm -rf bibdb.{aux,bbl,blg}
