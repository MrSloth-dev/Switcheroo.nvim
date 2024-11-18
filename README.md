# Switcheroo - A simple colorscheme switcher

Ever wanted to try new colorschemes but the search, clone, install and update cycle is too boring?

This plugin allows to switch your colorscheme and make a quick preview with a code snippet.
What differentiates this plugin from other is that it sources every month the colorschemes on [Awesome-neovim](https://github.com/rockerBOO/awesome-neovim) to access 100+ colorschemes!

Note: At the moment the source isn't automated. You can visit "Awesome-neovim" section how to install those.

## Install

<details>
<summary><b>💤 Lazy.nvim 💤</b></summary>

``` lua
{
    "MrSloth-dev/Switcheroo.nvim",
    dependencies = { "rktjmp/lush.nvim", "nvim-telescope/telescope.nvim" },
    opts = {}
},
```
</details>

## Dependecies

- [Lush](https://github.com/rktjmp/lush.nvim) as some colorschemes have that dependency.
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Neovim >= 0.10](https://neovim.io/)

## Usage

You can open the Preview Window with `:Switcheroo` and see the list of the colorschemes avaiable for you and hot reload the colorscheme with a code snippet preview. Then you can select by pressing `<Enter>`

By default the plugin is showing only with the already installed in your computer. So if you want to try more colorschemes, read the next section.

## Awesome-neovim

Right now you're not able to import temporarily the colorschemes plugins , but you can add as dependencies showed as below.
I know it's ugly but I'm working on this to make it work.

<details>
<summary><b>💤 Lazy.nvim 💤</b></summary>

``` lua
{
    "MrSloth-dev/Switcheroo.nvim",
    dependencies = { "rktjmp/lush.nvim",
			"rktjmp/lush.nvim",
			"nvim-telescope/telescope.nvim",
			"sontungexpt/witch",
			"Abstract-IDE/Abstract-cs",
			"tomasiser/vim-code-dark",
			"Mofiqul/vscode.nvim",
			"marko-cerovac/material.nvim",
			"bluz71/vim-nightfly-colors",
			"bluz71/vim-moonfly-colors",
			"ChristianChiarulli/nvcode-color-schemes.vim",
			"folke/tokyonight.nvim",
			"comfysage/evergarden",
			"sainnhe/sonokai",
			"nyoom-engineering/oxocarbon.nvim",
			"kyazdani42/blue-moon",
			"mhartington/oceanic-next",
			"nvimdev/zephyr-nvim",
			"rockerBOO/boo-colorscheme-nvim",
			"jim-at-jibba/ariake.nvim",
			"ishan9299/modus-theme-vim",
			"sainnhe/edge",
			"theniceboy/nvim-deus",
			"PHSix/nvim-hybrid",
			"Th3Whit3Wolf/space-nvim",
			"yonlu/omni.vim",
			"ray-x/aurora",
			"tanvirtin/monokai.nvim",
			"ofirgall/ofirkai.nvim",
			"savq/melange-nvim",
			"fenetikm/falcon",
			"andersevenrud/nordic.nvim",
			"AlexvZyl/nordic.nvim",
			"shaunsingh/nord.nvim",
			"ishan9299/nvim-solarized-lua",
			"jthvai/lavender.nvim",
			"navarasu/onedark.nvim",
			"sainnhe/gruvbox-material",
			"sainnhe/everforest",
			"neanias/everforest-nvim",
			"NTBBloodbath/doom-one.nvim",
			"dracula/vim",
			"Mofiqul/dracula.nvim",
			"niyabits/calvera-dark.nvim",
			"nxvu699134/vn-night.nvim",
			"adisen99/codeschool.nvim",
			"projekt0n/github-nvim-theme",
			"kdheepak/monochrome.nvim",
			"rose-pine/neovim",
			"zenbones-theme/zenbones.nvim",
			"catppuccin/nvim",
			"FrenzyExists/aquarium-vim",
			"EdenEast/nightfox.nvim",
			"kvrohit/substrata.nvim",
			"ldelossa/vimdark",
			"Everblush/nvim",
			"adisen99/apprentice.nvim",
			"olimorris/onedarkpro.nvim",
			"rmehri01/onenord.nvim",
			"RishabhRD/gruvy",
			"luisiacc/gruvbox-baby",
			"titanzero/zephyrium",
			"rebelot/kanagawa.nvim",
			"sho-87/kanagawa-paper.nvim",
			"kevinm6/kurayami.nvim",
			"tiagovla/tokyodark.nvim",
			"cpea2506/one_monokai.nvim",
			"phha/zenburn.nvim",
			"kvrohit/rasmus.nvim",
			"chrsm/paramount-ng.nvim",
			"qaptoR-nvim/chocolatier.nvim",
			"rockyzhang24/arctic.nvim",
			"ramojus/mellifluous.nvim",
			"Yazeed1s/minimal.nvim",
			"Mofiqul/adwaita.nvim",
			"olivercederborg/poimandres.nvim",
			"mellow-theme/mellow.nvim",
			"gbprod/nord.nvim",
			"Yazeed1s/oh-lucy.nvim",
			"embark-theme/vim",
			"nyngwang/nvimgelion",
			"maxmx03/fluoromachine.nvim",
			"dasupradyumna/midnight.nvim",
			"uncleTen276/dark_flat.nvim",
			"zootedb0t/citruszest.nvim",
			"xero/miasma.nvim",
			"Verf/deepwhite.nvim",
			"judaew/ronny.nvim",
			"ribru17/bamboo.nvim",
			"cryptomilk/nightcity.nvim",
			"polirritmico/monokai-nightasty.nvim",
			"oxfist/night-owl.nvim",
			"miikanissi/modus-themes.nvim",
			"alexmozaidze/palenight.nvim",
			"scottmckendry/cyberdream.nvim",
			"HoNamDuong/hybrid.nvim",
			"bartekjaszczak/distinct-nvim",
			"samharju/synthweave.nvim",
			"ptdewey/darkearth-nvim",
			"uloco/bluloco.nvim",
			"slugbyte/lackluster.nvim",
			"0xstepit/flow.nvim",
			"samharju/serene.nvim",
			"killitar/obscure.nvim",
			"bakageddy/alduin.nvim",
			"diegoulloao/neofusion.nvim",
			"bartekjaszczak/luma-nvim",
			"bartekjaszczak/finale-nvim",
			"ellisonleao/gruvbox.nvim",
			"metalelf0/jellybeans-nvim",
			"lalitmee/cobalt2.nvim",
			"calind/selenized.nvim",
    },
    opts = {}
},
```
</details>

As you can see, this is an exatensive list of colorscheme from awesome-neovim [repo](https://github.com/rockerBOO/awesome-neovim), be sure to visit it for even more plugins beside of colorschemes.
## Known Issues

- Some colorschemes can have issues that I cannot control. Open a [Github issue](https://github.com/MrSloth-dev/42-NorminetteNvim/issues/new) so that I can look into it.


To report a bug or ask for a feature, please open a [Github issue](https://github.com/MrSloth-dev/42-NorminetteNvim/issues/new)
<br>

## Roadmap

- [x] Make the choosen colorscheme permanent through all sessions.
- [x] Get colorschemes from [awesome-neovim repo](https://github.com/rockerBOO/awesome-neovim)
- [ ] Temp install with [lazy.nvim](https://github.com/folke/lazy.nvim/) for quick preview and to remove dependecies in config.
- [ ] Improve performance and minimize errors
- [ ] Get multiple code snippets in different languages
- [ ] Create a file to be possible to costumize the themes (will be to do it manually).


## Changelog

All notable changes to this project will be documented in this file.

### [0.2] - 2024-11-18

### Added

- Now Colorscheme are persistent through all sessions using `vim.fn.stdpath("data")`
- New configuration that you can add all the colorschemes you want to experiment.
- New file theme_list.lua has all colorschemes and informations.

### Changed
- In README's config it was written `requires` instead of `dependencies`.

### [0.1] - 2024-11-14

### Added

- This is the first Version, it's working only with installed colorschemes.

## License
MIT
