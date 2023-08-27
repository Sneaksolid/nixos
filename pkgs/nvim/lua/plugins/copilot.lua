return {
	"zbirenbaum/copilot.lua",
	event = "LspAttach",
	config = true,
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
			}
		}
	}
}
