#!/bin/make
#  @(#} $Revision: 1.4 $
#  @(#} RCS control in //prime.corp/usr/local/src/cmd/number/Makefile
#
# number - number makefile

SHELL=/bin/sh
MODE=0555
DESTDIR=/usr/local/bin
WWW=/usr/local/ns-home/docs/chongo/number
SCRIPTS= number number.cgi

all: ${SCRIPTS}

number: number.pl
	rm -f number
	cp number.pl number
	chmod 0555 number

number.cgi: number.pl
	rm -f number.cgi
	cp number.pl number.cgi
	chmod 0555 number.cgi

install: all
	install -F ${DESTDIR} -m ${MODE} ${SCRIPTS}
	install -F ${WWW} -m 0755 number
	install -F ${WWW} -m 0755 number.cgi

clean:

clobber: clean
	rm -f number
