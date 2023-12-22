-module(test_project_handler).
-author("davyd").

%% API
-export([init/2, terminate/1]).

init(Req0, State) ->
  lager:info("New request:Req0 ~p", [Req0]),
  {ok, Body, Req1} = cowboy_req:read_body(Req0),
  Path = cowboy_req:path(Req0),
  {Code, Reply} = parse_request(Path, Body),
  Headers = #{<<"content-type">> => <<"application/json">>},
  Req = cowboy_req:reply(Code, Headers, Reply, Req1),
  {ok, Req, State}.

parse_request(<<"/import">>, Body) ->
  Reply = test_project_api:import(Body),
  lager:info("Seccessfull response:Reply ~p, Body ~p", [Reply, Body]),
  {200, Reply};

parse_request(<<"/export">>, Body) ->
  Reply = test_project_api:export(Body),
  lager:info("Seccessfull response:Reply ~p, Body ~p", [Reply, Body]),
  {200, Reply};

parse_request(Path, _Body) ->
  Reply = jsx:encode(#{wrong_path => Path}),
  lager:error("Seccessfull response:Reply ~p, Path ~p", [Reply, Path]),
  {404, Reply}.

terminate(_) ->
  ok.
