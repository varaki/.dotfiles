// ==UserScript==
// @name Open-Source Alternative Redirector
// @namespace -
// @version 9.0.0
// @description Redirects you from proprietary web-services to ethical alternatives(front-end).
// @author NotYou
// @include *youtube.com/*
// @include *google.com/*
// @include *yahoo.com/*
// @include *bing.com/*
// @include *reddit.com/*
// @include *twitter.com/*
// @include *instagram.com/*
// @include *wikipedia.org/*
// @include *medium.com/*
// @include *i.imgur.com/*
// @include *i.stack.imgur.com/*
// @include *odysee.com/*
// @include *tiktok.com/*
// @run-at document-start
// @license GPL-3.0-or-later
// @icon https://icons.iconarchive.com/icons/itweek/knob-toolbar/32/Knob-Shuffle-Off-icon.png
// @grant none
// ==/UserScript==

var url = new URL(location.href),

// INSTANCES //
invidious = 'yewtu.be',
//invidious = 'piped.kavin.rocks'
searx = 'search.mdosch.de',
// libreddit = 'reddit.invak.id',
libreddit = 'libreddit.eu.org',
nitter = 'nitter.snopyta.org',
wikiless = 'wikiless.org',
lingva = 'lingva.ml',
scribe = 'scribe.rip',
rimgo = 'rimgo.pussthecat.org',
librarian = 'librarian.pussthecat.org',
proxitok = 'proxitok.herokuapp.com'

// YouTube | Invidious //
if(location.host.indexOf('youtube.com') != -1){
    location.replace('https://' + invidious + location.pathname + location.search)
}

// Yahoo | SearX //
if(location.host.indexOf('yahoo.com') != -1){
    let search = location.search.replace('?p', '?q')
    location.replace('https://' + searx + location.pathname + search)
}

// Bing | SearX //
if(location.host.indexOf('bing.com') != -1){
    location.replace('https://' + searx + location.pathname + location.search)
}

// Reddit | Libreddit //
if(location.host.indexOf('reddit.com') != -1){
    location.replace('https://' + libreddit + location.pathname + location.search)
}

// Twitter | Nitter //
if(location.host.indexOf('twitter.com') != -1){
    location.replace('https://' + nitter + location.pathname + location.search)
}

// Wikipedia | Wikiless //
if(location.host.indexOf('wikipedia.org') != -1){
    location.replace('https://' + wikiless + location.pathname + '?lang=' + url.hostname.split('.')[0])
}

// Medium | Scribe //
if(location.host.indexOf('medium.com') != -1){
    location.replace('https://' + scribe + location.pathname + location.search)
}

// i.Imgur | Rimgo //
if(location.host.indexOf('i.imgur.com') != -1){
    location.replace('https://' + rimgo + location.pathname + location.search)
}

// Odysee | Librarinan //
if(location.host.indexOf('odysee.com') != -1){
    location.replace('https://' + librarian + location.pathname + location.search)
}

// TikTok | ProxiTok //
if(location.host.indexOf('tiktok.com') != -1||location.host.indexOf('www.tiktok.com') != -1){
    location.replace('https://' + proxitok + location.pathname + location.search)
}
