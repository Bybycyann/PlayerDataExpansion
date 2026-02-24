# ```
# 档案存在性检查
# ```

scoreboard players set #value pde.var -1
$execute if data storage pde:io player.index."$(uuid)" store result score #value pde.var run data get storage pde:io player.index."$(uuid)"
execute if score #value pde.var matches -1 run return 0
return 1