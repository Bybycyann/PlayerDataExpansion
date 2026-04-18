# ```
# 缓存数据
# ```
scoreboard players set #return pde.var -1

data modify storage pde:io stack append value {}

$data modify storage pde:io stack[-1].param.player set value $(player)
execute if data storage pde:io stack[-1].param{player:"this"} run function pde:api/or/this
execute unless data storage pde:io stack[-1].param{player:"this"} run function pde:api/or/other
execute unless score #return pde.var matches 0 run function pde:api/cache/_

data remove storage pde:io stack[-1]
