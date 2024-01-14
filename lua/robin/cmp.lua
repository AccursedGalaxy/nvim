local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then return end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then return end

require("luasnip/loaders/from_vscode").lazy_load()
vim.opt.completeopt = "menu,menuone,noselect"
local kind_icons = {
  Text = "",
  Method = "ƒ",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "פּ",
  Interface = "ﰮ",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "﬌",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
})
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})
cmp.setup({
  window = {
    documentation = cmp.config.window.bordered()
  },
})
