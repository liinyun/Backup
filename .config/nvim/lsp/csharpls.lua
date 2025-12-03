local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

return {
	cmd = { "csharp-ls" },
	filetypes = { "cs" },
	-- init_options = {
	-- 	AutomaticWorkspaceInit = true,
	-- },
	-- root_markers = vim.fs.root(0, function(name, path)
	-- 	return name:match("%.sln$") ~= nil
	-- end),
	-- root_markers = { "*.cs" },
	-- cmd_cwd = vim.fs.root(0, {
	-- 	function(name, _)
	-- 		return name:match("%.sln") ~= nil
	-- 	end,
	-- 	function(name, _)
	-- 		-- fallback if no solution file found
	-- 		return name:match("%.csproj") ~= nil
	-- 	end,
	-- }),
	-- settings = {},
	-- 	docs = {
	-- 		description = [[
	-- https://github.com/razzmatazz/csharp-language-server
	--
	-- Language Server for C#.
	--
	-- csharp-ls requires the [dotnet-sdk](https://dotnet.microsoft.com/download) to be installed.
	--
	-- The preferred way to install csharp-ls is with `dotnet tool install --global csharp-ls`.
	--     ]],
	-- 	},
}
