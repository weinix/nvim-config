local utils = require("utils")
local fn = vim.fn

local packer_install_dir = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

local plug_url_format = ""
if vim.g.is_linux then
  plug_url_format = "https://hub.fastgit.org/%s"
else
  plug_url_format = "https://github.com/%s"
end

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

require("packer").startup({
  function(use)
    use({"wbthomason/packer.nvim", opt = true})

    -- nvim-lsp configuration
    use({ "neovim/nvim-lspconfig", event = 'VimEnter', config = [[require('config.lsp')]] })

    -- auto-completion engine
    use({ "hrsh7th/nvim-compe", event = "InsertEnter *", config = [[require('config.compe')]] })

    if vim.g.is_mac then
      use({ "nvim-treesitter/nvim-treesitter", event = 'BufEnter', run = ":TSUpdate", config = [[require('config.treesitter')]] })
    end

    -- Python syntax highlighting and more
    if vim.g.is_win then
      use({ "numirias/semshi", ft = "python", config = "vim.cmd [[UpdateRemotePlugins]]" })
    end

    -- Python indent (follows the PEP8 style)
    use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

    -- Python-related text object
    use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

    use({"machakann/vim-swap", event = "VimEnter"})

    -- IDE for Lisp
    if utils.executable("sbcl") then
      -- use 'kovisoft/slimv'
      use({ "vlime/vlime", rtp = "vim/", ft = { "lisp" } })
    end

    -- Super fast movement with vim-sneak
    use({"justinmk/vim-sneak", event = "VimEnter"})

    -- Clear highlight search automatically for you
    use({"romainl/vim-cool", event = "VimEnter"})

    -- Show current search term in different color
    use({"PeterRincker/vim-searchlight", event = "VimEnter"})

    -- Show match number for search
    use({"kevinhwang91/nvim-hlslens", event = 'VimEnter'})

    -- Stay after pressing * and search selected text
    use({"haya14busa/vim-asterisk", event = 'VimEnter'})

    -- File search, tag search and more
    if vim.g.is_win then
      use({"Yggdroot/LeaderF", cmd = "Leaderf"})
    else
      use({ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" })
    end

    -- Another similar plugin is command-t
    -- use 'wincent/command-t'

    -- Another grep tool (similar to Sublime Text Ctrl+Shift+F)
    -- use 'dyng/ctrlsf.vim'

    -- A grepping tool
    -- use {'mhinz/vim-grepper', cmd = {'Grepper', '<plug>(GrepperOperator)'}}

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    use({"lifepillar/vim-gruvbox8", event = 'VimEnter'})
    use({"ajmwagar/vim-deus", event = 'VimEnter'})
    use({"lifepillar/vim-solarized8", event = 'VimEnter'})
    use({"navarasu/onedark.nvim", event = 'VimEnter'})
    use({"sainnhe/edge", event = 'VimEnter'})
    use({"sainnhe/sonokai", event = 'VimEnter'})
    use({"sainnhe/gruvbox-material", event = 'VimEnter'})
    use({"shaunsingh/nord.nvim", event = 'VimEnter'})
    use({"NTBBloodbath/doom-one.nvim", event = 'VimEnter'})
    use({"sainnhe/everforest", event = 'VimEnter'})

    -- Show git change (change, delete, add) signs in vim sign column
    use({"mhinz/vim-signify", event = 'BufEnter'})
    -- Another similar plugin
    -- use 'airblade/vim-gitgutter'

    -- colorful status line and theme
    use({"vim-airline/vim-airline-themes", event = 'VimEnter', opt = true})
    use({"vim-airline/vim-airline", after = 'vim-airline-themes', opt = true})

    use({ "akinsho/bufferline.nvim", event = "VimEnter", config = [[require('config.bufferline')]] })

    -- fancy start screen
    use({ "mhinz/vim-startify", opt = true, setup = [[vim.cmd('packadd vim-startify')]]})
    use({ "lukas-reineke/indent-blankline.nvim", event = "VimEnter", config = [[require('config.indent-blankline')]] })

    -- Highlight URLs inside vim
    use({"itchyny/vim-highlighturl", event = "VimEnter"})

    -- notification plugin
    use({ "rcarriga/nvim-notify", event = "VimEnter", config = 'vim.notify = require("notify")' })

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    if vim.g.is_win or vim.g.is_mac then
      -- open URL in browser
      use({"tyru/open-browser.vim", event = "VimEnter"})
    end

    -- Only install these plugins if ctags are installed on the system
    if utils.executable("ctags") then
      -- plugin to manage your tags
      use({"ludovicchabant/vim-gutentags", event = "VimEnter"})
      -- show file tags in vim window
      use({"liuchengxu/vista.vim", event = "VimEnter"})
    end

    -- Snippet engine and snippet template
    use({"SirVer/ultisnips", event = 'InsertEnter'})
    use({ "honza/vim-snippets", after = 'ultisnips'})

    -- Automatic insertion and deletion of a pair of characters
    use({"Raimondi/delimitMate", event = "InsertEnter"})

    -- Comment plugin
    use({"tpope/vim-commentary", event = "VimEnter"})

    -- Multiple cursor plugin like Sublime Text?
    -- use 'mg979/vim-visual-multi'

    -- Autosave files on certain events
    use({"907th/vim-auto-save", event = "VimEnter"})

    -- Show undo history visually
    use({"simnalamburt/vim-mundo", event = "VimEnter"})

    -- Manage your yank history
    if vim.g.is_win or vim.g.is_mac then
      use({"svermeulen/vim-yoink", event = "VimEnter"})
    end

    -- Handy unix command inside Vim (Rename, Move etc.)
    use({"tpope/vim-eunuch", event = "VimEnter"})

    -- Repeat vim motions
    use({"tpope/vim-repeat", event = "VimEnter"})

    -- Show the content of register in preview window
    -- Plug 'junegunn/vim-peekaboo'
    use({ "jdhao/better-escape.vim", event = { "InsertEnter" } })

    if vim.g.is_mac then
      use({ "lyokha/vim-xkbswitch", event = { "InsertEnter" } })
    elseif vim.g.is_win then
      use({ "Neur1n/neuims", event = { "InsertEnter" } })
    end

    -- Syntax check and make
    -- use 'neomake/neomake'

    -- Auto format tools
    use({ "sbdchd/neoformat", cmd = { "Neoformat" } })
    -- use 'Chiel92/vim-autoformat'

    -- Git command inside vim
    use({ "tpope/vim-fugitive", event = "User InGitRepo" })

    -- Better git log display
    use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })

    use({ "kevinhwang91/nvim-bqf", event = "VimEnter", config = [[require('config.bqf')]] })

    -- Better git commit experience
    use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

    -- Another markdown plugin
    use({ "plasticboy/vim-markdown", ft = { "markdown" } })

    -- Faster footnote generation
    use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })

    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    use({ "godlygeek/tabular", cmd = { "Tabularize" } })

    -- Markdown JSON header highlight plugin
    use({ "elzr/vim-json", ft = { "json", "markdown" } })

    -- Markdown previewing (only for Mac and Windows)
    if vim.g.is_win or vim.g.is_mac then
      use({
        "iamcco/markdown-preview.nvim",
        run = function()
          fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
      })
    end

    use({'folke/zen-mode.nvim', event = 'VimEnter', config = [[require('config.zen-mode')]]})

    if vim.g.is_mac then
      use({ "rhysd/vim-grammarous", ft = { "markdown" } })
    end

    use({"chrisbra/unicode.vim", event = "VimEnter"})

    -- Additional powerful text object for vim, this plugin should be studied
    -- carefully to use its full power
    use({"wellle/targets.vim", event = "VimEnter"})

    -- Plugin to manipulate character pairs quickly
    -- use 'tpope/vim-surround'
    use({"machakann/vim-sandwich", event = "VimEnter"})

    -- Add indent object for vim (useful for languages like Python)
    use({"michaeljsmith/vim-indent-object", event = "VimEnter"})

    -- Only use these plugin on Windows and Mac and when LaTeX is installed
    if vim.g.is_win or vim.g.is_mac and utils.executable("latex") then
      use({ "lervag/vimtex", ft = { "tex" } })

      -- use {'matze/vim-tex-fold', ft = {'tex', }}
      -- use 'Konfekt/FastFold'
    end

    -- Since tmux is only available on Linux and Mac, we only enable these plugins
    -- for Linux and Mac
    if utils.executable("tmux") then
      -- .tmux.conf syntax highlighting and setting check
      use({ "tmux-plugins/vim-tmux", ft = { "tmux" } })
    end

    -- Modern matchit implementation
    use({"andymass/vim-matchup", event = "VimEnter"})

    -- Smoothie motions
    -- use 'psliwka/vim-smoothie'
    use({ "karb94/neoscroll.nvim", event = "VimEnter", config = [[require('config.neoscroll')]] })

    use({"tpope/vim-scriptease", event = "VimEnter"})

    -- Asynchronous command execution
    use({ "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } })
    -- Another asynchronous plugin
    -- Plug 'tpope/vim-dispatch'
    use({ "cespare/vim-toml", ft = { "toml" } })

    -- Edit text area in browser using nvim
    if vim.g.is_win or vim.g.is_mac then
      use({
        "glacambre/firenvim",
        run = function()
          fn["firenvim#install"](0)
        end,
      })
    end

    -- Debugger plugin
    if vim.g.is_win or vim.g.is_linux then
      use({ "sakhnik/nvim-gdb", run = { "bash install.sh" }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })
    end

    -- Session management plugin
    use({"tpope/vim-obsession", event = 'VimEnter'})

    -- Calculate statistics for visual selection
    use({"wgurecky/vimSum", event = "BufEnter"})

    if vim.g.is_linux then
      use({"ojroques/vim-oscyank", event = 'VimEnter'})
    end

    -- REPL for nvim
    use({ "hkupty/iron.nvim", event = 'BufEnter', config = [[require('config.iron')]] })

    -- Show register content
    use({"tversteeg/registers.nvim", event = 'BufEnter'})

    -- The missing auto-completion for cmdline!
    use("gelguy/wilder.nvim")
  end,
  config = {
    max_jobs = 16,
    git = {
      default_url_format = plug_url_format,
    },
  },
})
