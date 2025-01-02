SUBDIRS = ./logicIC \
          ./module

.PHONY: all clean testall $(SUBDIRS)
all: $(SUBDIRS)
clean: $(SUBDIRS)
testall: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

