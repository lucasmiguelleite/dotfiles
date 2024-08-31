-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Remaps --------------------------------------------------------------------------------------
-- Adding an empty line below, above and below with insert
lvim.keys.normal_mode["op"] = "o<Esc>k"
lvim.keys.normal_mode["oi"] = "O<Esc>j"
lvim.keys.normal_mode["oo"] = "A<CR>"

-- Create a tab
lvim.keys.normal_mode["te"] = ":tabe<CR>"

-- Navigate between buffers
lvim.keys.normal_mode["ty"] = ":bn<CR>"
lvim.keys.normal_mode["tr"] = ":bp<CR>"

-- Delete a buffer
lvim.keys.normal_mode["td"] = ":bd<CR>"

-- Create splits
lvim.keys.normal_mode["th"] = ":split<CR>"
lvim.keys.normal_mode["tv"] = ":vsplit<CR>"

-- Close split and quit file
lvim.keys.normal_mode["tt"] = ":q<CR>"

-- Call command shortcut
lvim.keys.normal_mode["tc"] = ":!"

-- Change <Esc> to jj
lvim.keys.insert_mode["jj"] = "<Esc>"
lvim.keys.insert_mode["JJ"] = "<Esc>"

-- Save the file
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<C-S>"] = ":w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<Esc>:w<CR>"
lvim.keys.insert_mode["<C-S>"] = "<Esc>:w<CR>"

-- Ctrl + Backspace
lvim.keys.insert_mode["<C-BS>"] = "<C-W>"

-- vim.opt.timeoutlen = 500
