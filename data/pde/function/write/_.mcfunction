$data modify storage pde:io player.data."$(index)" set from storage pde:io input[0].data
data remove storage pde:io input[0]
scoreboard players remove #i pde.var 1
execute unless score #i pde.var matches 0 run function pde:write/_ with storage pde:io input[0]
