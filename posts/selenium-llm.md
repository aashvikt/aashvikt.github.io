---
2024-03-08
trying out selenium with llms
About a small LLM python interface I made to try Selenium.
sw web python
sw
---
# Trying out Selenium (python) with an LLM Site

Lately, I wanted to experiment with [Selenium](https://www.selenium.dev/documentation/) for a web-scraping idea I had.
Also, the python library I used for a shell text completion experiment, [freeGPT](https://github.com/Ruu3f/freeGPT), didn't support context across messages.

For these two reasons, I used Selenium to create a [Python script](https://github.com/aashvikt/pyseleniyouchat) that automates browser interactions with `you.com`.
The script allows for continuous conversation by maintaining context between queries, something that was missing in the earlier setup.
With Selenium, I can now send prompts, wait for responses, and fetch answers dynamically, all while keeping the browser in headless mode.

Using Selenium was fairly straightforward, but this script will probably fail as soon as `you.com`'s layout changes.
Another bug is that the script waits for a "content loading" marker to appear and go, but this isn't present in short responses, and so is unreliable.
