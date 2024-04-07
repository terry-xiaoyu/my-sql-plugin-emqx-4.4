-module(my_sql_plugin_app).

-behaviour(application).

-emqx_plugin(?MODULE).

-export([ start/2
        , stop/1
        ]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = my_sql_plugin_sup:start_link(),
    my_sql_plugin:load(application:get_all_env()),
    {ok, Sup}.

stop(_State) ->
    my_sql_plugin:unload().
