
srcdir = ./src
docdir = ./doc
builddir = ./build

srcname = foro
docname = memoria

srcmemoria = $(docdir)/memoria.tex
srcforo    = $(srcdir)/foro.pc
creasql    = $(srcdir)/crea.sql

buildmemoria = $(docdir)/memoria.pdf
buildforo    = $(builddir)/foro

CC = ./make-util/make-pc.sh
CT = ./make-util/make-tex.sh
RS = ./make-util/run-sql.sh

CLEAN_DOC_TRASH = cd $(docdir) && \
	rm -fv *.aux *.dvi *.log *.out *.toc *.synctex.gz;

CLEAN_COMMON_TRASH = find ./ -type f \
	-name "*~" -o -name ".DS_Store" -o -name "thumbs.db" \
	| xargs rm -fv

PDF_VIEWER = evince

.PHONY: all clean exec sql doc commit push pull

all: $(buildforo)

$(builddir):
	mkdir -p $(builddir)

$(buildforo): $(builddir)
	$(CC) $(srcforo) $(buildforo)

$(buildmemoria):
	$(CT) $(srcmemoria) $(buildmemoria)

doc: $(buildmemoria)
	$(PDF_VIEWER) $(buildmemoria) 2>&1|: &

exec: $(buildforo)
	$(buildforo)

clean:
	rm -Rfv $(builddir)
	rm -fv $(buildmemoria)
	$(CLEAN_DOC_TRASH)
	$(CLEAN_COMMON_TRASH)

sql:
	$(RS) $(creasql) "$(ORA_LOGIN)"

commit:
	git commit -a

push:
	export GIT_SSL_NO_VERIFY=true && git push

pull:
	export GIT_SSL_NO_VERIFY=true && git pull

