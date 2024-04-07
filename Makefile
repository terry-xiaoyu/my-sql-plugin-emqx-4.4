## shallow clone for speed

PROJECT = my_sql_plugin
REBAR_GIT_CLONE_OPTIONS += --depth 1
export REBAR_GIT_CLONE_OPTIONS

REBAR = rebar3
all: compile

compile:
	$(REBAR) compile

tar: compile
	@mkdir _build/$(PROJECT)
	@cp -r _build/default/lib/$(PROJECT)/ebin _build/default/lib/$(PROJECT)/priv _build/$(PROJECT)/
	@tar -czf _build/$(PROJECT).tar.gz -C _build $(PROJECT)
	@rm -rf _build/$(PROJECT)

ct: compile
	$(REBAR) as test ct -v

eunit: compile
	$(REBAR) as test eunit

xref:
	$(REBAR) xref

cover:
	$(REBAR) cover

clean: distclean

distclean:
	@rm -rf _build
	@rm -f data/app.*.config data/vm.*.args rebar.lock
