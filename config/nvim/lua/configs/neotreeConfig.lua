-- If you want icons for diagnostic errors, you'll need to define them somewhere.
-- In Neovim v0.10+, you can configure them in vim.diagnostic.config(), like:
--
-- vim.diagnostic.config({
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = '',
--       [vim.diagnostic.severity.WARN] = '',
--       [vim.diagnostic.severity.INFO] = '',
--       [vim.diagnostic.severity.HINT] = '󰌵',
--     },
--   }
-- })
--
-- In older versions, you can define the signs manually:
-- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>")
require("neo-tree").setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "NC",    -- or "" to use 'winborder' on Neovim v0.11+
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    open_files_using_relative_paths = false,
    sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
    sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
    },
    default_component_configs = {
        container = {
            enable_character_fade = true,
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
                if node.type == "file" or node.type == "terminal" then
                    local success, web_devicons = pcall(require, "nvim-web-devicons")
                    local name = node.type == "terminal" and "terminal" or node.name
                    if success then
                        local devicon, hl = web_devicons.get_icon(name)
                        icon.text = devicon or icon.text
                        icon.highlight = hl or icon.highlight
                    end
                end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
        },
        modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted = "✖", -- this can only be used in the git_status source
                renamed = "󰁕", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored = "",
                unstaged = "󰄱",
                staged = "",
                conflict = "",
            },
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
            enabled = true,
            width = 12,          -- width of the column
            required_width = 64, -- min width of window required to show this column
        },
        type = {
            enabled = true,
            width = 10,           -- width of the column
            required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
            enabled = true,
            width = 20,          -- width of the column
            required_width = 88, -- min width of window required to show this column
        },
        created = {
            enabled = true,
            width = 20,           -- width of the column
            required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {
            enabled = false,
        },
        show_path = "relative"
    },
    commands = {},
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = {
                "toggle_preview",
                config = {
                    use_float = true,
                    use_snacks_image = true,
                    use_image_nvim = true,
                },
            },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = {
                "add",
                config = {
                    show_path = "relative",
                },
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        },
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = true,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {},
            always_show_by_pattern = {},
            never_show = {},
            never_show_by_pattern = {},
        },
        follow_current_file = {
            enabled = false,
            leave_dirs_open = false,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = false,
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["#"] = "fuzzy_sorter",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
                ["o"] = {
                    "show_help",
                    nowait = false,
                    config = { title = "Order by", prefix_key = "o" },
                },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["og"] = { "order_by_git_status", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
                ["b"] = "rename_basename",
                ["i"] = "show_file_details",
            },
            fuzzy_finder_mappings = {
                ["<down>"] = "move_cursor_down",
                ["<C-n>"] = "move_cursor_down",
                ["<up>"] = "move_cursor_up",
                ["<C-p>"] = "move_cursor_up",
                ["<esc>"] = "close",
                ["<S-CR>"] = "close_keep_filter",
                ["<C-CR>"] = "close_clear_filter",
                ["<C-w>"] = { "<C-S-w>", raw = true },
                {
                    n = {
                        ["j"] = "move_cursor_down",
                        ["k"] = "move_cursor_up",
                        ["<S-CR>"] = "close_keep_filter",
                        ["<C-CR>"] = "close_clear_filter",
                        ["<esc>"] = "close",
                    }
                }
            },
        },
        commands = {},
    },
    buffers = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
            mappings = {
                ["d"] = "buffer_delete",
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["o"] = {
                    "show_help",
                    nowait = false,
                    config = { title = "Order by", prefix_key = "o" },
                },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["gU"] = "git_undo_last_commit",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
                ["o"] = {
                    "show_help",
                    nowait = false,
                    config = { title = "Order by", prefix_key = "o" },
                },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
    document_symbols = {
        follow_cursor = false,
        client_filters = "first",
        renderers = {
          root = {
            {"indent"},
            {"icon", default="C" },
            {"name", zindex = 10},
          },
          symbol = {
            {"indent", with_expanders = true},
            {"kind_icon", default="?" },
            {"container",
            content = {
              {"name", zindex = 10},
              {"kind_name", zindex = 20, align = "right"},
              }
            }
          },
        },
        window = {
          position = "right",
          mappings = {
            ["<cr>"] = "jump_to_symbol",
            ["o"] = "jump_to_symbol",
            ["A"] = "noop",
            ["d"] = "noop",
            ["y"] = "noop",
            ["x"] = "noop",
            ["p"] = "noop",
            ["c"] = "noop",
            ["m"] = "noop",
            ["a"] = "noop",
            ["/"] = "filter",
            ["f"] = "filter_on_submit",
          },
        },
        custom_kinds = {},
        kinds = {
          Unknown = { icon = "?", hl = "" },
          Root = { icon = "", hl = "NeoTreeRootName" },
          File = { icon = "󰈙", hl = "Tag" },
          Module = { icon = "", hl = "Exception" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Method = { icon = "", hl = "Function" },
          Property = { icon = "󰆧", hl = "@property" },
          Field = { icon = "", hl = "@field" },
          Constructor = { icon = "", hl = "@constructor" },
          Enum = { icon = "󰒻", hl = "@number" },
          Interface = { icon = "", hl = "Type" },
          Function = { icon = "󰊕", hl = "Function" },
          Variable = { icon = "", hl = "@variable" },
          Constant = { icon = "", hl = "Constant" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Boolean = { icon = "", hl = "Boolean" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Null = { icon = "", hl = "Constant" },
          EnumMember = { icon = "", hl = "Number" },
          Struct = { icon = "󰌗", hl = "Type" },
          Event = { icon = "", hl = "Constant" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
        }
      },
      example = {
        renderers = {
          custom = {
            {"indent"},
            {"icon", default="C" },
            {"custom"},
            {"name"}
          }
        },
        window = {
          mappings = {
            ["<cr>"] = "toggle_node",
            ["<C-e>"] = "example_command",
            ["d"] = "show_debug_info",
          },
        },
      }
})

-- Auto-open document_symbols pane on the right for code filetypes
local ft_list = { "python", "java", "cs", "c", "cpp", "javascript",
                  "typescript", "sh", "lua", "ps1" }
local group = vim.api.nvim_create_augroup("NeotreeDocumentSymbols", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    callback = function()
        local ft = vim.bo.filetype
        if vim.tbl_contains(ft_list, ft) and not vim.b.neotree_symbols_shown then
            local cur_win = vim.api.nvim_get_current_win()
            require("neo-tree.command").execute({
                source   = "document_symbols",
                position = "right",
                toggle   = false,
                focus    = false,
            })
            vim.schedule(function()
                if type(cur_win) == "number" and vim.api.nvim_win_is_valid(cur_win) then
                    vim.api.nvim_set_current_win(cur_win)
                end
            end)
            vim.b.neotree_symbols_shown = true
        end
    end,
})
