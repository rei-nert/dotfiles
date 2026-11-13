-- load standard vis module, providing parts of the Lua API
require("vis")
local plug_path = (os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/vis/plugins/vis-plug"
if not pcall(require, "plugins/vis-plug") then
	os.execute('git clone --quiet https://github.com/erf/vis-plug "' .. plug_path .. '"')
end
local plug = require("plugins/vis-plug")
local plugins = {
	{ "pshevtsov/base16-vis", file = "themes/base16-gruvbox-dark-hard", theme = true },
	{ "codeberg.org/luxanna/vis-autoclose" },
	{ "milhnl/vis-backspace" },
	{ "hucal/vis-backup", file = "backup" },
	{ "thimc/vis-colorizer" },
	{ "Nomarian/vis-commentary" },
	{ "kupospelov/vis-ctags" },
	-- { 'roguh/vis-copypasta' },
	{ "codeberg.org/wf/vis-eval" },
	{ "maciejjan/vis-tmux-repl", file = "tmux-repl" },
	{ "jocap/vis-filetype-settings", file = "vis-filetype-settings" },
	{ "codeberg.org/muhq/vis-lspc" },
	{ "peaceant/vis-fzf-mru", file = "fzf-mru" },
	{ "codefloe.com/mcepl/vis-fzf-open" },
	{ "gitlab.com/timoha/vis-go", file = "vis-go" },
	{ "repo.or.cz/vis-goto-file.git" },
	{ "ingolemo/vis-smart-backspace" },
	{ "erf/vis-highlight" },
	{ "Nomarian/vis-remove-trailing-whitespace" },
	{ "rnpnr/vis-lint" },
	{ "codeberg.org/muhq/vis-spellcheck" },
	{ "repo.or.cz/vis-surround.git" },
	{ "erf/vis-title" },
	{ "repo.or.cz/vis-toggler.git" },
	{ "e-zk/vis-shebang" },
	{ "git.disroot.org/oink/vis-smart-numbers" },
	{ "codefloe.com/mcepl/vis-snippets" },
	{ "codeberg.org/runitclean/vis-treesitter" },
}
-- require and optionally install plugins on init
-- plug.init(plugins, true)
plug.init(plugins)
-- access plugins via alias
-- plug.plugins.cursors.maxsize = 2000

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	-- vis:command('set number')
end)
