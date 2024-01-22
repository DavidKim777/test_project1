-module(test_project_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	P = [{test_module, {test_module, start_link, []},
		permanent, 5000, worker, [test_module]},
		{test_project_db_srv, {test_project_db_srv, start_link, []},
		permanent, 5000, worker, [test_project_db_srv]}],
	{ok, {{one_for_one, 10, 10}, P}}.
