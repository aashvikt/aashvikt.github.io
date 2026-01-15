---
2025-10-22
commonmark+comrak cheatsheet
A cheatsheet for me to reference while writing blogposts.
sw web md
misc gem draft
---
# commonmark (extended) cheatsheet
Specifically, the parts I forget.

## frontmatter
ignored at beginning:
```
---
2025-10-22
title
Longer description.
tag1 tag2 tag3
gem draft sw hw rb misc
---
```

## text and tables
```md
| `markdown`  | result    |
|-------------|-----------|
| `**bold**`  | **bold**  |
| `_italic_`  | _italic_  |
| `__under__` | __under__ |
| `a^sup^`    | a^sup^    |
| `a~sub~`    | a~sub~    |
| `~~cut~~`   | ~~cut~~   |
```
becomes
| `markdown`  | result    |
|-------------|-----------|
| `**bold**`  | **bold**  |
| `_italic_`  | _italic_  |
| `__under__` | __under__ |
| `a^sup^`    | a^sup^    |
| `a~sub~`    | a~sub~    |
| `~~cut~~`   | ~~cut~~   |

## image captions
to create a figure and figcaption setup, do `![alt described image](/assets/link/to/image "Caption and Title shows up with image")`
>>>
```md
![back of (new) robot](/assets/rfgy24/back.avif "Back of the new robot")
```
![back of (new) robot](/assets/rfgy24/back.avif "Back of the new robot")
>>>

## side by side images
images separated by only one newline or one whitespace show up side-by-side:
>>>
```md
![front of (new) robot](/assets/rfgy24/front.avif "Front of the new robot")
![back of (new) robot](/assets/rfgy24/back.avif "Back of the new robot")
```
![front of (new) robot](/assets/rfgy24/front.avif "Front of the new robot")
![back of (new) robot](/assets/rfgy24/back.avif "Back of the new robot")
>>>

## spoilers and html
`||spoiler||`, so darth vader is ||luke's daddy||

<details open>
    <summary>expand (native html)</summary>

```html
<details><summary>text</summary>show on reveal</details>
```

||(here, `<details open>`)||

and more spoilers:
```md
darth vader is ||an alligator,  <!-- two spaces -->
20% of the time||
```
becomes
darth vader is ||an alligator,  
20% of the time||
</details>

## lists
```md
* see this?
- this is it
- enjoyable
3. okay
4. okay again
* [ ] hi
* [x] checked
6. [x] yellow
7. [ ] pink
```
looks like
>>>
* see this?
- this is it
- enjoyable
3. okay
4. okay again
* [ ] hi
* [x] checked
6. [x] yellow
7. [ ] pink
>>>

## alerts
```md
> [!note]
> take this info into account

> [!tip]
> get more success

> [!important]  
> crucial to success

> [!warning]  
> immediate attention required

> [!caution]
> tread carefully

> [!note] not a final solution
> later, the pretzel was eaten
```
makes
>>>
> [!note]
> take this info into account

> [!tip]
> get more success

> [!important]
> crucial to success

> [!warning]
> immediate attention required

> [!caution]
> tread carefully

> [!note] not a final solution
> later, the pretzel was eaten
>>>

## description lists
```md
term
:   definition

word
:   meaning
```
for

term1
:   definition1

term2
:   definition2

## quotes
> `> single line quote`, and
```md
>>>
multi-line
quote
>>>
```

## footnotes
do  `[^fn1]`.[^fn1]

and, if you want, again ([^fn1])

later, do:
```md
[^fn1]: footnote content
```

[^fn1]: footnote content

## wikilinks
`[[text content|wikilink]]`  
like `[[my iems|blon-bl03]]`  
shown [[my iems|blon-bl03]]  
and  
use `(^|[^!])\[[^\]]+\]\(\/[^)]*\)` regex to find things you can 'ikilinkify.

## math
for `data-math-style=inline`, `$math$` like $x^2 + y^2 = z^2$

for `data-math-style=display`, `$$math$$`:
$$
\int_{0}^{1} x^2 , dx = \frac{1}{3}
$$

and for math codeblock, ` ```math ...``` `

## conclusion
Good for reference!