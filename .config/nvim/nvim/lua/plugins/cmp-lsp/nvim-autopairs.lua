-- Auto-completion of bracket/paren/quote pairs
return {
	-- https://github.com/windwp/nvim-autopairs
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	-- dependencies = {
	-- 	"hrsh7th/nvim-cmp",
	-- },
	opts = {
		check_ts = true, -- enable treesitter
		ts_config = {
			lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			javascript = { "template_string" }, -- don't add pairs in javascript template_string
		},
	},
	config = function(_, opts)
		local autopairs = require("nvim-autopairs")
		autopairs.setup(opts)

		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- local cmp = require("cmp")
		-- 这个设置能让我们在补全代码的时候自动插入括号
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
