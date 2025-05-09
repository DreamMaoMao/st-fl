# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c $(LIGATURES_C) $(SIXEL_C)
OBJ = $(SRC:.c=.o)

STLDFLAGS += -lpcre2-32
CFLAGS += -g -Wunused-variable
 

all: st

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) $(FLASH_MODE_PINYIN) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h $(LIGATURES_H)

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ) st-$(VERSION).tar.gz

dist: clean
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(LIGATURES_H) $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st-$(VERSION).tar.gz
	rm -rf st-$(VERSION)

install: st
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)$(PREFIX)/bin
	cp -f st-copyout $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st-copyout
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < st.1 > $(DESTDIR)$(MANPREFIX)/man1/st.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/st.1
	mkdir -p $(DESTDIR)$(PREFIX)/share/st/terminfo
	tic -sx -o $(DESTDIR)$(PREFIX)/share/st/terminfo st.info
	mkdir -p $(DESTDIR)$(PREFIX)/share/applications # desktop-entry patch
	cp -f st.desktop $(DESTDIR)$(PREFIX)/share/applications # desktop-entry patch
	mkdir -p $(DESTDIR)$(ICONPREFIX)
	test -f $(ICONNAME) && test ! -f $(DESTDIR)$(ICONPREFIX)/$(ICONNAME) && cp -f $(ICONNAME) $(DESTDIR)$(ICONPREFIX) || :
	@echo Please see the README file regarding the terminfo entry of st.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(PREFIX)/bin/st-copyout
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1
	rm -f $(DESTDIR)$(PREFIX)/share/applications/st.desktop # desktop-entry patch
	rm -f $(DESTDIR)$(ICONPREFIX)/$(ICONNAME)

.PHONY: all clean dist install uninstall
