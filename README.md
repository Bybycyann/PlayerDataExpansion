# PlayerDataExpansion

English | [简体中文](./README_zh.md)

## Overview

This datapack creates additional storage space for each player within a shared storage. It provides simple function calls for reading and writing player-specific data while maintaining good performance under normal conditions. A built-in caching mechanism prevents excessive overhead from repeatedly accessing player data within a single game tick.

## Command Storage Format

```json
Storage pde:io
--------------------------------------------------
"player": {
	"index": {
		"uuid": <Player Index Number>,
	},
	"data": {
		"score_index": {
            "index": <Player Index Number>,
            "data": {
                "CONST": {
                    "name": <Player Name>,
                    "uuid": [<UUID as Integer Array>]
                },
                "CACHE": {
                    "timestamp": <Timestamp>,
                    "data": {<Cached Player Data>}
                },
                ...<Other Data>...
            }
        },
    }
},
"input": [],
"output": [],
"stack": []
```

**Player Data Structure**

|  Storage   |                         Description                          |
| :--------: | :----------------------------------------------------------: |
| CONST.name |                         Player Name                          |
| CONST.uuid |                Player UUID (as integer array)                |
| CACHE.data | Cached player data<br />(Updated when calling `#pde:data.cache`; refreshed at most once per tick) |

## Input & Output

Both input and output use a queue structure. To access or modify player data, you first need to request a working environment by calling one of the following functions:

```mcfunction
function #pde:data.(or(Read-only mode)|rw(Read-write mode)|cache(Update cache and read)) {player: ("this"|<Index>)}
```

## Function

|      Function      |                           Purpose                            |        Parameters         |
| :----------------: | :----------------------------------------------------------: | :-----------------------: |
| `#pde:data.cache`  | Reads player data into `pde:io.output[-1].data`, checks the timestamp, and updates `pde:io.player.data.<index>.data.CACHE.data` if it is not from the current tick. The updated cache is then synced to `pde:io.output[-1].data.CACHE.data`. | {player: ("this"\|index)} |
|   `#pde:data.or`   |       Reads player data into `pde:io.output[-1].data`.       | {player: ("this"\|index)} |
|   `#pde:data.rw`   | Creates two copies of the target player’s data: one in `pde:io.input[-1].data` and another in `pde:io.output[-1].data`. | {player: ("this"\|index)} |
| `#pde:data.update` | Immediately writes back the data from `pde:io.input[-1]` instead of waiting until the end of the tick. **Safety check**: Only allowed if the executor’s index number matches the target of `input[-1]`, preventing accidental out-of-bounds writes. |             -             |
| `#pde:data.reset`  |      **DANGEROUS**: Resets all player indices and data.      |             -             |

## Example

**Read Player UUID and Name**

```mcfunction
# As player:

function #pde:data.or {player: "this"}
	data modify storage xxx:xxx uuid set from storage pde:io output[-1].data.CONST.uuid
	data modify storage xxx:xxx name set from storage pde:io output[-1].data.CONST.name
```

**Modify Data for Player Index 2**

```mcfunction
function #pde:data.rw {player: 2}
    data modify storage pde:io input[-1].example set value "test"
    data modify storage pde:io input[-1] merge {aaa: "bbb"}
```

**Write New Data to Own Storage and Update Immediately**

```mcfunction
function #pde:data.rw {player: "this"}
	data modify storage pde:io input[-1] merge {new: 1b}
function #pde:data.update
```

**Access Player Data Cache**

```mcfunction
function #pde:data.cache {player: "this"}
	data get storage pde:io output[-1].data.CACHE.data.Health
```

