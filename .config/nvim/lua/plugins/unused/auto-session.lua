return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- don't open it if session exists
    bypass_save_filetypes = { 'alpha', 'dashboard' },
    auto_restore = true,
    auto_save = true,
    auto_restore_last_session = true,
    lazy_support = true,
    close_unsupported_windows = true,
    auto_create = true,
    args_allow_files_auto_save = true



    -- log_level = 'debug',
  }
}
