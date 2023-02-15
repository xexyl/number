#!/usr/bin/make
#
# number - number makefile
#
# @(#) $Revision: 1.32 $
# @(#) $Id: Makefile,v 1.32 2014/03/15 23:59:57 root Exp $
# @(#) $Source: /usr/local/src/bin/number/RCS/Makefile,v $
#
# Copyright (c) 1999-2014 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

SHELL= /bin/sh
INSTALL= install
TAR= tar
CHMOD= chmod

# locations
DESTBIN= /usr/local/bin

# what to build
TARGETS= number.cgi number number.tgz

# remote operations
#
THISDIR= number
RSRCPSH= rsrcpush
RMAKE= rmake

all: ${TARGETS}

number.cgi: number.pl
	rm -f number.cgi
	cp number.pl number.cgi
	chmod 0555 number.cgi

number: number.pl
	rm -f number
	cp number.pl number
	chmod 0555 number

number.tgz: number.pl number.cgi number README.txt
	rm -f number.tgz
	${TAR} -zcvf number.tgz number number.cgi README.txt
	chmod 0444 number.tgz

install: all
	${INSTALL} -m 0555 number ${DESTBIN}

clean:

clobber: clean
	rm -f ${TARGETS}

# help
#
help:
	@echo make all
	@echo make install
	@echo make clobber
	@echo
	@echo make pushsrc
	@echo make pushsrcn
	@echo
	@echo make rmtall
	@echo make rmtinstall
	@echo make rmtclobber
	@echo
	@echo make univ

# push source to remote sites
#
pushsrc:
	${RSRCPSH} -v -x . ${THISDIR}

pushsrcq:
	@${RSRCPSH} -q . ${THISDIR}

pushsrcn:
	${RSRCPSH} -v -x -n . ${THISDIR}

# run make on remote hosts
#
rmtall:
	${RMAKE} -v ${THISDIR} all

rmtinstall:
	${RMAKE} -v ${THISDIR} install

rmtclean:
	${RMAKE} -v ${THISDIR} clean

rmtclobber:
	${RMAKE} -v ${THISDIR} clobber

# build, install, and cleanup everywhere
#
univ: all install clobber pushsrc rmtall rmtinstall rmtclobber
