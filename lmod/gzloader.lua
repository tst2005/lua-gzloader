--package.searchpath (name, path [, sep [, rep]])
assert(package.searchpath)
local searchers = package.searchers or package.loaders
assert( type(searchers)=="table" )

local gunzip = assert(require 'compress.deflatelua'.gunzip)
local disable_crc = true
local function zcat(i, o)
	gunzip {input=i, output=o, disable_crc=disable_crc}
end
local function zget(i)
	local data = {}
	local o = {}
	function o.write(msg)
		if type(msg)=="number" then
			msg=string.char(msg)
		end
		data[#data+1]=msg
	end
	gunzip {input=i, output=o.write, disable_crc=disable_crc}
	return table.concat(data)
end

local function gzloader(name)
	local path = package.gzpath or (package.path..";"):gsub("%.lua;",".lua.gz;"):sub(1,-2)
	local found, err = package.searchpath(name, path)
	if not found then
		return nil, err
	end
	local fd = io.open(found, "r")
	local luacode = zget(fd)
	fd:close()
	local f = assert(load(luacode))
	return f
end

searchers[#searchers+1] = gzloader
return {}
