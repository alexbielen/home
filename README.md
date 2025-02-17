# Home 🏠

_"Home is where the configuration is..."_

Home is a Nix-based declarative system configuration for MacOS using `nix`, `nix-darwin`, and `home-manager`. 

The motiviation is to have as many things as possible about my setup configured declaratively in code. 

## Setup

These instructions assume you are installing on a new MacOS machine with Apple silicon. As of February 2025, I am running this on an Mac Mini with M4 chips.

### Install Nix

I used the [Determinate Nix GUI installer](https://docs.determinate.systems/getting-started/individuals/#install) to install nix. 

To test that `nix` is installed run the following: 

``` bash
> nix --version
nix (Nix) 2.24.12
```

# Setup `~/.config` directory

If `~/.config` doesn't exist then create it. 

Next, clone this repo into `~/.config` 

``` bash
> cd ~/.config 
> git clone https://github.com/alexbielen/home nix-darwin-config
```

### Run `nix-darwin` 

You'll first want to change to the `nix-darwin-config` directory which should look like this:

``` bash
.
├── README.md
├── application-config
├── flake.lock
└── flake.nix
```

In `flake.nix` you'll find a block that looks like the following:

```nix
    let
      user = "alexbielen";
      host = "Alexs-Mac-mini";
```

You can update these to whatever is relevant. 

Then run the following: 

```bash
> darwin-rebuild switch flake -- .
```

The first run of this should take some time.    









