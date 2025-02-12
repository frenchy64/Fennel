-- Just a tiny shim to allow AOT
local fennel = dofile("bootstrap/fennel.lua")

local opts = {
   ["compiler-env"]=_G,
   allowedGlobals={},
   useMetadata=false,
   requireAsInclude=true,
   filename=assert(arg[1]),
}

for k in pairs(_G) do table.insert(opts.allowedGlobals, k) end

local f = assert(io.open(opts.filename))
local compile = function() return fennel.compileString(f:read("*a"), opts) end
local ok, val = xpcall(compile, fennel.traceback)

if(ok) then
   print(val)
else
   io.stderr:write(val)
   io.stderr:write("\n")
   os.exit(1)
end
