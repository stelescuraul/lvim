-- local node_bin = '/home/raul/.nvm/versions/node/v16.18.1/bin'
-- vim.g.node_host_prog = node_bin .. '/node'
-- vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")

vim.opt.updatetime = 50
vim.opt.timeoutlen = 150
vim.opt.relativenumber = true
vim.opt.nu = true

-- vim.opt.guicursor = ""
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.keymap.set("n", "J", "mzJ`z")       -- Join lines but keep the cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keep cursor in middle when going down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- keep cursor in middle when going down
vim.keymap.set("n", "n", "nzzzv")       -- keep cursor in middle when searching
vim.keymap.set("n", "N", "Nzzzv")       -- keep cursor in middle when searching

_G.lsp_organize_imports_sync = function(bufnr)
  -- gets the current bufnr if no bufnr is passed
  if not bufnr then bufnr = vim.api.nvim_get_current_buf() end

  -- params for the request
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(bufnr) },
    title = ""
  }

  -- perform a syncronous request
  -- 500ms timeout depending on the size of file a bigger timeout may be needed
  vim.lsp.buf_request(bufnr, "workspace/executeCommand", params)
end
vim.cmd("command! LspOrganize lua lsp_organize_imports_sync()")

lvim.builtin.which_key.mappings["lo"] = {
  "<cmd>LspOrganize <cr>", "Organize Imports"
}
lvim.builtin.which_key.mappings["lf"] = {
  ":lua vim.lsp.buf.format() <cr>", "Format"
}

-- Add a terminal
-- lvim.builtin.which_key.mappings["nt"] = {
--   "<cmd>terminal <cr>", "Terminal"
-- }

-- mappings


--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "rose-pine"

lvim.builtin.autopairs.disable_in_macro = true
lvim.builtin.autopairs.enable_afterquote = false

lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.cmp.experimental.ghost_text = false
lvim.builtin.treesitter.highlight.enable = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<C-j"] = "<C-n>"
-- lvim.keys.normal_mode["<C-k"] = "<C-p>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- local trouble = pcall(require ,'trouble')

lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<C-h>"] = "which_key"
  },
  -- for normal mode
  n = {
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous"
  },
}
lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"]
lvim.builtin.which_key.mappings["bN"] = { "<cmd>enew<cr>", "New Buffer" }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["p"] = {
  name = "+Project",
  t = { "<cmd>Telescope <CR>", "Telescope" },
  f = {
    function()
      require("lvim.core.telescope.custom-finders").find_project_files { previewer = false }
    end,
    "Find File",
  }
  -- a = { "<cmd>AerialToggle <CR>", "Aerial" }
}
lvim.builtin.which_key.mappings["ba"] = { "<cmd>AerialToggle <CR>", "Aerial" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
-- lvim.builtin.nvimtree.setup.update_cwd = false
-- lvim.builtin.nvimtree.setup.sync_root_with_cwd = false
-- lvim.builtin.nvimtree.setup.respect_buf_cwd = false
-- lvim.builtin.nvimtree.setup.update_focused_file.update_root = false
-- lvim.builtin.nvimtree.setup.update_focused_file.enable = false
-- lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false

-- lvim.builtin.project.detection_methods = { "pattern" }
-- lvim.builtin.project.patterns = { ".git" }

-- lvim.builtin.project.manual_mode = false
-- lvim.builtin.project.show_hidden = true

lvim.builtin.project.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "markdown"
  "go",
  "gomod"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
-- local opts = {
--   root_dir = require("lspconfig").util.root_pattern(".git") } -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("tsserver", opts)

-- require 'lspconfig'.tsserver.setup {}

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- local null_ls = require 'lvim.lsp.null-ls';
-- local null_ls_utils = require 'lvim.lsp.null-ls.utils';

-- null_ls.setup({
--   root_dir = null_ls_utils.root_pattern(".null-ls-root", ".git", "")
-- })

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "black" },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettierd",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact", "json" },
  },
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "eslint",
  --   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  -- },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- {
  --   command = "eslint_d",
  --   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  -- }
  -- { command = "flake8", filetypes = { "python" } },
  -- {
  --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "shellcheck",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--severity", "warning" },
  -- },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
}

--- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  },
  {
    'rafamadriz/neon'
  },
  {
    'theprimeagen/harpoon'
  },
  {
    'rose-pine/neovim'
  },
  { "mxsdev/nvim-dap-vscode-js",              requires = { "mfussenegger/nvim-dap" } },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { "github/copilot.vim" },
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  },
  "olexsmir/gopher.nvim",
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

lvim.keys.normal_mode["<C-e>"] = ui.toggle_quick_menu
lvim.builtin.which_key.mappings["a"] = {
  name = "Harpoon",
  a = { mark.add_file, "Add" },
  q = { function() ui.nav_file(1) end, "Buffer 1" },
  w = { function() ui.nav_file(2) end, "Buffer 2" },
  e = { function() ui.nav_file(3) end, "Buffer 3" },
  r = { function() ui.nav_file(4) end, "Buffer 4" }
}

local dap_vscode = require('dap-vscode-js')
local dap = require('dap')
local dap_utils = require('dap.utils')

dap_vscode.setup({
  debugger_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter',
  adapters = { 'pwa-node', -- 'node-terminal', 'pwa-extensionHost'
  },                       -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log", -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.DEBUG -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = dap_utils.pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    }
  }
end

-- copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- vim.g.clipboard = {
--   name = 'WslClipboard',
--   copy = {
--     ["+"] = 'clip.exe',
--     ["*"] = 'clip.exe',
--   },
--   paste = {
--     ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--   },
--   cache_enabled = 0,
-- }
-- vim.opt.clipboard = ""
