---
date: 2025-05-08
title: routing markdown for a single-page blog
desc: A blog post about how my single-page and dynamic, GitHub-based javascript website works.
tags: sw web js
cats: sw
---
# My simple GitHub-based JS SPA blog

If you're reading this, my website is likely no longer a javascript SPA! But let us posit that it still is. Please, for this post, we're at [commit `ca413ad`](https://github.com/aashvikt/aashvikt.github.io/commit/ca413ad) of my GitHub Pages repo. All it contains is a favicon, a `CNAME` file, a `license.md`, and [**index.html**](https://raw.githubusercontent.com/aashvikt/aashvikt.github.io/ca413ad/index.html). Voyez its workings!

---

## Structure

There's a sad `<head>` with the right `<meta>` tags to be anti-SEO and just enough plain CSS to look shitty even on mobile. A basic sans-serif font stack and <span style="color: dodgerblue">bright blue</span> links, four css classes for different fractions of `max-width`s that let me make rows of images.
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="robots" content="noindex, nofollow">
    <title>username</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="/favicon.png">
    <style>
        body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; max-width: 800px; padding: 5%; margin: auto; }
        body, a { color: #202020 }
        a:hover, #content a, strong a { text-decoration: none; color: dodgerblue; }
        h1 { text-align: center }
        code, pre, textarea { font-family: monospace; width: fit-content; max-width: 100%; overflow-x: auto; margin: auto; background-color: whitesmoke; }
        img, video, iframe { max-width: 100%; max-height: 80vh; vertical-align: top; }
        .two { max-width: 49% } .three { max-width: 32% } .four { max-width: 24% } .five { max-width: 19% }
    </style>
</head>
<!-- ... -->
</html>
```

Then, a husk of a `<body>`: a line for a header, and three for contacts, a copyright line, and badges for w3c validity and 250kb.club. `<span id="greet"></span>` and `<div id="content"></div>` are left empty to be filled with javascript later.
```html
<html>
<!-- ... -->
<body>
    <strong><a href="/">username</a></strong>&emsp;<span id="greet"></span>
    <br><br><div id="content"></div><br>
    git(<a href="https://github.com/username">hub</a>, <a href="https://gitlab.com/username">lab</a>) /
    <a href="https://discord.com/users/me_discord">discord</a> /
    <a href="mailto:me@mail.moo">mail</a>
    <br>
    <a href="https://validator.w3.org/nu/?doc=https://username.com">w3c xhtml✓</a>&ensp;
    <a href="https://jigsaw.w3.org/css-validator/validator?uri=https://username.com">w3c css✓</a>&ensp;
    <a href="https://250kb.club/username-com">250kb.club</a>
    <br>
    © 2024 AshT. All rights burgled by raccoons.
    <a href="https://github.com/username/username.github.io">Source code</a>
    is <a href="https://github.com/username/username.github.io/blob/main/LICENSE.md">MIT</a>,
    <a href="https://github.com/username/writing">content</a> is <a href="https://creativecommons.org/licenses/by-nc-sa/4.0">CC BY-NC-SA</a>.
    <script>...</script>
</body>
</html>
```

## Greeter JS

And fill with javascript it does: first, there's a greeter to fill in that span. By default, it puts a shruggie, but on the occasions of _e_ day, radio day, _π_ day, my birthday, alien day, summer and winter solstices, robot day, _mol_ day, pumpkin day, and _pinecone tree day_, it puts corresponding emojis:
```html
<script>
    const today = new Date(), m = today.getMonth(), d = today.getDate();
    document.getElementById('greet').innerHTML =
        m==1 && d==7 ? "e" :
        m==1 && d==13 ? "📻" :
        m==2 && d==14 ? "π" :
        m==3 && d==25 ? "🍰" :
        m==3 && d==26 ? "👽" :
        (m==5 || m==11) && d==21 ? "🔥❄️" :
        m==8 && d==26 ? "🤖" :
        m==9 && d==23 ? "mol" :
        m==9 && d==25 ? "🎃" :
        m==11 && d==25 ? "🎄" :
        "¯\\_(ツ)_/¯";
    // ...
</script>
```

## Content JS

### the other repo

In a separate GitHub repository, `github.com/username/writing`, I keep my content where each page lives in its own folder as a `src.md` and associated media files. For four posts and an index, it could look something like this, ft. a fictional [tree](https://en.wikipedia.org/wiki/Tree_(command)):
```
(writing)
.
├── index
│   └── src.md
├── digital_signal_processing
│   ├── src.md
│   └── assets
│       ├── graph.avif
│       ├── transform.png
│       └── anim.mp4
├── keyboard
│   └── src.md
├── post3
│   ├── src.md
│   └── assets
│       └── audio.wav
└── teensy_4.1
    ├── src.md
    └── assets
        └── teensy_box.jpg
```

I use GitHub's raw content URLs to fetch from that repo, so to fetch the markdown content for `post3` would be along the lines of:
```js
await(await fetch(
'https://raw.githubusercontent.com/username/writing/main/post3/src.md'
)).text()
```

### render

The entirety of the minimized version, `marked.min.js`, of Christopher Jeffrey's tiny [_marked.js_](https://github.com/markedjs/marked) markdown to HTML compiler, dependency-less and fitting into less than forty kilobytes, is contained in one line (by far the heaviest in this website) of javascript and is as easy to use as calling `marked.parse('md content')`! It's certainly a lot nicer than the jank regex-based markdown "parser" (hah, as if) I had in the middle.

Since this is a GitHub Pages site and hence static, two routes to _Single-Page Application_ I considered going were to use 404 pages, or to use [URL fragments](https://en.wikipedia.org/wiki/URI_fragment), and I've gone with the latter to keep the website in one file.

It gets the fragment from our url using `window.location.hash`, and removes the hash mark with a `.slice(1)`, and defaults to `https://raw.gi...ting/main/index/src.md` if fragment is empty. We can smack this into the aforespecified content url format to fetch and render `src.md`, and also set it to the page's title bar text:
```js
document.getElementById('content').innerHTML = marked.parse(
    await(await fetch(
        `https://raw.gi...ting/main/${
            document.title = window.location.hash.slice(1) 
            || 'index'
        }/src.md`
    )).text()
);
```

So in case of no fragment, the `https://raw.gi...ting/main/index/src.md` displayed could be along the lines of:
```md
- [2077-04-01 leaked: audio conveyor belt reportedly in development](/#digital_signal_processing)
- [2024-12-25 third post](/#post3)
- [2023-12-21 let's moose](/#keyboard)
- [2023-11-02 breaking news, tiny board packs punch!](/#teensy_4.1)
```

### absolute URIs

This only inserts text, so images and other media show up broken due to the relative links to `assets/` used in `src.md`. Using a simple regex that matches `"assets/` and `(assets/` to replace that part with `https://raw.gi...ting/main/${post_slug}/assets/`:
```js
const url = `https://raw.githubusercontent.com/username/writing/main/${
    document.title = window.location.hash.slice(1) || 'index'
}`;

document.getElementById('content').innerHTML = marked.parse(
    await(await fetch(`${url}/src.md`)).text()
).replace(
    /(?<=["(])assets\//g,
    `${url}/assets/`
);
```
Such as in the markdown image `![transform plot](transform.png)` and html video `<video controls><source src="anim.mp4">:/</video>`.


### updating

After calling it once initially, we make it run every time the hash in the URL changes!
```js
// uses marked.min.js (https://github.com/markedjs/marked) by Christopher Jeffrey under MIT License
// !function(e,t){"object"==typeof export&&...e.walkTokens=de}));
async function updateContent() {
    const url = `https://raw.githubusercontent.com/username/writing/main/${ document.title = window.location.hash.slice(1) || 'index' }`;
    document.getElementById('content').innerHTML = marked.parse(await(await fetch(`${url}/src.md`)).text()).replace(/(?<=["(])assets\//g,`${url}/assets/`);
}
updateContent();
window.addEventListener('hashchange', updateContent);
```

And we've got a light-ish, single-page blog application!

---

## It's Not Amazing

That's pretty much it: simple...

... and quite dumb:
- It **slowly** fetches and renders markdown every time from a remote URL every time any post opens.
- It fails if platforms or browser extensions **strip fragments** or confuse them for malice.
- It **breaks** if GitHub or GitHub raw content URLs change.
- It doesn't work on browser with cross-origin resource sharing or **javascript** disabled, and I personally know too many (rightfully!) from that >0.2%.

So I'm leaving this here while I make something... [static](/posts/shell-static-site).