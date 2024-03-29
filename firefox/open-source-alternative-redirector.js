// ==UserScript==
// @name Open-Source Alternative Redirector
// @namespace -
// @version 11.2.0
// @description Redirects you from proprietary web-services to ethical alternatives(front-end).
// @author varaki
// @include *youtube.com/*
// @include *google.com/*
// @include *google.*
// @include *yahoo.com/*
// @include *bing.com/*
// @include *reddit.com/*
// @include *twitter.com/*
// @include *instagram.com/*
// @include *wikipedia.org/*
// @include *medium.com/*
// @include *towardsdatascience.com/*
// @include *i.imgur.com/*
// @include *i.stack.imgur.com/*
// @include *odysee.com/*
// @include *tiktok.com/*
// @include *quora.com/*
// @run-at document-start
// @compatible Firefox Version 48
// @compatible Chrome Version 49
// @compatible Edge Version 14
// @compatible Opera Version 36
// @compatible Safari Version 10.1
// @license GPL-3.0-or-later
// @icon data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAHkklEQVRYw8WXW2xUxxnHf3Nuu2e9CxhjsGPHmARzMddwSUmghBKSpkpJSpU0rdrmoVVbuVIESl4iRaJNpKh9IUpfitoHXhKJKqhBSkVFgDYkiLpJKJcaMMTY2MaXZe31ei/e3XOb6YOXxSwmgvQh83IumnPmN//v+2b+I5RSfJ3N4GtuBsCWH/3qbvs/AjwDrADqABsoAHGgA/gAaL+bHx3f/6e7VsACXgXaFs5vrFve0kzt7Goidhhd0/F8n4lCgZFk6ukLV3pf7bk2FAf2Ar8H3P83BC8bur5n05oVPLpuJXYohFIKpUChSveKWTOiNMydw6olLeSLxbr2M+df/7yj83U/kK8Ab31VgLcfbGrYueOJzcSqqlBKkclNkMlkKTgOnufh+wEAuqETMi1mxKqwbZtN61axcslCPvzk0z29Q/EmYNe9Avxxw+plbU9sXA8KEqNJ4iOjeJ6HlBKpFFIqlJKlq0IqiRxU6JpO/bw51FTPYvvjG/nk83M7z126YgG/vluAt7+xsrVt26PryU7k6R8Youi4SCVRUpUGl5ODlq5B+VmhlMPlnl4s0+SB+fezcc0KgkC2ne/qcadTohLg5eaG+p1bNqwhkRyjf2CIQN6cZSAlqqTAbQCypIJSyEBSLLqc6ejkweYmHl61lOR4eufwSLK/MieEUupGGVqGrjm/eOFZXNelp3+wPIhUqjywlBWyy1sVkUqRGU8RtqsQmoZUksUPNFMViXDw6CcEUoYAd7oyfG3t8iUEgaTraj+O65RmpxAK0ARKTpF7CpSSCj/wJ2GUZGZdE9f7e4jGokipOH/5CquXLWbRgvvp7O57DfhNZQh0TdN2r17awqXuXoquy8C1gXJcpfQRwMzq2RhWCBQlEEl+YoLMeIog8AGBUorVLSuZ29zCZ4ffJ1Y9GykVZy9+wdqVrVzq6d+tlHoDCKYCPPXA/fcxmsqQyeWRSrLxuZ+XpfE9l7H4IF2nTiKKDuFwBKkU2cw4ZjjC6q3bmTlnHrphgFIYVhjDNFn40AYGujpRKDK5PMOJJPW1NQwlRp8CDk0F2Fo/r5bu/oFSqSk0/WZ0LN2grrmF2sZm2g+9R9F1yU/kmFlbz8NPfg8hxLS1vGDZGq5evlAO1aXuXpoa7mMoMbq1EmCtZRjki0651K51nkUBSinMUJia++YTsiM88vQPOPbePuxYdXnwfC5DYqAfz3NRSjGnroHq2nmc+vgIxaKLAlAKx/VvsK2tzIGGvOfh+D6u6+J6Hslzp/D9AC/wUUphhSNs+vaz9Hd1IjWDTdtfQAhBfKCPTz86jOsUyzNftWEzg33dDA/2T6k3EJpG3nUBGioBrL6hEZJjKWQQMJ1HKObzHDnwDlXRKE8+/yKappEYusbJD/8GAjRNL/ft6jhNIZ+/5Z0QAk3XyTv+jQ3uFgDXdX10w5zMZClvA/CcAnbY5onnfophWowMD3Li0F/xPRfNsCaro9RM0yKdT2DHZt0E0DR0w8DzAqbukjcABpVgoW5ak3GXAeMj8fLHKgiorW9k2/d/jGmFyKSSnGk/zqbv7CA6YxZH33+X1OgwAgFC0PrQeppblvKfkx9hx2YghEBoOrppoSbzdbAS4KyU8rEbswh8jy3ffa4MELarmNvQhBCCXHqc9n8exjBMaubVY5gWz7zYxtj1IXzfBxQzqmuIRGcwloiTSMRLszcxrBDSdwHOVgIc9Vxnpx2JwqQGzG9pvS0MuUyaz04cw3UdXNfh38ePsG7TVsJ2hDn1jbf1X7N5G0cO7kfTdQzLwjBNCvkswNFKgMMT2SzR2fPQQhooyKZT3MhF33MZiQ/R330Z13HKyZUeS3Ly2CEamx+kumZueSGKRGPYVVE6z55C101008QK2QihMZHNAhyuBAiUUm/k0mO7Z9XWgRC0Hz9K4Hu3JaTQtFuenWKR7ksXgAvld62r1yE0naGBPnTLwgrbmFaI9Mh1pi7DlZvRmxPjY7tnza0nZEcQQuAVC5MQ92jdE8MDZFIpTNPCDNtYYRspJbnxJMCbd/IDrlLqldHBvj0NLa1ouoGmabhOcVolvqyNp8bQDRMrFMayq9BNk8GuiyilXqk0qpWG5K1iLts0eq13Z92CReiGgW6YuMUCgechZfClaggh0DR9MuZhG8uOYJgh4le/oJjL/mE6gzqdJduVHr1uCU201S9cghEKYRZtXKdA4LoEvo9S8hZFhKYhxORCo1sWVsjGDIfRdJ3hK5dIj17feydjOq0p/fgvf37pm8//DLdQaGtc3EokFiMUieC7Dr7nIQMfVTImk4uMhqYbGOZkreu6jlss0NfZQS41uvfEgX0vPfbDX96TK9ZOHNj32zVP7nAKueyu2fUNzJ2/gHBV9ObqWAEw1TsM93QxNjxIJnn97dNHDv4O0KZm/l0fTE4fObjfsELtrY8+/pORa1e/Faupjcaq5xCJxdANE6HrqCAg8D3y2SzZ1CjZ5EguPRL/6OK//vGu7zq9X/VkJAEHGPddJ/Hf439/B/igYdHyFbPrGlfYsZmNmmFENKGZUklP+n6+kE0PjMUHOga/ON8BpIERYLz0nzuWkPi6j+f/AyQVGowU1BFkAAAAAElFTkSuQmCC
// @grant none
// ==/UserScript==

(function() {
    const DEBUG_MODE = false

    let { host, href, search } = location,

        // INSTANCES //
        // invidious = 'piped.kavin.rocks',
        // invidious = 'yewtu.be',
        invidious = 'invidious.nerdvpn.de'
        searx = 'search.mdosch.de',
        rdx = 'rdx.overdevs.com',
        nitter = 'nitter.snopyta.org',
        bibliogram = 'bibliogram.pussthecat.org',
        wikiless = 'wikiless.org',
        lingva = 'lingva.ml',
        scribe = 'scribe.rip',
        rimgo = 'rimgo.pussthecat.org',
        librarian = 'librarian.pussthecat.org',
        proxitok = 'proxitok.pussthecat.org',
        quetre = 'qr.vern.cc',
        hyperpipe = 'hyperpipe.surge.sh',

        data = [
            [['music.youtube.com'], youtubeMusicRedirect],
            [['youtube.com'], youtubeRedirect],
            // [['google.'], googleRedirect],
            [['search.yahoo.com'], yahooRedirect],
            [['bing.com'], bingRedirect],
            [['reddit.com'], rdxRedirect],
            [['twitter.com'], twitterRedirect],
            // [['wikipedia.org'], wikipediaRedirect],
            [['medium.com', 'towardsdatascience.com'], mediumRedirect],
            // [['i.imgur.com'], imgurRedirect],
            [['odysee.com'], odyseeRedirect],
            [['tiktok.com'], tiktokRedirect],
            [['quora.com'], quoraRedirect],
        ]

    const LOGS_TITLE = 'REDIRECTOR LOGS\n'
    const HTTPS = 'https://'
    const DEFAULT_CATEGORY = 'general'
    const CATEGORIES = {
        IMAGES: 'images',
        VIDEOS: 'videos',
        NEWS: 'news',
        MAP: 'map',
        SCIENCE: 'science',
    }

    mainRedirect(location, data)

    function mainRedirect(loc, cases) {
        for (let i = 0; i < cases.length; i++) {
            let currentCase = cases[i]
            let domains = currentCase[0]
            let redirectFn = currentCase[1]

            for (let j = 0; j < domains.length; j++) {
                let domain = domains[j]
                let hostHasDomain = hostHas(domain)

                if(DEBUG_MODE) {
                    console.log(LOGS_TITLE, 'DOMAIN:', domain, 'REDIRECT FN:', redirectFn, 'HOST HAS DOMAIN:', hostHasDomain)
                }

                if(hostHasDomain) {
                    return redirectFn()
                }
            }
        }
    }

    function youtubeMusicRedirect() {
        return redirect(hyperpipe)
    }

    function quoraRedirect() {
        return redirect(quetre)
    }

    function tiktokRedirect() {
        return redirect(proxitok)
    }

    function odyseeRedirect() {
        return redirect(librarian)
    }

    function imgurRedirect() {
        return redirect(rimgo)
    }

    function mediumRedirect() {
        if(!/^\/$/.test(location.pathname)) {
            return redirect(scribe)
        } else {
            let perfObs = PerformanceObserver

            if(perfObs) {
                let obs = new PerformanceObserver((list) => {
                    let entries = list.getEntries()

                    for (let i = 0; i < entries.length; i++) {
                        let entry = entries[i]

                        if(entry.name.endsWith('graphql')) {
                            mainRedirect(location, data)
                        }
                    }
                })

                obs.observe({
                    entryTypes: ['resource']
                })
            } else {
                return redirect(scribe)
            }
        }

        function getPerformanceObserver() {
        }
    }

    function wikipediaRedirect() {
        let _host = host.split('.')
        let lang = 'en'

        if(_host.length > 2 && _host[0] !== 'www') {
            lang = _host[0]
        }

        return redirect(wikiless, '?lang=' + lang)
    }

    function twitterRedirect() {
        return redirect(nitter)
    }

    function rdxRedirect(domain = 'reddit.com', pathname = location.pathname) {
        const baseUrl = 'https://rdx.overdevs.com/';
        const subRedditPostPostfix = 'comments.html?url=';
        const subRedditOnlyPostfix = 'subreddit.html?r=';

        // Don't redirect reddit.com media links
        if (pathname.includes("media")) {
          return
        }

        // Redirect reddit.com post links
        let redirectUrl = baseUrl + subRedditPostPostfix + HTTPS + domain + pathname

        // Redirect reddit.com
        if (pathname == "/" || pathname == "") {
          redirectUrl = baseUrl
          return location.replace(redirectUrl)
        }

        // Redirect reddit.com subreddit only links
        const subRedditOnly = /r\/([a-zA-Z0-9]+)\/?$/;
        const subRedditOnlyMatch = pathname.match(subRedditOnly)
        if (subRedditOnlyMatch) {
          const subRedditName = subRedditOnlyMatch[1];
          redirectUrl = baseUrl + subRedditOnlyPostfix + subRedditName
        }

        return location.replace(redirectUrl)

    }

    function redditRedirect() {
        return redirect(libreddit)
    }

    function youtubeRedirect() {
        return redirect(invidious)
    }

    function bingRedirect() {
        if(createSearchExp('bing', 'com').test(href)) {
            let searchParams = new URLSearchParams(search)
            let searchQuery = searchParams.get('q')
            let category

            category = chooseCase(location.pathname, {
                images: CATEGORIES.IMAGES,
                videos: CATEGORIES.VIDEOS,
                news: CATEGORIES.NEWS,
                maps: CATEGORIES.MAP,
            }, DEFAULT_CATEGORY, false)

            let _search = createSearch(searchQuery, category)

            return redirectSearx(_search)
        }
    }

    function yahooRedirect() {
        if(createSearchExp('yahoo', 'com').test(href)) {
            let searchParams = new URLSearchParams(search)
            let searchQuery = searchParams.get('p')
            let category

            category = chooseCase(location.host, {
                images: CATEGORIES.IMAGES,
                video: CATEGORIES.VIDEOS,
                news: CATEGORIES.NEWS,
            }, DEFAULT_CATEGORY, false)

            let _search = createSearch(searchQuery, category)

            return redirectSearx(_search)
        }
    }

    function googleRedirect() {
        if(host.match(/translate\.google\..{2,3}/)){
            if(search === '') {
                location.replace('https://' + lingva)
            } else {
                let _search = new URLSearchParams(search),
                    sourceLang = _search.get('sl'),
                    targetLang = _search.get('tl'),
                    text = _search.get('text')

                location.replace(HTTPS + lingva + '/' + sourceLang + '/' + targetLang + '/' + text)
            }
        } else if(/www.google.+/.test(href) && createSearchExp('google').test(href)) {
            let searchParams = new URLSearchParams(search)
            let searchQuery = searchParams.get('q')
            let searchCategory = searchParams.get('tbm')
            let category

            category = chooseCase(searchCategory, {
                isch: CATEGORIES.IMAGES,
                vid: CATEGORIES.VIDEOS,
                bks: CATEGORIES.SCIENCE,
                nws: CATEGORIES.NEWS,
            }, DEFAULT_CATEGORY)

            let _search = createSearch(searchQuery, category)

            return redirectSearx(_search)
        }
    }

    function redirectSearx(_search) {
        return redirect(searx, _search , '/search')
    }

    function createSearchExp(secondLevelDomain, topLevelDomain = '') {
        return new RegExp(secondLevelDomain + '\\.' + topLevelDomain + '.*\\/search')
    }

    function createSearch(searchQuery, category = DEFAULT_CATEGORY) {
        return `?q=${searchQuery}&categories=${category}`
    }

    function chooseCase(x, obj, defaultValue, isEqualsTo = true) {
        let cases = Object.keys(obj)

        for (let i = 0; i < cases.length; i++) {
            let currentCase = cases[i]
            let currentValue = obj[currentCase]

            if(isEqualsTo) {
                if(x === currentCase) {
                    return currentValue
                }
            } else {
                if(x.indexOf(currentCase) > -1) {
                    return currentCase
                }
            }
        }

        return defaultValue
    }

    function redirect(domain, _search = search, pathname = location.pathname) {
        if(!_search.startsWith('?')) {
            _search = '?' + _search
        }

        let redirectUrl = HTTPS + domain + pathname + _search

        if(DEBUG_MODE) {
            return console.log(LOGS_TITLE, 'URL:', redirectUrl, 'DOMAIN:', domain, 'SEARCH:', _search, 'PATHNAME:', pathname)
        } else {
            return location.replace(redirectUrl)
        }
    }

    function hostHas(str) {
        return location.host.indexOf(str) != -1
    }
})()
