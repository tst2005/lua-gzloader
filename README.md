
# gzloader

Add an additionnal searcher to support loading module from compressed file (.lua.gz)

# Config

You can set a custom search path in `package.gzpath`.
```
package.gzpath = "./?.lua.gz;./?/init.lua.gz"
```

If the `package.gzpath` is not set, the `package.path` will be took replacing each ending `.lua` by `.lua.gz`.

# Sample

```
local gzloader = require "gzloader"

local foo = require "foo" -- will load foo.lua or foo.lua.gz
``` 

# TODO

 * compat support for each lua version (for now lua5.2+, missing package.searchpath in lua5.1)
 * clean and rewrote lot of things...

# License

* gzloader (c) 2016 TsT is under MIT License.
* [compress.deflatelua](https://github.com/davidm/lua-compress-deflatelua) (compress(c) 2008-2011 David Manura.  Licensed under the same terms as Lua (MIT).

