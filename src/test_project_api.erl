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
-export([registration/1 ,login/1, logout/1, import/1, export/1]).

registration(Json) ->
  Decode = jsx:decode(Json),
  Name = maps:get(<<"Name">>, Decode),
  Password = maps:get(<<"Password">>, Decode),
  Res =  test_project_user:add_users(Name, Password),
  jsx:encode(Res).

login(Json) ->
  Decode = jsx:decode(Json),
  Name = maps:get(<<"Name">>, Decode),
  Password = maps:get(<<"Password">>, Decode),
  Res = test_project_user:find_users(Name, Password),
  jsx:encode(Res).

logout(Json) ->
  Decode = jsx:decode(Json),
  Key = maps:get(<<"SessioneId">>, Decode),
  Res = test_project_session:close_session(Key),
  jsx:encode(Res).

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
