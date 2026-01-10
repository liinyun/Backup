local root_files = { "Project.toml", "JuliaProject.toml" }
local server_path = "/home/linya/.julia/packages/LanguageServer/Fwm1f/src/"
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

-- local function activate_env(path)
-- 	assert(vim.fn.has("nvim-0.10") == 1, "requires Nvim 0.10 or newer")
-- 	local bufnr = vim.api.nvim_get_current_buf()
-- 	local julials_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "julials" })
-- 	assert(
-- 		#julials_clients > 0,
-- 		"method julia/activateenvironment is not supported by any servers active on the current buffer"
-- 	)
-- 	local function _activate_env(environment)
-- 		if environment then
-- 			for _, julials_client in ipairs(julials_clients) do
-- 				---@diagnostic disable-next-line: param-type-mismatch
-- 				julials_client:notify("julia/activateenvironment", { envPath = environment })
-- 			end
-- 			vim.notify("Julia environment activated: \n`" .. environment .. "`", vim.log.levels.INFO)
-- 		end
-- 	end
-- 	if path then
-- 		path = vim.fs.normalize(vim.fn.fnamemodify(vim.fn.expand(path), ":p"))
-- 		local found_env = false
-- 		for _, project_file in ipairs(root_files) do
-- 			local file = vim.uv.fs_stat(vim.fs.joinpath(path, project_file))
-- 			if file and file.type then
-- 				found_env = true
-- 				break
-- 			end
-- 		end
-- 		if not found_env then
-- 			vim.notify("Path is not a julia environment: \n`" .. path .. "`", vim.log.levels.WARN)
-- 			return
-- 		end
-- 		_activate_env(path)
-- 	else
-- 		local depot_paths = vim.env.JULIA_DEPOT_PATH
-- 				and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has("win32") == 1 and ";" or ":")
-- 			or { vim.fn.expand("~/.julia") }
-- 		local environments = {}
-- 		vim.list_extend(environments, vim.fs.find(root_files, { type = "file", upward = true, limit = math.huge }))
-- 		for _, depot_path in ipairs(depot_paths) do
-- 			local depot_env = vim.fs.joinpath(vim.fs.normalize(depot_path), "environments")
-- 			vim.list_extend(
-- 				environments,
-- 				vim.fs.find(function(name, env_path)
-- 					return vim.tbl_contains(root_files, name) and string.sub(env_path, #depot_env + 1):match("^/[^/]*$")
-- 				end, { path = depot_env, type = "file", limit = math.huge })
-- 			)
-- 		end
-- 		environments = vim.tbl_map(vim.fs.dirname, environments)
-- 		vim.ui.select(environments, { prompt = "Select a Julia environment" }, _activate_env)
-- 	end
-- end
local M = {
	cmd = {
		"julia",
		"--project=" .. server_path,
		"--startup-file=no",
		"--history-file=no",
		-- tracecompilelsp.jl file won't be overwritten with lsp changes
		-- so after update of a lsp, I should delete the original tracecompilelsp.jl file
		"--sysimage=/home/linya/applications/lsp/julials/julials.so",
		"--sysimage-native-code=yes",
		"-e",
		[[
          using Pkg;
          Pkg.instantiate()
          using LanguageServer; using SymbolServer; using StaticLint;
          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
          project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
          # Make sure that we only load packages from this environment specifically.
          @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
          server.runlinter = true;
          run(server);
        ]],
	},
	filetypes = { "julia" },
	root_markers = {
		"Project.toml",
		"JuliaProject.toml",
	},
	capabilities = lsp_capabilities,
	on_attach = function(_, bufnr)
		-- vim.api.nvim_buf_create_user_command(bufnr, "LspJuliaActivateEnv", activate_env, {
		-- 	desc = "Activate a Julia environment",
		-- 	nargs = "?",
		-- 	complete = "file",
		-- })
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
}
return M
