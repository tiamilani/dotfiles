-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--no-ignore-vcs',
    }
  },
  extensions = {
	fzf = {
	  fuzzy = true,                    -- false will only do exact matching
	  override_generic_sorter = true,  -- override the generic sorter
	  override_file_sorter = true,     -- override the file sorter
	  case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
									   -- the default case_mode is "smart_case"
	},
	media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "jpg", "pdf"},
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')
