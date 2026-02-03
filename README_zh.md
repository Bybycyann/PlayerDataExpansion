# 玩家数据拓展

[English](./README.md) | 简体中文

## 概览

该数据包为每个玩家在Storage中创建了额外的存储空间, 在保持常态性能较好的前提下通过简单函数调用实现数据的写入和读出, 并含有数据缓存机制, 避免了 1tick 内使用 data 指令频繁调用玩家数据导致的高额开销.

## 命令存储格式

```json
Storage pde:io
--------------------------------------------------
"player": {
	"index": {
		"uuid": <玩家索引号>,
	},
	"data": {
		"score_index": {
            "index": <玩家索引号>,
            "data": {
                "CONST": {
                    "name": <玩家名称>,
                    "uuid": [<UUID(整形数组)>]
                },
                "CACHE": {
                    "timestamp": <时间戳>,
                    "data": {<玩家数据缓存>}
                },
                ...<其他数据>...
            }
        },
    }
},
"input": [],
"output": [],
"stack": []
```

**玩家数据**

|    存储    |                             描述                             |
| :--------: | :----------------------------------------------------------: |
| CONST.name |                        玩家的游戏名称                        |
| CONST.uuid |                     玩家的uuid(整型数组)                     |
| CACHE.data | 玩家数据缓存, 调用 `#pde:data.cache` 时更新, 每 tick 只更新一次 |

## 读 & 写

输入与输出均采用队列结构, 访问, 读写玩家数据时输入下面指令申请工作区 :

```mcfunction
function #pde:data.(or(只读模式)|rw(读写模式)|cache(更新缓存并读取)) {player: ("this"|<Index>)}
```

## 函数

|        函数        |                             功能                             |           参数            |
| :----------------: | :----------------------------------------------------------: | :-----------------------: |
| `#pde:data.cache`  | 读取玩家数据至 `pde:io output[-1].data` 并检查时间戳标记, 若不在同一tick则更新 `pde:io player.data.<index>.data.CACHE.data` 并同步至 `pde:io output[-1].data.CAHCE.data` | {player: ("this"\|index)} |
|   `#pde:data.or`   |           读取玩家数据至 `pde:io output[-1].data`            | {player: ("this"\|index)} |
|   `#pde:data.rw`   | 同时创建两个目标玩家数据的备份在 `pde:io input[-1].data` 和 `pde:io output[-1].data` | {player: ("this"\|index)} |
| `#pde:data.update` | 立即更新 `pde:input[-1]` 的数据, 而非统一在 1tick 后更新.<br />**安全检查**: 为防止越界操作, 仅当执行者与 `input[-1]` 操作对应目标的索引号一致时允许推送数据 |             -             |
| `#pde:data.reset`  |                 重置索引与所有玩家数据(危险)                 |             -             |

## 示例

- **读取玩家UUID和Name**

  ```mcfunction
  # As player:
  
  function #pde:data.or {player: "this"}
  	data modify storage xxx:xxx uuid set from storage pde:io output[-1].data.CONST.uuid
  	data modify storage xxx:xxx name set from storage pde:io output[-1].data.CONST.name
  ```
  
- **向索引为2的玩家存储中修改数据和写入数据**

  ```mcfunction
  function #pde:data.rw {player: 2}
  	data modify storage pde:io input[-1].example set value "test"
  	data modify storage pde:io input[-1] merge {aaa: "bbb"}
  ```

- **向自己的存储中写入新数据并立即更新**

  ```mcfunction
  function #pde:data.rw {player: "this"}
  	data modify storage pde:io input[-1] merge {new: 1b}
  function #pde:data.update
  ```

- **访问玩家数据缓存**

  ```mcfunction
  function #pde:data.cache {player: "this"}
  	data get modify storage pde:io output[-1].data.CACHE.data.Health
  ```

  