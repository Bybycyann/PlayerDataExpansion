data modify entity @s text set value {selector:"@a[tag=temp,limit=1]"}
data modify storage pde:io stack[-1].name set from entity @s text.text
kill @s