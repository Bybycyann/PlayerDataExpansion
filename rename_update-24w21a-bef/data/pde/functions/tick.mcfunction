# ```
# tick
# ```

# PLAYER JOIN GAME
execute as @a[predicate=pde:joingame] run function pde:init/main

# 栈弹出与数据写入
data modify storage pde:io output set value []
function pde:write/main
