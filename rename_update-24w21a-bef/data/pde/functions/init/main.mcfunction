# ```
# 玩家初始化
# ```

scoreboard players set @s pde.join 0

data modify storage pde:io stack append value {}

# 档案存在性检查
data modify storage pde:io stack[-1].uuid set from entity @s UUID
execute store result score #boole pde.var run function pde:init/_ with storage pde:io stack[-1]
# 档案不存在
execute if score #boole pde.var matches 0 run function pde:init/0/main
# 档案存在
execute if score #boole pde.var matches 1 unless score #value pde.var = @s pde.index run scoreboard players operation @s pde.index = #value pde.var

data remove storage pde:io stack[-1]
