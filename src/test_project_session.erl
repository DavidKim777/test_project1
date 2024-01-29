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
-export([new_table/0, create_session/1, close_session/1, find_user_id_by_session/1, delete_old_sessions/0]).

-record(session, {session_id, user_id, login_time}).

new_table() ->
  Res = ets:new(session, [named_table, set, public, {keypos, #session.session_id}]),
  {ok, Res}.

create_session(UserId) ->
  SessionId = erlang:phash2({UserId, os:timestamp()}),
  Session = #session{session_id = SessionId, user_id = UserId, login_time =  erlang:system_time(seconds)},
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

delete_old_sessions() ->
  CurrentTime = erlang:system_time(seconds),
  ThresholdTime = CurrentTime - 1*60 ,
  Key = ets:first(session),
  delete_old_sessions(Key, ThresholdTime).


delete_old_sessions( '$end_of_table' , _ThresholdTime) ->
  ok;
delete_old_sessions(Key, ThresholdTime) ->
  NextKey = ets:next(session, Key),
  case ets:lookup(session, Key) of
    [#session{login_time = LoginTime}] when  LoginTime < ThresholdTime ->
      ets:delete(session, Key);
    _ -> ok
  end,
  delete_old_sessions(NextKey, ThresholdTime).