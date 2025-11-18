return {
	"tpope/vim-dadbod",
	config = function()
		vim.g.dbs = {
			health_db = "mariadb://linya@localhost/health_monitoring_db",
		}
	end,
	-- enabled = false,
}
