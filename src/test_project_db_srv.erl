%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. січ 2024 13:22
%%%-------------------------------------------------------------------
-module(test_project_db_srv).
-author("davyd").
-behavior(gen_server).

%% API
-export([start_link/0]).
-export([init/1]).

-export([equery/2]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([terminate/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [[]], []).

equery(Sql, Parameters) ->
  Map = #{sql => Sql, parameters => Parameters},
  gen_server:call(?MODULE, Map).


init(_) ->
  application:get_env(test_project, db),
  {ok, Connect} = epgsql:connect(#{
    host => "127.0.0.1",
    username => "postgres",
    password => "kd050701",
    database => "test_project"
  }),
  {ok, #{connect => Connect}}.



handle_call(#{sql:=Sql, parameters:=Params}, _From, #{connect:=Connect} = State) ->
  Res = epgsql:equery(Connect,  Sql, Params),
  {reply, Res, State};

handle_call(_, _From, State) ->
  {reply, ok, State}.

handle_cast(_, State) ->
  {noreply, State}.


terminate(_Reson, State) ->
  Connect = maps:get(connect, State),
  ok = epgsql:close(Connect).