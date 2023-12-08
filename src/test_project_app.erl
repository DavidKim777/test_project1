-module(test_project_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	test_project_sup:start_link().

stop(_State) ->
	ok.
