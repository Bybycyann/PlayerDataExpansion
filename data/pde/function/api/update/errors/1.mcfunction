# ```
# 执行者与目标不匹配
# ```

tellraw @s [\
    {text:"[pde] ",hover_event:{action:"show_text",value:[{text:"PlayerDataExpansion"},"\n",{text:"[lib]玩家数据拓展.",color:"green"}]}},\
    {fallback:"error：%s",with:[{fallback:"无法执行#pde:data.update：执行者与目标不匹配",with:[{storage:"pde:io",nbt:"output[-1].index"}],translate:""}],color:"red",hover_event:{action:"show_text",value:[{text:"#pde:data.update",color:"yellow"}]},translate:""}\
    ]