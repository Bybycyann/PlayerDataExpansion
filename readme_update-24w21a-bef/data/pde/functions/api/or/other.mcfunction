data modify storage pde:io output append value {}
data modify storage pde:io output[-1].index set from storage pde:io stack[-1].param.player
function pde:api/or/output with storage pde:io output[-1]
# Error
execute if data storage pde:io output[-1].data run return run scoreboard players set #return pde.var 1
function pde:api/or/errors/0
data remove storage pde:io output[-1]
scoreboard players set #return pde.var 0
