.PHONY:clean all

all:bibdb-filter

bibdb-filter:

clean:
	rm -rf bibdb-filter bibdb-filter.c 

clean-bibdb-output:
	rm -rf bibdb.{aux,bbl,blg}
