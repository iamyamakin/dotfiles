local function snippet_replace(snippet, fn)
    return snippet:gsub('%$%b{}', function(m)
        local n, name = m:match('^%${(%d+):(.+)}$')

        return n and fn({ n = n, text = name }) or m
    end) or snippet
end

local function snippet_preview(snippet)
    local ok, parsed = pcall(function()
        return vim.lsp._snippet_grammar.parse(snippet)
    end)

    return ok and tostring(parsed) or snippet_replace(snippet, function(placeholder)
        return snippet_preview(placeholder.text)
    end):gsub('%$0', '')
end

local function snippet_fix(snippet)
    local texts = {}

    return snippet_replace(snippet, function(placeholder)
        texts[placeholder.n] = texts[placeholder.n] or snippet_preview(placeholder.text)

        return '${' .. placeholder.n .. ':' .. texts[placeholder.n] .. '}'
    end)
end

local function expand(snippet)
    local session = vim.snippet.active() and vim.snippet._session or nil
    local ok, err = pcall(vim.snippet.expand, snippet)

    if not ok then
        local fixed = snippet_fix(snippet)

        ok = pcall(vim.snippet.expand, fixed)

        local msg = ok and 'Failed to parse snippet,\nbut was able to fix it automatically.'
            or ('Failed to parse snippet.\n' .. err)

        GlobalUtils[ok and 'warn' or 'error'](
            ([[%s ```%s %s ```]]):format(msg, vim.bo.filetype, snippet),
            { title = 'vim.snippet' }
        )
    end
    if session then
        vim.snippet._session = session
    end
end

return {
    expand = expand,
}
