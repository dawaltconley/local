# vim

Currently the only thing here is a function I wrote to shift all the absolute coordinates of an svg file by a specified x/y distance. It's usefull for doing simple repositioning without booting up an editor or changing the viewBox coordinate system.

## Notes

- For now, it only shifts an entire file. Perhaps useful to shift individual paths / elements?
- Only tested on files produced by Adobe Illustrator.
- Testing only when I need to use it. If it breaks, it's probably an issue with the regex for the s:num variable.
