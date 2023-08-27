return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			manual_mode = false,
			detection_methods = { "git", "pattern" },
			patterns = { "go.work", "Cargo.toml" },
			silent_chdir = false,
			exclude_dirs = { "node_modules", ".git", "iac" },
		})
	end
}
