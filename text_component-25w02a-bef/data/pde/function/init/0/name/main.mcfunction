data modify entity @s text set value '{"selector":"@a[tag=temp,limit=1]"}'
function pde:init/0/name/_ with entity @s
data modify storage pde:io stack[-1].name set from storage pde:io stack[-1].text.text
kill @s