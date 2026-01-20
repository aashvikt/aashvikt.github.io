---
date: 2024-12-21
title: simplest python othello bot goes demented
desc: A post about a short and greedy python bot that plays othello for a competition. And another...
tags: sw othello comp
cats: sw gem
---
# Eagerthello
```
O O O O O O O O
O O ■ ■ ■ ■ O O
O ■ ■ O O ■ ■ O
O ■ O O O O O O
O ■ O O ■ ■ ■ O
O ■ ■ O O ■ O O
O O ■ ■ ■ ■ O O
O O O O O O O O
```
I wrote a simple 25loc othello-playing script for an online hackathon-style competition.
For shits, I decided to _forego_ any strategy and leave the bot to **brute-force** picking the most instantly-gratifying disc that'd flank the most discs of the opponent.

You can view the script [here](https://github.com/aashvikt/eagerthello/blob/main/bot.py) along with scripts to test it [against a human](https://github.com/aashvikt/eagerthello/blob/main/test-human.py) and to [play against itself](https://github.com/aashvikt/eagerthello/blob/main/test-bot.py).

Then again, it's only 26loc... here you go:

``` py
def move(board_state, player_color: int):
    maxf = 0 # own color, max flanked
    for row in range(8):
        for col in range(8):
            if board_state[row][col]==0: # empty cell
                dirs = [
                    d for d in ((-1,0), (1,0), (0,-1), (0,1), (-1,-1), (-1,1), (1,-1), (1,1))
                    if row+d[0] in range(8) and col+d[1] in range(8) # exists
                    and board_state [row+d[0]] [col+d[1]] == -player_color # oppo color
                ] # potentially flankable directions
                flanked = 0
                for d in dirs:
                    rcst, travelled = [row,col], 0
                    while 1: # raycast
                        rcst[0] += d[0]
                        rcst[1] += d[1]
                        try: rcstate = board_state [rcst[0]] [rcst[1]]
                        except IndexError: break # ray hit border
                        if rcstate == -player_color: travelled += 1 # carry on
                        else: # ray hit own color
                            if rcstate == player_color and travelled:
                                flanked = travelled + (row in (0, 7) and col in (0,7)) # prefer corners
                            break
                if flanked>maxf: best, maxf = (row, col), flanked
    try: return best
    except UnboundLocalError: pass # forfeit
```

(The competition asked for a python file with a move function they'd automatically call with the current `board_state` in a format they'd specified and that bot's `player_color`.)

Wait, did I just use __list comprehensions__?

Hmm...

```py
move = lambda b, p = max(
    (
        (
            ((b[r][c]==0)*sum(
                sum(1 for k in range(1,8)
                    if all(0<=r+dr*i<8 and 0<=c+dc*i<8 and b[r+dr*i][c+dc*i]==-p for i in range(1,k+1))
                    and 0<=r+dr*(k+1)<8 and 0<=c+dc*(k+1)<8 and b[r+dr*(k+1)][c+dc*(k+1)]==p
                )
                for dr,dc in [(-1,0),(1,0),(0,-1),(0,1),(-1,-1),(-1,1),(1,-1),(1,1)]
            )) + (((b[r][c]==0)*sum(
                sum(1 for k in range(1,8)
                    if all(0<=r+dr*i<8 and 0<=c+dc*i<8 and b[r+dr*i][c+dc*i]==-p for i in range(1,k+1))
                    and 0<=r+dr*(k+1)<8 and 0<=c+dc*(k+1)<8 and b[r+dr*(k+1)][c+dc*(k+1)]==p
                )
                for dr,dc in [(-1,0),(1,0),(0,-1),(0,1),(-1,-1),(-1,1),(1,-1),(1,1)]
            )) and (r in (0,7) and c in (0,7))), (r,c))
        for r in range(8) for c in range(8)
    ),
    default=(0,None), key=lambda x:x[0]
)[1]
```

**GAHAHHAHA**