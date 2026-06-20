---
date: 2026-05-27
title: COMING SOON, PRETTY FEEDS
desc: pretty feeds
tags: ssg
cats: sw gem draft
---
# Pretty Feeds

The raw XML you usually come across when visiting a site's RSS or Atom feed is usually hostile-looking to accidental visitors. What if it could be a micro homepage of it's own?

I come across pretty human-readable feeds sometimes:

https://susam.net/feed.xml  
https://petermolnar.net/feed  
https://hacdias.com/feed.xml  
https://www.cedricbonhomme.org/blog/index.xml  
https://darekkay.com/atom.xml
https://foon.uk/feeds/rss.xml

Pretty, no? They're rendered client-side with XSLT stylesheets, by dropping something along the lines of `<?xml-stylesheet href="./feed.xsl" type="text/xsl"?>` at the top of one's feed xml and preparing some XSLT.

XSLT (Extensible Stylesheet Language Transformations) lets us reshape the XML. Here's what an XSLT stylesheet could look like:

```xml
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <body>
                <h1>
                    <xsl:value-of select="atom:feed/atom:title"/>
                </h1>
                <ul>
                    <xsl:for-each select="atom:feed/atom:entry">
                        <li>
                            <a href="{atom:link/@href}">
                                <xsl:value-of select="atom:title"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
```

... transforming Atom XML elements to HTML.

Sadly, Chromium [has officially deprecated XSLT](https://developer.chrome.com/docs/web-platform/deprecating-xslt) and should be removing it soon. Firefox and Webkit have signalled similar intentions. If that bothers you, another option is to use CSS styling: `<?xml-stylesheet type="text/css" href="https://example.com/rss.css" ?>`

It's less powerful as it can only style the XML as is, and not really restructure it into HTML.

As explained here:
https://www.petefreitag.com/blog/css-stylesheet-rss/