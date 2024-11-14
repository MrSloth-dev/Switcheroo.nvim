# Switcheroo - A simple colorscheme switcher
This plugin allows to switch your colorscheme and make a quick preview with a code snippet.
What differentiates this plugin from other is that it sources every month the colorschemes on [Awesome-neovim](https://github.com/rockerBOO/awesome-neovim) (Currently not working).

<br>
## Install

<details>
<summary><b>💤 Lazy.nvim 💤</b></summary>

``` lua
{
    "MrSloth-dev/Switcheroo.nvim",
    requires = { "rktjmp/lush.nvim", "nvim-telescope/telescope.nvim" },
    opts = {}
},
```
</details>

## Dependecies

- [Lush](https://github.com/rktjmp/lush.nvim) as some colorschemes have that dependency.
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Neovim >= 0.10](https://neovim.io/)

## Usage

Ever wanted to try new colorschemes but the search, clone, install and update cycle is too boring?

Now you can open the Preview Window with `:Switcheroo` and see the list of the colorschemes avaiable for you and hot reload the colorscheme with a code snippet preview. Then you can select by pressing `<Enter>`

By default the plugin is showing only with the already installed in your computer.

## Known Issues

- The choice only works for current session

To report a bug or ask for a feature, please open a [Github issue](https://github.com/MrSloth-dev/42-NorminetteNvim/issues/new)
<br>

## Roadmap

- [ ] Make the choosen colorscheme permanent through all sessions.
- [ ] Create a file with the choosen colorscheme with the link for the origin repo for more costumization.
- [ ] Get colorschemes from [awesome-neovim repo](https://github.com/rockerBOO/awesome-neovim)
    - [ ] Temp install with [lazy.nvim](https://github.com/folke/lazy.nvim/) for quick preview
- [ ] Improve performance and minimize errors
- [ ] Get multiple code snippets in different languages

## Changelog
All notable changes to this project will be documented in this file.

### [0.1] - 2024-11-14

### Added

- This is the first Version, it's working only with installed colorschemes.

## License
MIT
