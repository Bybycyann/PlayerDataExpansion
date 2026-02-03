# ```
# 上游读取错误 终止推送
# ```

tellraw @s [\
    {text:"[pde] ",hover_event:{action:"show_text",value:[{text:"PlayerDataExpansion"},"\n",{text:"[lib]玩家数据拓展.",color:"green"}]}},\
    {fallback:"error：%s",with:[{fallback:"无法执行#pde:data.update：读写错误或环境缺失",with:[{storage:"pde:io",nbt:"output[-1].index"}],translate:""}],color:"red",hover_event:{action:"show_text",value:[{text:"#pde:data.update",color:"yellow"}]},translate:""}\
    ]