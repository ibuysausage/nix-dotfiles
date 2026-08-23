vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Verify if the current directory is a git repo
		local is_git = os.execute("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
		if is_git ~= 0 then
			return
		end

		-- Perform an async fetch to avoid startup lag
		vim.fn.jobstart("git fetch", {
			on_exit = function()
				-- Get the number of commits the remote is ahead of local HEAD
				local count = vim.fn.system("git rev-list --count HEAD..@{u} 2>/dev/null"):gsub("%s+", "")

				if count ~= "" and tonumber(count) > 0 then
					vim.schedule(function()
						vim.notify(
							"󰊢 " .. count .. " new commit(s) available on remote.",
							vim.log.levels.INFO,
							{ title = "Git Status", icon = "󰊢" }
						)
					end)
				end
			end,
		})
	end,
})
