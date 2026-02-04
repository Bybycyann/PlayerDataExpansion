# ```
# 新建档案
# ```
tag @s add temp
execute summon minecraft:text_display run function pde:init/0/name/main
tag @s remove temp

execute store result score @s pde.index run scoreboard players add #index pde.index 1
execute store result storage pde:io stack[-1].index int 1 run scoreboard players get #index pde.index
function pde:init/0/_ with storage pde:io stack[-1]
