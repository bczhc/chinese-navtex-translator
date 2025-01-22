chinese-navtex-translator
--

Translate Chinese NAVTEX messages in "Chinese telegraph code" or
"GB/T 18766-2009" format into readable text.

For the potential copyright issue, dictionary `18766-2009.txt` is
not included in this project (sorry..). You can obtain it from <https://github.com/frank-1225/Chinese-Navtex-Translator>,
converting the `xlsx` file to a `<key>\t<value>` table and putting
under the `dict` directory. (btw I'm also interested on how the linked
repository owner obtain such a dictionary file. I searched a lot, just
had no luck to get any info about `GB/T 18766-2009`.)

## Usage

Put the NAVTEX telegram to `samples/18766-navtex.txt` or `telegraph-code-navtex.txt`
(depending on the NAVTEX message type), and run `./18766` and `./telegraph-code`
correspondingly.
