# ```
# 写入
# ```

execute store result score #i pde.var run data get storage pde:io input
function pde:write/_ with storage pde:io input[0]
