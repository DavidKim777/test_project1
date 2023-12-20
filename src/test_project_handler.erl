%%%-------------------------------------------------------------------
%%% @author davyd
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. гру 2023 12:22
%%%-------------------------------------------------------------------
-module(test_project_handler).
-author("davyd").

%% API
-export([init/2, terminate/1]).

init(Req0, State) ->
  {ok, Body, Req1} = cowboy_req:read_body(Req0),
  Path = cowboy_req:path(Req0),
  {Code, Reply} = parse_request(Path, Body),
  Headers = #{<<"content-type">> => <<"application/json">>},
  Req = cowboy_req:reply(Code, Headers, Reply, Req1),
  {ok, Req, State}.

parse_request(<<"/import">>, Body) ->
  Reply = test_project_api:import(Body),
  {200, Reply};

parse_request(<<"/export">>, Body) ->
  Reply = test_project_api:export(Body),
  {200, Reply};

parse_request(Path, _Body) ->
  Reply = jsx:encode(#{wrong_path => Path}),
  {404, Reply}.

terminate(_) ->
  ok.
