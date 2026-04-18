# ```
# 目标不在线上
# ```

tellraw @s [\
    {"text":"[pde] ","hoverEvent":{"action":"show_text","value":[{"text":"PlayerDataExpansion"},"\n",{"text":"[lib]玩家数据拓展.","color":"green"}]}},\
    {"fallback":"error：%s","with":[{"fallback":"获取数据时发生错误：索引为“%s”的玩家未在线","with":[{"storage":"pde:io","nbt":"output[-1].index"}],"translate":""}],"color":"red","hoverEvent":{"action":"show_text","value":[{"text":"#pde:data.cache","color":"yellow"}]},"translate":""}\
    ]