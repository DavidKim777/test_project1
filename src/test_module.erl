%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. лис 2023 10:37
%%%-------------------------------------------------------------------
-module(test_module).
-author("davyd").
-behavior(gen_server).
%% API
-export([start_link/0]).
-export([stop/0]).
-export([init/1]).

-export([handle_call/3]).
-export([handle_cast/2]).
-export([import/3]).
-export([export/2]).
-record(state, {key, time, value}).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [[]], []).

stop() ->
  ok.

init(_) ->
  ets:new(state, [bag,  public, named_table]),
  {ok, #state{}}.

import(Key, TimeStamp, Value) ->
  gen_server:call(?MODULE, {import, Key, TimeStamp, Value}).

export(Key, TimeStamp) ->
  gen_server:call(?MODULE, {export, Key, TimeStamp}).

handle_call({import, Key, TimeStamp, Value}, _From, State) ->
  NewRecord = {Key, TimeStamp, Value},
  io:format("Importing record: ~p~n", [NewRecord]),
  ets:insert(state, NewRecord),
  {reply, ok, State};



handle_call({export, Key, TimeStamp}, _From, State) ->
  Result = ets:lookup(state, Key),
  Result1 = [El || {_Key, TIme, _Value} = El <- Result, TIme > TimeStamp],
  {reply, Result1, State};



handle_call(Msg, _From, State) ->
  io:format("unexpected message ~p", [Msg]),
  {reply, ok , State}.


handle_cast(_Msg, State) ->
  {noreply, State}.
