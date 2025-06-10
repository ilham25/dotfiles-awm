-- This is used later as the default terminal and editor to run.
local apps = {}
apps.terminal   = 'kitty'
apps.editor     = os.getenv('EDITOR') or 'vi'
apps.editor_cmd = apps.terminal .. ' -e ' .. apps.editor
apps.file_manager = 'thunar'

-- Set the terminal for the menubar.
require('menubar').utils.terminal = apps.terminal

return apps
