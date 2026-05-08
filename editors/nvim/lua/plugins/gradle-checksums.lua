local PRIVATE_FILE = vim.fn.expand('~/.dotfiles/modules/private/nvim/gradle-checksums.lua')

local function read_checksums()
  if vim.fn.filereadable(PRIVATE_FILE) == 0 then return {} end
  local ok, entries = pcall(dofile, PRIVATE_FILE)
  if not ok or type(entries) ~= 'table' then return {} end
  return entries
end

local function write_checksums(entries)
  local lines = { 'return {' }
  for _, e in ipairs(entries) do
    table.insert(lines, string.format('  { sha256 = %q, path = %q },', e.sha256, e.path))
  end
  table.insert(lines, '}')
  local ok, err = pcall(function()
    local fh = assert(io.open(PRIVATE_FILE, 'w'))
    fh:write(table.concat(lines, '\n') .. '\n')
    fh:close()
  end)
  if not ok then
    vim.notify('[gradle-checksums] write failed: ' .. err, vim.log.levels.ERROR)
    return false
  end
  return true
end

local function find_jar_upward(start_dir)
  local dir, prev = start_dir, nil
  while dir ~= prev do
    local candidate = dir .. '/gradle/wrapper/gradle-wrapper.jar'
    if vim.fn.filereadable(candidate) == 1 then return candidate end
    prev = dir
    dir = vim.fn.fnamemodify(dir, ':h')
  end
end

local function compute_sha256(path)
  local out = vim.fn.system({ 'shasum', '-a', '256', path })
  if vim.v.shell_error ~= 0 then return nil end
  return vim.split(out, ' ')[1]
end

local function reload_jdtls()
  local merged = {}
  for _, e in ipairs(read_checksums()) do
    table.insert(merged, { sha256 = e.sha256, allowed = true })
  end
  local cfg = vim.deepcopy(vim.lsp.config.jdtls)
  cfg.settings.java.imports.gradle.wrapper.checksums = merged
  vim.lsp.config.jdtls = cfg
  vim.lsp.enable('jdtls', false)
  vim.lsp.enable('jdtls', true)
end

vim.api.nvim_create_user_command('AddGradleChecksum', function()
  local jar = find_jar_upward(vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h'))
  if not jar then
    vim.notify('[gradle-checksums] No gradle-wrapper.jar found above current buffer', vim.log.levels.WARN)
    return
  end

  local sha = compute_sha256(jar)
  if not sha then
    vim.notify('[gradle-checksums] shasum failed for ' .. jar, vim.log.levels.ERROR)
    return
  end

  local entries = read_checksums()
  for _, e in ipairs(entries) do
    if e.sha256 == sha then
      vim.notify('[gradle-checksums] Already trusted: ' .. sha:sub(1, 12) .. '... (' .. jar .. ')', vim.log.levels.INFO)
      return
    end
  end

  local dir = vim.fn.fnamemodify(PRIVATE_FILE, ':h')
  if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, 'p') end

  table.insert(entries, { sha256 = sha, path = jar })
  if not write_checksums(entries) then return end

  reload_jdtls()
  vim.notify('[gradle-checksums] Added ' .. sha:sub(1, 12) .. '... for\n' .. jar .. '\njdtls restarted.', vim.log.levels.INFO)
end, { desc = 'Trust current project gradle-wrapper.jar and restart jdtls' })

vim.api.nvim_create_user_command('CleanGradleChecksums', function()
  local entries = read_checksums()
  if #entries == 0 then
    vim.notify('[gradle-checksums] No entries found.', vim.log.levels.INFO)
    return
  end

  local kept, removed = {}, {}
  for _, e in ipairs(entries) do
    local reason
    if vim.fn.filereadable(e.path) == 0 then
      reason = 'file not found'
    elseif compute_sha256(e.path) ~= e.sha256 then
      reason = 'sha256 changed (Gradle upgraded)'
    end
    if reason then
      table.insert(removed, '  ' .. e.sha256:sub(1, 12) .. '... ' .. e.path .. ' — ' .. reason)
    else
      table.insert(kept, e)
    end
  end

  if #removed == 0 then
    vim.notify('[gradle-checksums] All ' .. #kept .. ' entries are still valid.', vim.log.levels.INFO)
    return
  end

  write_checksums(kept)
  reload_jdtls()
  vim.notify(
    '[gradle-checksums] Removed ' .. #removed .. ' stale entries:\n' .. table.concat(removed, '\n') ..
    '\nKept ' .. #kept .. '. jdtls restarted.',
    vim.log.levels.INFO
  )
end, { desc = 'Remove stale gradle-wrapper.jar checksums (deleted or upgraded jars)' })

return {}
