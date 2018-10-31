# Load-indent.vim
This plugin reads a file and sets `shiftwidth` and `tabstop` to indent width used in the file.

If hard tabs, not soft tabs is used, `noexpandtab` is set.

This is released under the MIT License, see LICENSE .

## Additional Configuration Example
You can define candidates for indent width.

The default value is [2, 3, 4, 8].

```vim
let g:loadindent#indent_candidates = [2, 4]
```

You can define the max number of lines that this plugin read to determine indent width.

The default value is 300.

```vim
let g:loadindent#max_read_lines = 1000
```
