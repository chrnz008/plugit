# plugit

this is a simple plugin manager written in batch script for vim.
originally intended for vim but can be modified to work with any utility

## dependencies
1. git
2. cmd

## usage

```batch
plugit i               - install
plugit u               - update
plugit r               - remove
plugit r <plugin-name> - remove <plugin-name>
```
- the package list is read from packs.txt file
- ; (semicolon) can be used to comment lines

## todo
- [X] options to remove specific plugins
- [ ] opt plugins support
- [ ] support downgrading (tagging)
- [ ] better messages and interface instead of git messages
- [ ] Can simplify arg dispatch eg: Instead of nested ifs using labels
- [ ] add wget or curlable plugins or scripts
- [ ] use either spaces or tabs in source code
