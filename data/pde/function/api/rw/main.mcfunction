# ```
# 创建读写工作区
# ```
scoreboard players set #return pde.var -1

data modify storage pde:io stack append value {}

$data modify storage pde:io stack[-1].player set value $(player)
function #pde:data.or with storage pde:io stack[-1]
execute unless score #return pde.var matches 0 run function pde:api/rw/_

data remove storage pde:io stack[-1]
