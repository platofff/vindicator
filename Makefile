ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

all: vindicator.vala
	valac --pkg appindicator3-0.1 --pkg gtk+-3.0 vindicator.vala
clean:
	rm -f vindicator
install: vindicator
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 755 vindicator $(DESTDIR)$(PREFIX)/bin/
