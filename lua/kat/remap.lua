local nnoremap = require("kat.keymap").nnoremap

-- function Pad (width)
--     local handle = io.popen("tput cols")
--     local result = tonumber(handle:read("*a"))
--     handle:close()
--     if result > width then
--        local pad = math.floor((result - 120) / 2)
--        require'centerpad'.toggle{ leftpad = pad, rightpad = pad }
--     end
-- end
--
-- nnoremap("<leader>z", "<cmd>lua Pad(120)<CR>")

nnoremap("<leader>;", "A;<esc>")

-- Tabs
nnoremap("<leader>.", "<cmd>BufferNext<CR>") -- next buffer
nnoremap("<leader>,", "<cmd>BufferPrevious<CR>") -- prev buffer
nnoremap("<leader>>", "<cmd>BufferMoveNext<CR>") -- move buffer next
nnoremap("<leader><", "<cmd>BufferMovePrevious<CR>") -- move buffer prev
nnoremap("<leader>P", "<cmd>BufferPin<CR>") -- pin current buffer
nnoremap("<leader>cc", "<cmd>BufferClose<CR>") -- close current buffer
nnoremap("<leader>CC", "<cmd>BufferClose!<CR>") -- close current buffer
nnoremap("<leader>c>", "<cmd>BufferCloseBuffersRight<CR>") -- close all next buffers
nnoremap("<leader>c<", "<cmd>BufferCloseBuffersLeft<CR>") -- close all prev buffers
nnoremap("<leader>ca", "<cmd>BufferCloseAllButCurrentOrPinned<CR>") -- close all other buffers
nnoremap("<leader>p", "<cmd>BufferPick<CR>") -- buffer pick mode

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")

nnoremap("<leader>tt", "<cmd>NvimTreeToggle<cr>")
nnoremap("<leader>tf", "<cmd>NvimTreeFindFile<cr>")
nnoremap("<leader>tc", "<cmd>NvimTreeCollapse<cr>")
