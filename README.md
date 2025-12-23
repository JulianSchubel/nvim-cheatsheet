# Nvim-Cheatsheet 

A lightweight Neovim plugin that displays a cheatsheet of nvim commands
inside a floating, searchable window.

No setup. No external files. Just install and press a key.

![](assets/nvim-cheatsheet.png)

---

## Features

- Markdown cheatsheet
- Floating window UI
- Searchable (`/`, `?`)
- Configurable keybinding
- Lazy.nvim compatible
- Zero dependencies

---

## Installation (Lazy.nvim)

```lua
{
    "JulianSchubel/nvim-cheatsheet",
    cmd = { "Cheatsheet" },
    keys = { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Open Neovim cheatsheet" },
    config = function()
        require("cheatsheet").setup({
            leader = "<leader>?",
            width_ratio = 0.8,
            height_ratio = 0.8,
            border = "rounded",
        })
    end,
}
```

## Requirements  

Neovim ≥ 0.9
