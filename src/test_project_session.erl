%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. гру 2023 14:31
%%%-------------------------------------------------------------------
-module(test_project_session).
-author("davyd").

%% API
-export([new_table/0, create_session/1, close_session/1, find_user_id_by_session/1]).

-record(session, {session_id, user_id, login_time}).

new_table() ->
  Res = ets:new(session, [named_table, set, public, {keypos, #session.session_id}]),
  {ok, Res}.

create_session(UserId) ->
  SessionId = erlang:phash2({UserId, os:timestamp()}),
  Session = #session{session_id = SessionId, user_id = UserId, login_time = os:timestamp()},
  ets:insert(session, Session),
  lager:info("Result:Session ~p", [Session]).

close_session(SessionId) ->
  ets:delete(session, SessionId).

find_user_id_by_session(SessionId) ->
  MatchSpec = {session, SessionId, '$1', '_'},
  lager:info("Result:MatchSpec ~p", [MatchSpec]),
  Res = ets:match(session, MatchSpec),
  io:write(Res),
  case  Res of
    [[UserId]] -> {ok, UserId};
    [] -> not_found
  end.