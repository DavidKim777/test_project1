PROJECT = test_project
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0
DEPS = jsx cowboy
dep_cowboy = git https://github.com/ninenines/cowboy  2.10.0
dep_jsx = git  https://github.com/talentdeficit/jsx v3.1.0
include erlang.mk
