PROJECT = test_project
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0
ERLC_OPTS += "+{parse_transform, lager_transform}"
DEPS = jsx cowboy lager
dep_lager = git https://github.com/erlang-lager/lager 3.9.2
dep_cowboy = git https://github.com/ninenines/cowboy  2.10.0
dep_jsx = git  https://github.com/talentdeficit/jsx v3.1.0
include erlang.mk
