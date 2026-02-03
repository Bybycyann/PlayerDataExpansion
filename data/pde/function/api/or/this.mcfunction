data modify storage pde:io output append value {}
execute store result storage pde:io output[-1].index int 1 run scoreboard players get @s pde.index
function pde:api/or/output with storage pde:io output[-1]
