# ace_vimtura
Ace-based javascript text editor with Vim keybindings and live preview, several markups supported.

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

#### 

```html
<script src="ace_vimtura/ace_vimtura.js" type="text/javascript" charset="utf-8"></script>
...
<div id="editor"></div>
```

```javascript
  AceVimtura.init('editor')
  AceVimtura.setTheme('twilight')
```

## Customize

```
Requiring themes happens by GET request on demand.

To decrease requests number you can concat `ace_vimtura/ace_vimtura.js` with any of `ace_vimtura/vim/theme-*.js`, `ace_vimtura/vim/ext-*.js` and
   `ace_vimtura/vim/mode-*.js`.
