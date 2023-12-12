%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. гру 2023 14:32
%%%-------------------------------------------------------------------
-module(test_project_api).
-author("davyd").

%% API
-export([import/1, export/1]).

import(Json) ->
  Decode = jsx:decode(Json),
  Key = maps:get(<<"Key">>, Decode),
  TimeStamp = maps:get(<<"TimeStamp">>, Decode),
  Value = maps:get(<<"Value">>, Decode),
  Res = test_module:import(Key, TimeStamp, Value),
  jsx:encode(Res).

export(Json) ->
  Decode = jsx:decode(Json),
  Key = maps:get(<<"Key">>, Decode),
  TimeStamp = maps:get(<<"TimeStamp">>, Decode),
  Res = test_module:export(Key, TimeStamp),
  Res1 = [#{<<"Key">> => Key1, <<"TimeStamp">> => TIme, <<"Value">> => Value} || {Key1, TIme, Value} <- Res],
  jsx:encode(Res1).
