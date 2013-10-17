NAME = plugin.video.xbmctorrent
GIT_VERSION := $(shell git describe)
VERSION := $(shell git describe | sed s/\^v//g)
ZIP_FILE := $(NAME)_$(VERSION).zip

all: clean version zip

version:
	sed s/\$$VERSION/$(VERSION)/g < addon.xml.tpl > addon.xml

zip:
	git archive --prefix $(NAME)/ $(GIT_VERSION) | tar -x -C /tmp
	sed s/\$$VERSION/$(VERSION)/g < addon.xml.tpl > /tmp/$(NAME)/addon.xml
	cp -R resources/bin /tmp/$(NAME)/resources
	rm -f /tmp/$(NAME)/addon.xml.tpl
	cd /tmp && zip -9 -r $(ZIP_FILE) $(NAME)
	mv /tmp/$(ZIP_FILE) .
	rm -rf /tmp/$(NAME)

clean:
	rm -rf addon.xml
	rm -rf /tmp/$(NAME)
