-- NVim Ag Command
--
-- Copyright 2025 Nathan Jones
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

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
  local last_search = vim.fn.getreg('/')
  -- prepend latest search word as default suggestion
  if #last_search > 0 then
      words:add(last_search)
  end
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

local FileNode = {}
FileNode.__index = FileNode

function FileNode.new(parent, name)
  return setmetatable({
    parent = parent,
    name = name,
  }, FileNode)
end

function FileNode:path()
  if self.parent == nil then
    return self.name
  end
  return self.parent:path() .. '/' .. self.name
end

local function tbl_some(table, fn)
  for _, item in ipairs(table) do
    if (fn(item)) then return true end
  end
  return false
end

local function scan_dir_nodes(root, ignore_list)
  local nodes = {}
  local function scan(parent)
    local fs = vim.loop.fs_scandir(parent:path())
    if not fs then return end
    while true do
      local name, t = vim.loop.fs_scandir_next(fs)
      if not name then break end
      if tbl_some(ignore_list, function (regex) return name:find(regex) end) then
        goto continue
      end
      local child = FileNode.new(parent, name)
      if t == 'directory' then
        table.insert(nodes, child)
        scan(child)
      end
      ::continue::
    end
  end
  scan(FileNode.new(nil, root))
  return nodes
end

local function get_all_directories()
  local ignore_list = {
    '^node_modules$',
    '^%.',
  }
  return vim.tbl_map(
    function (node) return node.name end,
    scan_dir_nodes(vim.fn.getcwd(), ignore_list)
  )
end

local function substring_file_completion(arglead)
  local all_files = vim.fn.getcompletion('', 'file')
  local matches = {}
  for _, file in ipairs(all_files) do
    if file:find(arglead, 1, true) then
      table.insert(matches, file)
    end
  end
  return matches
end

local function ag_complete(arglead, cmdline, cursorpos)
  local parts = vim.split(cmdline:sub(1, cursorpos), '%s+')
  local argc = #parts - 1
  if parts[argc] == '--ignore' then
    return case_insensitive_matches(get_all_directories(), arglead):values()
  end
  if arglead:match('^-') then
    -- strip single leading dash so we can find similar suggestions
    -- eg: -count will suggest --max-count
    if not string.match(arglead, '^%-%-') and #arglead > 2 then
      arglead = string.gsub(arglead, '^%-', '')
    end
    return case_insensitive_matches(silver_searcher_opts, arglead):values()
  end
  if argc == 1 then
    return case_insensitive_matches(get_words_from_open_buffers(), arglead):values()
  end
  return substring_file_completion(arglead)
end

local MAX_QF_RESULTS = 1000

local function ag_execute_command(opts)
  local result = vim.fn.systemlist('ag --vimgrep --silent ' .. opts.args)
  if vim.v.shell_error ~= 0 then
    if #result == 0 then
      vim.notify('No Results', vim.log.levels.WARN)
    else
      vim.notify(table.concat(result, '\n'), vim.log.levels.ERROR)
    end
    return
  end
  if #result > MAX_QF_RESULTS then
    vim.notify('Truncated ag results to ' .. MAX_QF_RESULTS, vim.log.levels.WARN)
    result = vim.list_slice(result, 1, MAX_QF_RESULTS)
  end
  vim.fn.setqflist({}, ' ', {
    lines = result
  })
  vim.cmd('copen')
end

function M.setup()
  vim.api.nvim_create_user_command(
    'Ag',
    ag_execute_command,
    {
      nargs = '+',
      complete = ag_complete
    }
  )
end

return M
