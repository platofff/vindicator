ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

all: vindicator.vala
ifeq ($(UPDATE_ICON),)
	valac --cc="cc $(CFLAGS)" --pkg appindicator3-0.1 --pkg gtk+-3.0 vindicator.vala
else
	valac --cc="cc $(CFLAGS)" $(VALAPARAMS) --pkg appindicator3-0.1 \
	--pkg gtk+-3.0 -D UPDATE_ICON $(UPDATE_ICON) vindicator.vala -o vindicator
endif
	strip vindicator	

clean:
	rm -f vindicator

install: vindicator
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 755 vindicator $(DESTDIR)$(PREFIX)/bin/
