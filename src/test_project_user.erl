%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. гру 2023 13:01
%%%-------------------------------------------------------------------
-module(test_project_user).
-author("davyd").

%% API
-export([add_ets_for_users/0, add_users/2, del/1, find_users/2]).

add_ets_for_users() ->
  ets:new(users, [named_table, set, public]),
  ets:insert_new(users, {id, 0}).


add_users( Name, Password)->
  Id = incr(),
  NewRecord = {Name, Id, Password},
  Res = ets:insert_new(users, NewRecord),
  {Res, Id}.

del(Name) ->
  ets:delete(users, Name).

find_users(Name, Password) ->
  case ets:lookup(users, Name) of
    [{Name, Id, Password}|_] ->
      {ok, {logined, Id}};
    [{Name, Id, _}|_] ->
      {ok, {incorrect_pw, Id}};
    _ ->
      {error, undefined}
  end.

incr() ->
  ets:update_counter(users, id, {2, 1}, {id, 0}).