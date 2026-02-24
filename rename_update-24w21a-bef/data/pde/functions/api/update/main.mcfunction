# ```
# 立即推送 (存在风险)
# ```

execute unless score #return pde.var matches 2 run return run function pde:api/update/errors/0
execute store result score #i pde.var run data get storage pde:io input[-1].index
execute unless score #i pde.var = @s pde.index run return run function pde:api/update/_

function pde:api/update/write with storage pde:io input[-1]
data remove storage pde:io input[-1]
data remove storage pde:io output[-1]
