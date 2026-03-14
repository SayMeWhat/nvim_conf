local function has_supported_terminal()
  if #vim.api.nvim_list_uis() == 0 then
    return false
  end

  return vim.env.KITTY_WINDOW_ID ~= nil
    or vim.env.TERM == 'xterm-kitty'
    or vim.env.WEZTERM_EXECUTABLE ~= nil
    or vim.env.TERM_PROGRAM == 'WezTerm'
    or vim.env.GHOSTTY_RESOURCES_DIR ~= nil
    or vim.env.TERM_PROGRAM == 'ghostty'
end

return {
  '3rd/image.nvim',
  cond = has_supported_terminal,
  build = false,
  opts = {},
}
