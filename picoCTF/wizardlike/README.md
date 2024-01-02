
# "Wizardlike" by picoCTF

This one was one of the highest-scoring crackmes, so it was supposed to be the hardest. Unfortunately, it is not. I think "[Powershelly](https://pugachev.io/2023/12/23/powershelly-by-picoctf/)" or "[Rolling My Own](https://pugachev.io/2023/12/16/rolling-my-own-by-picoctf/)" are more interesting and difficult to solve, but maybe I'm a bit biased.

This is a cute little game that reminded me of the good old days of [text games](https://en.wikipedia.org/wiki/List_of_text-based_computer_games) with amazing ASCII graphics. It is, of course, very simple, but still. Your goal is to find the flag by traveling through "dungeons", which are ten maps. Each map has a "floor" that your character `@` can step on, walls, and stairs that help you climb up or down to another level. The problem is that you don't see the whole map: parts of it appear if you get closer to the currently visible border ("[fog of war](https://en.wikipedia.org/wiki/Fog_of_war#Simulations_and_games)", yay!) , and each map is designed in such a way that the character does not have a normal opportunity to explore it all. So you need to find a way to deal with it.

Given the way the game looks on the console, my first thought was that the author should use some kind of TUI library to make working with the terminal easier. Based on the lines in the binary, it was [ncurses](https://invisible-island.net/ncurses/):

```bash
$ strings -d ./game | grep -i curses
NCURSES_ASSUMED_COLORS
NCURSES_NO_UTF8_ACS
NCURSES_NO_PADDING
```

The only problem is that my "IDA Free" does not recognize it and does not provide any tools for preparing FLIRT signatures yourself if you do not have a full copy of it. Ghidra gives you such tools (sort of), but they are very awkward to use, at least in my opinion. So I had to spend some time preparing my own set of bash magic, which I described [here](https://pugachev.io/2023/12/31/how-to-generate-ghidra-fidb-files/).

After all this preparation, disassembling, cleaning and renaming, the simplified preudo-C code for this game looks like this:

```c
int main_loop() {
    init_terminal();
    init_map(level1);

    int is_running = 1;
    while (is_running) {
        if (level != current_level) {
            init_map(level);
            place_character_on_the_map();
        }
        
        clear_terminal();
        draw_map_around_character(characterX, characterY)

        switch(char_pressed()) {
            case 'Q': 
                is_running = 0;
                break;
                
            case 'w':
            case 's':
            case 'a':
            case 'd':
                move_character();
        }

        char c = character_position_on_map();
        if(c == '>') {
            level++;
        } else if (c == '<') {
            --level;
        }
    }
}
```

The author suggests that "with the right focus and preparation, you can teleport to anywhere on the map". I'm not sure how to do this, maybe I missed something, didn't find a "cheat" or some kind of vulnerability that would help with this, I don't know. My idea was that if I didn't see a map in the game, I could just print it directly from the binary.

Each map is a 100x100 array of characters, they are located one after the other in the file and each of them is aligned on a 32-byte boundary. So to print them out, we need to find the address of the first one, write 10k characters and, add `0x2720` to the address to get the next one:

```bash
$ for (( i=0; i < 10; i++)); do dd status=none if=./game count=10000 bs=1 skip=$((0x11a840 + $i*0x2720)) | fold -w 100 -s; done
```

This is what you will see on the first map:
![](https://github.com/itwaseasy/crackmes-solutions/blob/master/picoCTF/wizardlike/wizardlike.png)

And each of them has symbols that will ultimately make up the flag. Nice!
