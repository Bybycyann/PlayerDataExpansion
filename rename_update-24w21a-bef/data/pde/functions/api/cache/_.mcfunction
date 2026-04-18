execute unless entity @a[predicate=pde:player_index,limit=1] run return run function pde:api/cache/errors/0

execute store result score #i pde.var run data get storage pde:io output[-1].data.CACHE.timestamp
execute store result score #j pde.var run time query gametime
execute if score #i pde.var = #j pde.var run return 0
execute store result storage pde:io output[-1].data.CACHE.timestamp int 1 run scoreboard players get #j pde.var
data modify storage pde:io output[-1].data.CACHE.data set from entity @a[predicate=pde:player_index,limit=1]
function pde:api/cache/__ with storage pde:io output[-1]
