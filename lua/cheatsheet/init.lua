--[[
Mental model:
    1. create 
    2. configure
    3. write
    4. lock
    5. display
    6. auto-destroy
--]]

-- create a module table
local Module = {};

-- default configuration
local defaults = {
    width_ratio = 0.75,
    height_ratio = 0.75,
    border = "rounded",
    leader = "<leader>?",
    transparency = 25,
}

-- get cheatsheet content
local function read_markdown_file()
    local paths = vim.api.nvim_get_runtime_file("cheatsheet.md", false);
    if #paths == 0 then
        return { "Error: cheatsheet.md not found" }
    end

    return vim.fn.readfile(paths[1])
end

function Module.setup(opts)
    if type(opts) ~= "table" then
        opts = {}
    end

    Module.opts = vim.tbl_deep_extend("force", defaults, opts or {});

    -- assign keymap to the open function
    vim.keymap.set(
        -- normal mode
        "n",
        -- key sequence
        Module.opts.leader,
        -- function on sequence entry
        function() Module.open() end,
        -- description
        { desc = "Open Neovim cheatsheet" }
    );

    -- Set floating window background to none
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

    -- Create the user command
    vim.api.nvim_create_user_command(
        "Cheatsheet",
        function() Module.open() end,
        { desc = "Open Neovim cheatsheet" }
    );
end


function Module.open()
    -- created a unlisted scratch buffer
    local buf = vim.api.nvim_create_buf(false, true);

    -- Enable markdown rendering
    vim.bo[buf].filetype = "markdown";
    -- Ensure Treesitter highlighting works in scratch buffers
    if vim.treesitter and vim.treesitter.start then
        pcall(vim.treesitter.start, buf, "markdown")
    end
    -- Destroy and free memory when window is hidden (no longer shown in window
    vim.bo[buf].bufhidden = "wipe";
    -- Allow content to be written into the buffer
    vim.bo[buf].modifiable = true;

    local lines = read_markdown_file();
    -- Clear and insert content into the buffer
    vim.api.nvim_buf_set_lines(
        -- target buffer
        buf,
        -- start line (inclusive)
        0,
        -- end line index (exclusive - end of buffer),
        -1,
        -- do not enforce strict index bounds
        false,
        -- lines to insert
        lines
    );

    -- name the buffer
    vim.api.nvim_buf_set_name(buf, "cheatsheet.md");

    -- Prevent user edits to the buffer
    -- vim.bo[buf].modifiable = false;

    -- Floating window width as percentage of editor width
    local width = math.floor(vim.o.columns * Module.opts.width_ratio);
    -- Floating window height as percentage of editor height
    local height = math.floor(vim.o.lines * Module.opts.height_ratio);

    -- Center the window horizontally
    local row = math.floor((vim.o.lines - height) / 2);
    local col = math.floor((vim.o.columns - width) / 2);

    -- Create the window
    local win = vim.api.nvim_open_win(
        -- buffer to be displayed in the window
        buf,
        -- focus on the window immediately
        true,
        {
            -- set row col relative to the entire Neovim UI
            -- "editor"	Entire Neovim UI
            -- "win"	Current window
            -- "cursor"	Cursor position
            -- "mouse"	Mouse position
            relative = "editor",
            -- vertical offset in screen rows (from top edge)
            row = row,
            -- horizontal offset in screen columns (from left edge)
            col = col,
            -- width of the floating window in columns
            width = width,
            -- height of the floating window in rows
            height = height,
            --[[Remove following elements from the window:
                -- Statusline
                -- Sign column
                -- Line numbers
                -- Fold column
            ]]
            style = "minimal",
            -- Add a border around the floating window
            border = Module.opts.border,
        }
    );

    -- configure the floating window with markdown friendly window options
    -- soft linebreaks (no line breaks inserted into the buffer)
    vim.wo[win].wrap = true;
    vim.wo[win].cursorline = true;
    -- Wrap only at word boundaries 
    vim.wo[win].linebreak = true
    --[[Contral how concealed syntax elements are displayed
        -- 0	No conceal (show everything)
        -- 1	Conceal some syntax
        -- 2	Conceal most syntax (recommended)
        -- 3	Conceal everything possible
    ]]
    vim.wo[win].conceallevel = 3
    --[[ Control when coneal is active depending on mode
        -- "ncsvi" = conceal in Normal and Command mode (want raw markdown while
        -- editing)
        -- n	Normal
        -- i	Insert
        -- v	Visual
        -- c	Command
        -- s	Select
    ]]
    vim.wo[win].concealcursor = "nc"

    -- Set window transparency
    vim.wo[win].winblend = Module.opts.transparency;

    -- buffer local close mappings
    for _, key in ipairs({ "q", "<Esc>" }) do
        vim.keymap.set(
            "n",
            key,
            function() vim.api.nvim_win_close(win, true); end,
            {
                buffer = buf, silent = true
            }
        )
    end
end

return Module
