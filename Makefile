PROJECT = test_project
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0
ERLC_OPTS += "+{parse_transform, lager_transform}"
DEPS = jsx cowboy lager epgsql erlcron
dep_erlcron = git https://github.com/erlware/erlcron v0.3.0
dep_epgsql = git https://github.com/epgsql/epgsql 4.6.0
dep_lager = git https://github.com/erlang-lager/lager 3.9.2
dep_cowboy = git https://github.com/ninenines/cowboy  2.10.0
dep_jsx = git  https://github.com/talentdeficit/jsx v3.1.0
include erlang.mk
