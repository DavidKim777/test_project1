-module(test_project_handler).
-author("davyd").

%% API
-export([init/2, terminate/1]).

init(Req0, State) ->
  lager:info("New request:Req0 ~p", [Req0]),
  {ok, Body, Req1} = cowboy_req:read_body(Req0),
  Req =  case cowboy_req:path(Req1) of
            <<"/reg">> ->
              [{Login, Passwd}] = cowboy_req:parse_qs(Req1),
              {true, Id} =  test_project_user:add_users(Login, Passwd),
              Req2 = cowboy_req:set_resp_cookie(<<"user_id">>, erlang:integer_to_binary(Id), Req0),
              cowboy_req:reply(200, #{}, <<"ok">>, Req2);
           <<"/import">> ->
             Reply =  test_project_api:import(Body),
              cowboy_req:reply(200, #{}, Reply, Req1);
           <<"/export">> ->
             Reply = test_project_api:export(Body),
             cowboy_req:reply(200, #{}, Reply, Req1);
            <<"/login">> ->
              [{Login, Passwd}] = cowboy_req:parse_qs(Req1),
              case test_project_user:find_users(Login, Passwd) of
                {ok, {logined, Id}} ->
                  Req1 = cowboy_req:set_resp_cookie(<<"user_id">>, erlang:integer_to_binary(Id), Req0),
                  cowboy_req:reply(200, #{}, <<"ok">>, Req1);
                {ok, _} ->
                  cowboy_req:reply(400, #{}, <<"not_ok">>, Req0);
                _ ->
                  cowboy_req:reply(400, #{}, <<"undefined">>, Req0)
              end;
            _ ->
              cowboy_req:reply(400, #{}, <<"wrong_path">>, Req0)
              end,
  {ok, Req, State}.



terminate(_) ->
  ok.