local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
local M
-- local configs = require("lspconfig.configs")
-- local lspconfig = require("lspconfig")
-- local function root_pattern(root_table)
--   for item in root_table do
--     print(item)
--   end
-- end
local monkeyc_ls_jar_path =
	"/home/linya/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-8.2.2-2025-07-17-cf29b22d5/bin/LanguageServer.jar"
local monkeycLspCapabilities = vim.lsp.protocol.make_client_capabilities()
-- Need to set some variables in the client capabilities to prevent the
-- LanguageServer from raising exceptions
monkeycLspCapabilities.textDocument.declaration.dynamicRegistration = true
monkeycLspCapabilities.textDocument.implementation.dynamicRegistration = true
monkeycLspCapabilities.textDocument.typeDefinition.dynamicRegistration = true
monkeycLspCapabilities.textDocument.documentHighlight.dynamicRegistration = true
monkeycLspCapabilities.textDocument.hover.dynamicRegistration = true
monkeycLspCapabilities.textDocument.signatureHelp.contextSupport = true
monkeycLspCapabilities.textDocument.signatureHelp.dynamicRegistration = true
monkeycLspCapabilities.workspace = {
	didChangeWorkspaceFolders = {
		dynamicRegistration = true,
	},
}
monkeycLspCapabilities.textDocument.foldingRange = {
	lineFoldingOnly = true,
	dynamicRegistration = true,
}

local jungleFiles = vim.g.monkeyc_jungle_files or "monkey.jungle"
-- local root = lspconfig.util.root_pattern("monkey.jungle", "manifest.xml")
-- local root = root_pattern({"monkey.jungle", "manifest.xml"})
-- local rootPath = root(vim.fn.getcwd()) or vim.fn.getcwd()
local rootPath = vim.fn.getcwd()
-- local devKeyPath = "~/.Garmin/connect_iq_dev_key"
local devKeyPath = "~/.Garmin/ConnectIQ/developer_key"
local developerKeyPath = vim.fn.expand(devKeyPath)
if vim.g.monkeyc_connect_iq_dev_key_path then
	developerKeyPath = vim.fn.expand(vim.g.monkeyc_connect_iq_dev_key_path)
end

M = {
	cmd = {
		"java",
		-- "-Dapple.awt.UIElement=true",
		"-classpath",
		monkeyc_ls_jar_path,
		"com.garmin.monkeybrains.languageserver.LSLauncher",
	},

	-- cmd = { "monkeyc-language-server" },
	filetypes = { "monkey-c", "monkeyc", "jungle", "mss" },
	root_markers = { "monkey.jungle" },
	-- filetypes = { "monkeyc" },
	capabilities = monkeycLspCapabilities,

	init_options = {
		publishWarnings = vim.g.monkeyc_publish_warnings or true,
		compilerOptions = vim.g.monkeyc_compiler_options or "",
		typeCheckMsgDisplayed = false,
		workspaceSettings = {
			{
				path = rootPath,
				jungleFiles = {
					rootPath .. "/monkey.jungle",
				},
			},
		},
	},

	settings = {
		{
			developerKeyPath = developerKeyPath,
			compilerWarnings = true,
			compilerOptions = vim.g.monkeyc_compiler_options or "",
			developerId = "",
			jungleFiles = jungleFiles,
			javaPath = "",
			typeCheckLevel = "Default",
			optimizationLevel = "Default",
			testDevices = {
				vim.g.monkeyc_default_device or "enduro3", -- I should be getting this dynamically from the manifest file
			},
			debugLogLevel = "Default",
		},
	},

	-- ---@param client vim.lsp.Client
	-- on_attach = function(client, bufnr)
	-- 	client.server_capabilities.completionProvider = {
	-- 		-- triggerCharacters = {
	-- 		-- 	".",
	-- 		-- 	":",
	-- 		-- },
	-- 		resolveProvider = false,
	-- 		documentSelector = {
	-- 			{
	-- 				pattern = "**/*.{mc,mcgen}",
	-- 			},
	-- 		},
	-- 	}
	-- 	-- print(vim.inspect(client.config))
	-- 	-- local methods = vim.lsp.protocol.Methods
	-- 	-- local req = client.request
	--
	-- 	-- client.request = function(method, params, handler, bufnr_req)
	-- 	-- The Garmin LanguageServer returns broken file URIs for
	-- 	-- "textDocument/definition" requests that look like this:
	-- 	--
	-- 	--   "file:/absolute/path/to/file"
	-- 	--
	-- 	-- This doesn't work (notice the single / after the 'file:')
	-- 	-- and must be converted to the following (notice the three
	-- 	-- slashes):
	-- 	--
	-- 	--   "file:///absolute/path/to/file"
	-- 	--
	-- 	-- The following code overrides the response 'handler' for
	-- 	-- "textDocument/definition" requests
	-- 	--
	-- 	-- https://www.reddit.com/r/neovim/comments/1j6tv9y/comment/mgyqbha/
	-- 	--
	-- 	-- if method == methods.textDocument_definition then
	-- 	-- 	-- Override the response handler for "textDocument/definition" requests
	-- 	-- 	return req(method, params, function(err, result, context, config)
	-- 	-- 		local function fix_uri(uri)
	-- 	-- 			if uri:match("^file:/[^/]") then
	-- 	-- 				uri = uri:gsub("^file:/", "file:///") -- Fix missing slashes
	-- 	-- 			end
	-- 	-- 			return uri
	-- 	-- 		end
	-- 	--
	-- 	-- 		-- Fix the URLs as needed
	-- 	-- 		if vim.islist(result) then
	-- 	-- 			for _, res in ipairs(result) do
	-- 	-- 				if res.uri then
	-- 	-- 					res.uri = fix_uri(res.uri)
	-- 	-- 				end
	-- 	-- 			end
	-- 	-- 		elseif result.uri then
	-- 	-- 			result.uri = fix_uri(result.uri)
	-- 	-- 		end
	-- 	--
	-- 	-- 		-- Call the response handler with the fixed URIs in the result
	-- 	-- 		return handler(err, result, context, config)
	-- 	-- 	end, bufnr_req)
	-- 	-- elseif method == methods.textDocument_signatureHelp then
	-- 	-- 	-- When calling the signature help, it seems like the server expects
	-- 	-- 	-- params.context to be set
	-- 	-- 	params.context = {
	-- 	-- 		triggerKind = 1,
	-- 	-- 	}
	-- 	-- 	return req(method, params, handler, bufnr_req)
	-- 	-- else
	-- 	-- 	-- Use the default response handlers for all other requests
	-- 	-- 	return req(method, params, handler, bufnr_req)
	-- 	-- end
	-- 	-- end
	-- end,
}

return M
