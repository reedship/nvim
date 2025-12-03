vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
-- paste without overwriting the paste register, or something
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n","v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-Down>", "<cmd>cnext<CR><cmd>cc<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-Up>", "<cmd>cprev<CR><cmd>cc<CR>zz", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<C-Left>", "<cmd>lnext<CR><cmd>ll<CR>zz", { desc = "Next loclist item" })
vim.keymap.set("n", "<C-Right>", "<cmd>lprev<CR><cmd>ll<CR>zz", { desc = "Previous loclist item" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>vt", "<cmd>vs | term<CR>", { silent = true })
vim.keymap.set("n", "<C-Enter>", "i<Enter><Esc>k$");
vim.keymap.set("n", "<leader>lg", "<cmd>Neogit<CR>");

-- disable mouse in help buffers
vim.keymap.set("n", "<C-LeftMouse>", "<Nop>")
vim.keymap.set('n', '<C-]>', ':tag <C-r><C-w><CR>')


-- visually mode on wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
