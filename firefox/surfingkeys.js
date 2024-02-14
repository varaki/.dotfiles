/* Gruvbox dark theme */
settings.theme = `
.sk_theme {
    font-family: JetBrainsMono Nerd Font;
    font-size: 10pt;
    background: #282828;
    color: #ebdbb2;
}
.sk_theme tbody {
    color: #fabd2f;
}
.sk_theme input {
    color: #d9dce0;
}
.sk_theme .url {
    color: #d79921;
}
.sk_theme .annotation {
    color: #ebdbb2;
}
.sk_theme .omnibar_highlight {
    color: #ebdbb2;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #282828;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3c3836;
}
#sk_status, #sk_find {
    font-size: 10pt;
}`;

/* hints */
settings.hintAlign = "left";
api.Hints.setCharacters('asdfqwejkl');
api.Hints.style('font-family: FreeSans; font-size: 10px;');
settings.defaultSearchEngine = "d";
settings.modeAfterYank = "Normal";
settings.smoothScroll = false;

/* custom keybindings */

// Switch tabs
api.map('J', 'E');
api.unmap('E');
api.map('K', 'R');
api.unmap('R');

// Current tab Omnibar
api.map('o', 'go');
api.unmap('t');

// History Back/Forward
api.map('H', 'S');
api.map('L', 'D');
api.unmap('S');
api.unmap('D');

// Hints
api.map('F', 'af');
api.unmap('af');
api.map(';r', 'cf');
api.unmap('cf');
api.map(',f', 'i');
api.unmap('i');
api.map(',F', 'I');
api.unmap('I');

// Scroll
api.map('<Ctrl-f>', 'P'); // full page down
api.unmap('P');
api.map('<Ctrl-b>', 'U'); // full page up
api.unmap('U');
api.map('<Ctrl-d>', 'd'); // half page down
api.unmap('d');
api.map('<Ctrl-u>', 'e'); // half page up
api.unmap('e');

// Tabs
settings.focusAfterClosed = "left";
settings.tabsMRUOrder = false;
settings.tabsThreshold = 0;
api.mapkey('T', 'Choose a tab with omnibar', function() {
    api.Front.openOmnibar({type: "Tabs"});
});
api.map('d', 'x');
api.unmap('x');
api.map('u', 'X');
api.unmap('X');
api.map('gC', 'yt');
api.unmap('yt');
api.unmap('yT');

// Yank
api.map('yp', 'yy');
api.unmap('yy');
api.map('Pp', 'cc');
api.unmap('cc');
api.map(';y', 'ya');
api.unmap('ya');
