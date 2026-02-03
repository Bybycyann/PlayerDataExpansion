$data modify storage pde:io player.index."$(uuid)" set value $(index)
$data modify storage pde:io player.data."$(index)" set value {CONST:{uuid:$(uuid),name:$(name)}}