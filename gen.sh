#!/bin/sh
set -eu

command -v comrak >/dev/null || {
    echo "comrak required"
    exit 1
}


rm -r public/
mkdir -p public/
cp -r include/* posts public/


# find public/assets/ -type f -iname '*.avif' | while read img; do [ "$(identify -format '%w' "$img")" -gt 800 ] && magick "$img" -resize 800x "$img"; done;
# exiftool -r -gps:all= -overwrite_original public/


fix_xml() {
    echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&apos;/g'
}
fix_url() {
    echo "$1" | sed 's/ /%20/g;s/!/%21/g;s/"/%22/g;s/#/%23/g;s/\$/%24/g;s/&/%26/g;s/'"'"'/%27/g;s/(/%28/g;s/)/%29/g;s/*/%2A/g;s/+/%2B/g;s/,/%2C/g;s/\//%2F/g;s/:/%3A/g;s/;/%3B/g;s/=/%3D/g;s/?/%3F/g;s/@/%40/g;s/\[/%5B/g;s/\]/%5D/g'
}

get_tag_index() {
    q=$1
    set -- $tags
    n=1
    for t; do
        [ "$t" = "$q" ] && {
            echo $n
            return
        }
        n=$((n+1))
    done
    return 1
}


cp gen.sh public/gen.sh


post_title="404 not found" \
post_desc="404 page" \
post_tags_comma="404, not found" \
post_content="<h1>404</h1><p>¯\_(ツ)_/¯</p>" \
envsubst < template/index.html > public/404.html


index="" drafts="" items_sitemap="" items_rss="" items_atom="" items_json="" tags=""

for md in $(
    for md in public/posts/*.md; do
        sed -n "2p" "$md"; echo "$md"
    done \
        | paste - -    \
        | sort -r \
        | cut -f2
); do

    post_dir=${md%.md}
    post_slug=${post_dir#public/posts/}

    post_date=$(sed -n '2p' $md)
    post_title="$(fix_xml "$(sed -n '3p' $md)")"
    post_desc="$(fix_xml "$(sed -n '4p' $md)")"
    post_tags="$(sed -n '5p' $md)"
    post_cats="$(sed -n '6p' $md)"

    post_tags_comma="" post_tags_html="" post_tags_rss="" post_tags_atom="" post_tags_json="["

    for tag in $post_tags; do

        tag="$(echo "$tag" | sed 's/[^[:alnum:]-]//g')"

        case " $tags " in
            *" $tag "*) ;;
            *) tags="$tags $tag";;                          # add current (tag) to var tags
        esac
        tagn=$(get_tag_index $tag)
        eval "tag_${tagn}=\"\${tag_${tagn}} ${post_slug}\"" # add post_slug to var like tags_3
    
        post_tags_comma="${post_tags_comma}${tag}, "
        post_tags_html="${post_tags_html}<a href='/tags#${tag}' style='color:inherit'>${tag}</a>, "
        post_tags_rss="${post_tags_rss}<category domain='https://aashvik.com/tags#${tag}'>${tag}</category>"
        post_tags_atom="${post_tags_atom}<category term='${tag}' scheme='https://aashvik.com/tags#${tag}' label='${tag}'/>"
        post_tags_json="${post_tags_json}\"${tag}\", "

    done

    post_tags_comma="${post_tags_comma%, }"
    post_tags_html="${post_tags_html%, }"
    post_tags_json="${post_tags_json%, }]"

    post_comment="mailto:comments@aashvik.com?subject=$(fix_url "Comment on \"${post_title}\" from aashvik.com/posts/${post_slug}")"

    mkdir -p ${md%.md}
    export post_title post_desc post_tags_comma

    post_content="\
<p>
    <small>
        <a href='/posts/${post_slug}.md' style='color:inherit'>View source</a> for \"${post_title}\" [<span ${post_cats}>${post_cats}</span>] from
        <a href='/#${post_slug}' style='color:inherit' ${post_cats}>
            <time datetime='${post_date}'>${post_date}</time>
        </a> in ${post_tags_html}.
        <br><i>${post_desc}</i>
    </small>
</p>
$(
    comrak \
        --unsafe \
        --smart \
        --front-matter-delimiter --- \
        --relaxed-autolinks \
        --header-ids '' \
        --syntax-highlighting base16-eighties.dark \
        --extension alerts,autolink,description-lists,footnotes,greentext,math-code,math-dollars,multiline-block-quotes,spoiler,strikethrough,subscript,superscript,table,tasklist,underline,wikilinks-title-before-pipe \
        ${md} \
    | sed -z -E '
        s@((<img[^>]*[[:space:]]*/?>[[:space:]]*){2,})@<div style="display:flex;gap:1ch;">\1</div>@g
        s@<img([^>]*)title="([^"]+)"([^>]*)>@<figure><img\1title="\2"\3><figcaption>\2</figcaption></figure>@g
        s@(<(img|a)[^>]*[[:space:]](src|href)=[\"'\'']?)~@\1/assets/'"$post_slug"'@g
        s@<img([^>]*)src="([^"]+)\.(mp4|mov|ogv|webm|m4v|mkv|avi|mpg|mpeg)"([^>]*)/>@<video controls><source\1 src="\2.\3" type="video/\3"\4></video>@g
        s@<img([^>]*)src="([^"]+)\.(mp3|wav|ogg|aac|m4a|flac)"([^>]*)/>@<audio controls><source\1 src="\2.\3" type="audio/\3"\4/></audio>@g
    '
    # ^ hehe -- hacky side by side images + captions from titles + /assets/${post_slug} tilde expansion + video tag + audio tag :>
)
<p>
    <small>
        <a href='${post_comment}' style='color:inherit'>comment on \"${post_title}\"</a>
    </small>
</p>" envsubst < template/index.html > "${md%.md}/index.html"

    article="<article post ${post_cats} id='${post_slug}'>
    <time datetime='${post_date}'>
        ${post_date}
    </time>
    <a href='/posts/${post_slug}' title='${post_desc} [${post_tags_comma}] [${post_date%??????}]'>
        ${post_title}
    </a>
</article>"

    echo "$post_cats" | grep -q draft && {
        drafts="${drafts}
${article}"
        continue
    }

    index="${index}
${article}"

    for tag in $post_tags; do
        tagn=$(get_tag_index $tag)
        eval "tag_${tagn}_html=\"\${tag_${tagn}_html}
${article}\""
    done

    items_sitemap="${items_sitemap}
<url>
    <loc>https://aashvik.com/posts/${post_slug}</loc>
    <lastmod>${post_date}</lastmod>
</url>"

    items_rss="${items_rss}
<item>
    <title>${post_title}</title>
    <link>https://aashvik.com/posts/${post_slug}</link>
    <description>${post_desc}</description>
    <author>aashvik@aashvik.com (Aashvik Tyagi)</author>
    <dc:creator>aashvik</dc:creator>
    <slash:section>${post_tags%% *}</slash:section>
    <slash:department>$(echo $post_date | cut -c1-4)</slash:department>
    <slash:comments>42</slash:comments>
    ${post_tags_rss}
    <comments>${post_comment}</comments>
    <guid>https://aashvik.com/posts/${post_slug}</guid>
    <pubDate>$(date -d "${post_date}" +"%a, %d %b %Y") 00:00:00 UT</pubDate>
    <source url='https://aashvik.com/rss.xml'>aashvik</source>
</item>"

    items_atom="${items_atom}
<entry>
  <id>https://aashvik.com/posts/${post_slug}</id>
  <title>${post_title}</title>
  <updated>${post_date}T00:00:00Z</updated>
  <link rel='alternate' type='text/html' href='https://aashvik.com/posts/${post_slug}'/>
  <summary>${post_desc}</summary>
  ${post_tags_atom}
  <published>${post_date}T00:00:00Z</published>
</entry>"

    items_json="${items_json}
{
    \"id\": \"${post_slug}\",
    \"url\": \"https://aashvik.com/posts/${post_slug}\",
    \"title\": \"$(sed -n '3p' $md)\",
    \"summary\": \"$(sed -n '4p' $md)\",
    \"date_published\": \"${post_date}\",
    \"tags\": ${post_tags_json}
},"
done

items_json="${items_json%,}"


tags="${tags#?}"
tags_html=""

for tag in $(
    for tag in $tags; do
        echo "$(
            echo $(
                eval echo "\${tag_$(
                    get_tag_index $tag
                )}"
            ) | wc -w
        ) $tag"
    done \
        | sort -nr \
        | cut -d' ' -f2-
); do

    tags_html="${tags_html}
<section id='${tag}'>
    <header>
        <a href='#${tag}'>${tag}</a>
    </header>
    $(eval echo \${tag_$(get_tag_index $tag)_html})
</section>
<br>"

done


mkdir -p public/tags

post_title=tags \
post_desc="post tags and categories" \
post_tags_comma="tags, categories" \
post_content="<h1>tags</h1><nav>${tags_html%<br>}</nav>" \
envsubst < template/index.html > "public/tags/index.html"

mkdir -p public/drafts/

post_title=drafts \
post_desc="drafts and unindexed posts" \
post_tags_comma="drafts, posts, wip" \
post_content="<h1>drafts</h1><nav>${drafts}</nav>" \
envsubst < template/index.html > "public/drafts/index.html"

date_8601=$(date -u +%Y-%m-%dT%H:%M:%SZ)            # 8601 for atom and sitemap, like date -uIseconds
date_2822="$(date -u +'%a, %d %b %Y %H:%M:%S UT')"  # 2822 for rss, like date -uR

export post_title=aashvik \
    post_desc="computers, robotics, and more" \
    post_tags_comma="index, home, landing, blog" \
    post_content="<p>View <span sw>software</span>, <span hw>hardware</span>, <span rb>robotics</span>, <span misc>miscellaneous</span>, or <a href=/drafts>drafts</a>.</p><nav>${index}</nav>" \
    items_sitemap \
    items_rss \
    items_atom \
    items_json \
    date_8601 \
    date_2822

for file in template/*; do
    envsubst < $file > public/$(basename $file)
done
