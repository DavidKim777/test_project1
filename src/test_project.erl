%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. гру 2023 15:25
%%%-------------------------------------------------------------------
-module(test_project).
-author("davyd").

%% API
-export([start/0]).

start() ->
  application:ensure_all_started(test_project).

