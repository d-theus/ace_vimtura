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
<script src="lib/require.js" type="text/javascript" charset="utf-8"></script>
<script src="ace_vimtura/main.js" type="text/javascript" charset="utf-8"></script>
...
<body>
  ...
  <h1>Ace Vimtura Test page</h1>
    <div id="ace_vimtura" style="height: 500px"></div>
      <script>
          require(['ace_vimtura'], function(){
            editor = AceVimtura.init('ace_vimtura');
          });
  </script>
  ...
</body>
```

#### Commands and getting help

There is no buttons in here. Just command line. Now you
should be already familiar with concept of modes in Vim.
Like in Vim, to enter command set normal mode and hit `:`.
There will appear little console at the bottom. Type in commands
here and hit enter. Try `:help` first.

##### :map
Go to normal mode and enter command `:map` and hit enter to
see key bindings from Vim defaults. See [Vim reference](http://vimdoc.sourceforge.net/htmldoc/usr_toc.html).

##### :help

`:help` command will display basic instructions and command list.

##### :set

Set is meant to set variables in Vim. In AceVimtura there are
several settings you can tune:
* `theme`
* `mode`
* `renderer`
* `filetype` <=> `renderer` + `mode`

Example:

        :set filetype haml

## Customize

### Adding custom commands

You can add your own commands to call with `:` in normal mode:

```javascript
AceVimtura.vimapi.defineEx(name, shortname, function(cm, params));
```

Passed parameters accessible via `params.args`.

### Custom renderers

Renderer can be used as built-in renderers do if it:

* is a class, i.e. can be instantiated with `new`
* implements `render(text)` method with rendered html being returned
* resides in `ace_vimtura/renderers` directory
* class name is capitalized form of file name

Given all requirements are satisfied, you can just `editor.setRenderer('your_renderer_name')`.
