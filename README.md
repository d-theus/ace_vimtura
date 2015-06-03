# ace_vimtura
Ace-based javascript text editor with Vim keybindings and live preview, several markups supported.

If you don't know what Vim is, this package probably wouldn't suite your needs.
I took same approach as Vi or Vim: minimum mouse usage for faster workflow.

## Features

* Variety of markup languages supported
  - html
  - haml
  - markdown

  and more coming
* Live syntax highlighting inside an editor
* Live rendering with renderer of you choise.
  Several renderers are already built in

### Lo-o-ong running TODO

* Autocompletion
* Emmet\Zencoding plugin

## Requirements

### For basic usage

Should work right out of the box

### For enhanced experience

#### Bundling custom theme and mode to minify

* node
* npm
* gulp
* Also see `package.json`

## Installation

Copy `ace_vimtura` folder to your javascripts folder.

## Usage

### Basics

```html
<script src="ace_vimtura/ace_vimtura.js" type="text/javascript" charset="utf-8"></script>
...
<div id="editor"></div>
```

```javascript
AceVimtura.init('editor')
AceVimtura.setTheme('twilight')
```

### Getting help

#### map
Go to normal mode and enter command `:map` and hit enter to
see key bindings from Vim defaults. See [Vim reference](http://vimdoc.sourceforge.net/htmldoc/usr_toc.html).

#### help

`:help` command will display basic instructions and command list.

## Customize

### Optimizing requests

Requiring themes happens by GET request on demand.

To decrease requests number you can concat `ace_vimtura/ace_vimtura.js` with any of `ace_vimtura/ace/theme-*.js`, `ace_vimtura/vim/ext-*.js` and
   `ace_vimtura/ace/mode-*.js`.

### Adding custom commands

You can add your own commands to call with `:` in normal mode:

```javascript
AceVimtura.vimapi.defineEx(name, shortname, function(cm, params));
```

Passed parameters accessible via `params.args`.
