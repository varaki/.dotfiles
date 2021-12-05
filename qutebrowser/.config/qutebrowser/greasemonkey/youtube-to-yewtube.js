// ==UserScript==
// @name           youtube to yewtube redirect
// @namespace      mamg22's userscripts
// @match          http://www.youtube.com/*
// @match          https://www.youtube.com/*
// @match          http://youtube.com/*
// @match          https://youtube.com/*
// @match          http://youtu.be/*
// @match          https://youtu.be/*
// @run-at         document-start
// ==/UserScript==
location.href=location.href.replace("www.youtube.com","yewtu.be");
