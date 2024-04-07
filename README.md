# emqx-sql-plugin-demo

This is a demo plugin project for EMQX version 4.3.x and 4.4.x

## How to use

1. Clone and compile the project

```shell
git clone https://github.com/terry-xiaoyu/my-sql-plugin-emqx-4.4.git
cd my-sql-plugin-emqx-4.4 && make tar
```

After compiling, you will get the target files (`ebin` and `priv`) in `_build/my_sql_plugin.tar.gz`:

2. Copy target files of the plugin to EMQX

```shell
## set it to your EMQX installation path, and make sure the `emqx` user has permission to access it
export EMQX4_PATH=/var/lib/emqx

## copy the plugin tarball to EMQX data directory
mkdir -p $EMQX4_PATH/data/plugins
cp -r _build/my_sql_plugin.tar.gz $EMQX4_PATH/data/plugins/

## extract the tarball
cd $EMQX4_PATH/data/plugins/ && tar -zxvf my_sql_plugin.tar.gz
```

3. Update the `expand_plugins_dir` config in `emqx.conf`

```shell
vi etc/emqx.conf

plugins.expand_plugins_dir = $EMQX4_PATH/data/plugins/
```

Where `$EMQX4_PATH` must be replaced with your actual EMQX installation path set in the previous step.

4. Re-start EMQX to apply the config changes.

```shell
emqx stop
emqx start
```

Plugins in `plugins.expand_plugins_dir` will be loaded automatically when EMQX starts.

5. Test it by creating a rule:

```SQL
SELECT emqx_rule_funcs2.echo('a') as var FROM "t/#"
```

NOTE: the Erlang module that contains the sql functions must be prefixed by `emqx_rule_funcs`, e.g. `emqx_rule_funcs2`.
