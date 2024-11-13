# Switcheroo - A simple colorscheme switcher
This plugin allows to switch your colorscheme and make a quick preview with a code snippet.
What differentiates this plugin from other is that it sources every month the colorschemes on [Awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

<br>
## Install

<details>
	
<summary> <b>📦 Packer 📦</b></summary>

``` lua
use {
    --TODO:
    end,
}
```

</details>
<details>
<summary><b>💤 Lazy.nvim 💤</b></summary>

``` lua
{
	"MrSloth-dev/Switcheroo.nvim",
    --TODO:
},
```
</details>

## Dependecies

- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Neovim >= 0.10](https://neovim.io/)
- [Plenary.nvim](https://github.com/nvim-lua/plenary.nvim) for async.

## Usage

Ever wanted to try new colorschemes but the search, clone, install and update cycle is too boring?

Now you can open the Preview Window with `:Switcheroo` and see the list of the colorschemes avaiable for you and hot reload the colorscheme with a code snippet preview. Then you can select by pressing `<Enter>`

By default the plugin is showing only with the already installed in your computer. You can add `dotfyle = { "top", "new" }` on your configurantion to add top and new lists.(NOT IMPLMENTED)

## Known Issues

- Some of the colorschemes don't correctly load. I'm trying to figure out how to do it.

To report a bug or ask for a feature, please open a [Github issue](https://github.com/MrSloth-dev/42-NorminetteNvim/issues/new)
<br>

## Roadmap

- [ ] Get colorschemes from [awesome-neovim repo](https://github.com/rockerBOO/awesome-neovim)
- [ ] Improve performance and minimize errors
- [ ] Get multiple code snippets in different languages
- [ ] Create a file with the choosen colorscheme with the link for the origin repo. For more costumization

## Changelog
All notable changes to this project will be documented in this file.

### [0.1] - 2024-11-11

### Added

- This is the first Version, it's working only with installed colorschemes.

## License
MIT
