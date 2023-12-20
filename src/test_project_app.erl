-module(test_project_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
	 {'_',[{"/[...]", test_project_handler, []}]}
]),
	{ok, _} = cowboy:start_clear(test_project,
		[{port, 8080}],
		#{env => #{dispatch => Dispatch}}),
	test_project_sup:start_link().


stop(_State) ->
	ok.
