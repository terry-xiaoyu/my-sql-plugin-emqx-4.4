# emqx-sql-plugin-demo

This is a demo plugin project for EMQX version 4.3.x and 4.4.x

## How to use

1. Clone and compile the project

```shell
git clone https://github.com/terry-xiaoyu/my-sql-plugin-emqx-4.4.git
./rebar3 compile
```
After compiling, you will get the target plugin files (`ebin` and `priv`) in `_build/default/lib/my_sql_plugin/`:

```shell
mkdir ./my_sql_plugin
cp -r _build/default/lib/my_sql_plugin/ebin _build/default/lib/my_sql_plugin/priv ./my_sql_plugin
```

2. Copy the plugin to the EMQX plugin directory

```shell
## set it to your EMQX installation path, and make sure the `emqx` user has permission to access it
export EMQX4_PATH=/var/lib/emqx

mkdir -p $EMQX4_PATH/data/plugins
cp -r ./my_sql_plugin $EMQX4_PATH/data/plugins/
```

3. Change the `expand_plugins_dir` in `emqx.conf`

```shell
vi etc/emqx.conf

plugins.expand_plugins_dir = $EMQX4_PATH/data/plugins/
```

Where `$EMQX4_PATH` must be replaced with your actual EMQX installation path set in the previous step.

4. Re-start EMQX to apply the config changes.

Plugins in `plugins.expand_plugins_dir` will be loaded automatically when EMQX starts.

5. Test it by create a rule:

```SQL
SELECT emqx_rule_funcs2.echo('a') as var FROM "t/#"
```

Note that the module that contains the sql functions must be prefixed by `emqx_rule_funcs`, e.g. `emqx_rule_funcs2`.
