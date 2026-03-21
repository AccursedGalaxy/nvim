local theme = require("core.theme")

return {
	"sainnhe/everforest",
	priority = 1000,
	config = function()
		theme.apply()
		theme.start_watcher()
	end,
}
