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

## Installation

Copy `ace_vimtura` folder to your javascripts folder.

## Usage

### Basics

#### Code

```html
<script src="ace_vimtura/ace_vimtura.js" type="text/javascript" charset="utf-8"></script>
...
<div id="editor"></div>
```

```javascript
AceVimtura.init('editor')
AceVimtura.setTheme('twilight')
```

#### Commands and getting help

There is no buttons in here. Just command line. Now you
should be already familiar with concept of modes in Vim.
Like in Vim, to enter command set normal mode and hit `:`.
There will appear little console at the bottom. Type in commands
here and hit enter. Try `:help` first.

##### map
Go to normal mode and enter command `:map` and hit enter to
see key bindings from Vim defaults. See [Vim reference](http://vimdoc.sourceforge.net/htmldoc/usr_toc.html).

##### help

`:help` command will display basic instructions and command list.

## Customize

### Adding custom commands

You can add your own commands to call with `:` in normal mode:

```javascript
AceVimtura.vimapi.defineEx(name, shortname, function(cm, params));
```

Passed parameters accessible via `params.args`.
