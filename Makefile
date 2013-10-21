NAME = plugin.video.xbmctorrent
GIT = git
GIT_VERSION = $(shell $(GIT) describe --always)
VERSION = $(patsubst v%,%,$(GIT_VERSION))
ZIP_FILE = $(NAME)-$(VERSION).zip


all: clean zip

addon.xml:
	sed s/\$$VERSION/$(VERSION)/g < addon.xml.tpl > $@

$(ZIP_FILE): addon.xml
	git archive --format zip --prefix $(NAME)/ --output $(ZIP_FILE) $(GIT_VERSION)
	mkdir $(NAME)
	ln -s `pwd`/addon.xml $(NAME)
	zip -9 -g $(ZIP_FILE) $(NAME)/addon.xml
	rm -rf $(NAME)

zip: $(ZIP_FILE)

clean:
	rm -rf addon.xml
