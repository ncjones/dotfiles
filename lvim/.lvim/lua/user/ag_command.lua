local M = {}

local function TruncatedBuffer(limit)
  return function(bfr_handle)
    local buffer = {}
    function buffer:name() return vim.api.nvim_buf_get_name(bfr_handle) end
    function buffer:is_loaded() return vim.api.nvim_buf_is_loaded(bfr_handle) end
    function buffer:line_count() return vim.api.nvim_buf_line_count(bfr_handle) end
    function buffer:lines() return vim.api.nvim_buf_get_lines(bfr_handle, 0, limit, false) end
    function buffer:words()
      local words = {}
      for _, line in ipairs(self:lines()) do
        for word in line:gmatch('%w+%-?%w+') do
          table.insert(words, word)
        end
      end
      return words
    end
    return buffer
  end
end

local OrderedSet = {}
OrderedSet.__index = OrderedSet

function OrderedSet.new(list)
  local self = setmetatable({ _order = {} }, OrderedSet)
  for _, v in ipairs(list or {}) do
    if not self[v] then
      self:add(v)
    end
  end
  return self
end

function OrderedSet:add(v)
  self[v] = true
  table.insert(self._order, v)
end

function OrderedSet:values()
  return self._order
end

local function get_words_from_open_buffers()
  local min_length = 3
  local max_lines = 10000
  local words = OrderedSet.new()
  local buffers = vim.tbl_map(TruncatedBuffer(max_lines), vim.api.nvim_list_bufs())
  local open_buffers = vim.tbl_filter(function(b) return b:is_loaded() end, buffers)
  local buffer_words = vim.tbl_flatten(vim.tbl_map(function (b) return b:words() end, open_buffers))
  for _, word in ipairs(buffer_words) do
    if #word >= min_length then
      words:add(word)
    end
  end
  return words:values()
end

local silver_searcher_opts = {
  '-a', '--all-types',
  '--depth',
  '-f', '--follow', '--nofollow',
  '-F', '--fixed-strings',
  '-G', '--file-search-regex',
  '--hidden',
  '--ignore',
  '-m', '--max-count',
  '-n', '--norecurse',
  '-Q', '--literal',
  '-s', '--case-sensitive',
  '-t', '--all-text',
  '-u', '--unrestricted',
  '-U', '--skip-vcs-ignores',
  '-v', '--invert-match',
}

local function case_insensitive_matches(words, lead)
  -- Return "starts-with" matches then "contains" matches.
  return OrderedSet.new(vim.list_extend(
    vim.tbl_filter(function (word)
      return word:lower():match('^' .. vim.pesc(lead:lower()))
    end, words),
    vim.tbl_filter(function (word)
      return word:lower():match('.' .. vim.pesc(lead:lower()))
    end, words))
  )
end

local function ag_complete(arglead, cmdline, cursorpos)
  local parts = vim.split(cmdline:sub(1, cursorpos), '%s+')
  local argc = #parts - 1
  if arglead:match('^-') then
    return case_insensitive_matches(silver_searcher_opts, arglead):values()
  end
  if argc == 1 then
    return case_insensitive_matches(get_words_from_open_buffers(), arglead):values()
  end
  return vim.fn.getcompletion(arglead, 'file')
end

function M.setup()
  vim.api.nvim_create_user_command(
    'Ag',
    function(opts)
      local result = vim.fn.systemlist('ag --vimgrep ' .. opts.args)
      if vim.v.shell_error ~= 0 then
        if #result == 0 then
          vim.notify('No Results', vim.log.levels.WARN)
        else
          vim.notify(table.concat(result, '\n'), vim.log.levels.ERROR)
        end
      else
        vim.fn.setqflist({}, ' ', {
          lines = result
        })
        vim.cmd('copen')
      end
    end,
    {
      nargs = '+',
      complete = ag_complete
    }
  )
end

return M
