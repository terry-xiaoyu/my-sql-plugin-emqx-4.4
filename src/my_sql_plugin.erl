-module(my_sql_plugin).

-export([ load/1
        , unload/0
        ]).

-export([ echo/1 ]).

echo(A) ->
    A.

%% Called when the plugin application start
load(_Env) ->
    ok.

unload() ->
    ok.
