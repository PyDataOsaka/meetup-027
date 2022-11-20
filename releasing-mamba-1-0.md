# Releasing mamba 1.0

<!-- The mamba package manager has been in the works for 3 years. -->
日本語訳
<!-- Starting from the simple idea whether it’s possible to make conda faster to a proper, standalone package management tool that is used by the largest distributions in the conda & mamba ecosystem (conda-forge and bioconda). -->
日本語訳
<!-- Today we are proud to announce that mamba is mature enough for a 1.0 release. -->
日本語訳
<!-- When we started the development of the mamba package manager, the conda-forge repository was already experiencing a major growth in the number of available package versions, and the existing “conda” package manager was unbearably slow for certain tasks. -->
日本語訳
<!-- I was fuelled by the idea of publishing many robotics-related packages on conda-forge (specifically the [ROS stack](https://github.com/robostack/ros-humble)), but I realized that it would be difficult with the slowness of conda. -->
日本語訳
<!-- Thankfully we tried to use the `libsolv` library to resolve package dependencies faster, and with a lot of support from the `libsolv` maintainers got an initial prototype pretty quickly! -->
日本語訳

<!-- Today, mamba is widely adopted by users across the PyData world and beyond, in CI systems or for quick deployments to the cloud (for example in the Jupyter/MyBinder projects). -->
日本語訳

## Strong foundations in C++

<!-- Early on I decided to use C++ for the implementation of the critical parts of a speedy package management experience: -->
日本語訳
<!-- C++ gives us a nice high-level interface (exposed in `libmamba`) and simple access to low-level C libraries ( `libsolv`, `libarchive` and `libcurl` are the main dependencies of mamba), and also — given that it is a compiled language — offers high performance for all operations. -->
日本語訳

<!-- Instead of making mamba a monolithic project, we decided to split it in smaller packages/parts for better flexibility and integration in downstream projects. -->
日本語訳
<!-- `libmamba` is a standalone library for all basic features related to package mamagement. -->
日本語訳
<!-- Thanks to `pybind11`, it provides really nice and easy-to-use Python bindings through `libmambapy` . -->
日本語訳
<!-- mamba simply builds on top of `libmambapy` and adds the CLI interface. -->
日本語訳

<!-- We’re proud to say that one of the first serious users of `libmambapy` is the *conda* project; -->
日本語訳
<!-- they are integrating with it to provide the same speedy package resolving experience from `mamba` in `conda`! -->
日本語訳
<!-- We are looking forward to more use cases for `libmamba` & `libmambapy` in the future! -->
日本語訳

## What’s new in the 1.0 release?

<!-- Most of our activity is currently focused on improving the `micromamba` experience. -->
日本語訳
<!-- `micromamba` is an evolution of `mamba` that does not rely on Python or conda. -->
日本語訳
<!-- It comes as a single binary which makes installation and *boot-strapping* very easy, and doesn’t require a base environment or a *miniconda/miniforge* installation. -->
日本語訳

<!-- It also has a largely conda-compatible CLI (with some small deviations). -->
日本語訳

<!-- The 1.0 release comes with improved shell scripts with autocompletion available in PowerShell, xonsh, fish, bash and zsh. -->
日本語訳
<!-- Micromamba now also has a “shell” subcommand to enter a sub-shell without having to modify the system (just run `micromamba shell -n someenv`). -->
日本語訳
<!-- And finally for the future, micromamba can now update itself with the `micromamba self-update` command. -->
日本語訳

<!-- You can find [the full changelog here](https://github.com/mamba-org/mamba/releases/tag/2022.11.01). -->
日本語訳

## Try it now
<!-- We would love it if more people try `micromamba` and provide us with feedback. It’s easy to take `micromamba` for a spin: -->
日本語訳

<!-- - **[provision-with-micromamba](https://github.com/mamba-org/provision-with-micromamba):** use micromamba inside Github Actions to setup the CI environments quickly -->
- **[provision-with-micromamba](https://github.com/mamba-org/provision-with-micromamba):** 日本語訳
<!-- - **[micromamba-docker](https://github.com/mamba-org/micromamba-docker):** use the small `micromamba-docker` image to build your containers with ease -->
- **[micromamba-docker](https://github.com/mamba-org/micromamba-docker):** 日本語訳
<!-- - **[micromamba-devcontainer](https://github.com/mamba-org/micromamba-devcontainer):** A general-purpose micromamba-enabled VS Code development container image — save the time and effort of configuring development tools for each project × collaborator × device. -->
- **[micromamba-devcontainer](https://github.com/mamba-org/micromamba-devcontainer):** 日本語訳
<!-- - **micromamba on your local machine / in the cloud:** run curl micro.mamba.pm/install.sh | bash to install micromamba on your computer — after that it’s available with micromamba create -n myenv python -c conda-forge (we’re working on a simple installation for Windows. Until then follow the docs). -->
- **micromamba on your local machine / in the cloud:** 日本語訳
<!-- - **[picomamba](https://github.com/mamba-org/picomamba):** mamba in the browser thanks to WASM (also take a look at [emscripten-forge](http://github.com/emscripten-forge/recipes) where we are crossing over WASM × conda-forge to build packages for mamba & the web) -->
- **[picomamba](https://github.com/mamba-org/picomamba):** 日本語訳

## We’re not stopping here!
There’s more we’re planning to add to mamba soon, including:

<!-- - **[boa](https://github.com/mamba-org/boa):** faster package building using `libmamba` and a new recipe format. It’s a revolutionary approach on building packages that is much faster than conda-build and provides a much nicer experience. The stated goal is to make `boa` good enough so that conda-forge can start using it. -->
- **[boa](https://github.com/mamba-org/boa):** 日本語訳
<!-- - **[powerloader](https://github.com/mamba-org/powerloader):** we are working hard on the next “network”-backend for mamba with full support for multiple mirrors, resumable downloads, zchunk (delta-update) support and much more. The integration of powerloader into mamba is going to be another big milestone and one of the main goals for the first release post-1.0 -->
- **[powerloader](https://github.com/mamba-org/powerloader):** 日本語訳
<!-- - **OCI Mirror:** part of the powerloader effort is to enable OCI registries as conda package mirrors. We are already operating a full mirror of the conda-forge repository on [Github Packages](https://github.com/orgs/channel-mirrors/packages). To make that mirror actually useful, we need to integrate powerloader into mamba. -->
- **OCI Mirror:** 日本語訳
<!-- - **Package signing:** we want to investigate the integration of `sigstore` further to allow for simple package signing of conda packages — this will be even simpler when we use an OCI registry as sigstore supports those natively -->
- **Package signing:** 日本語訳
<!-- - **Better error messages:** the first couple of PRs have already landed that build the foundation of better solver messages when no dependency solution can be found. You can find some of the prototype work here: https://github.com/AntoinePrv/mamba-error-reporting/blob/main/examples.ipynb -->
- **Better error messages:** 日本語訳

## And then there is more …
A teaser for prefix.dev

<!-- **But wait — there’s more:** -->
日本語訳
<!-- we’re happy to announce that we’ve also started a new company called **prefix.dev** to move software package management and more forward! -->
日本語訳
<!-- We’ll have more to share on that next week: if you want the latest news, you can [follow me on Twitter](https://twitter.com/wuoulf). -->
日本語訳

## Community

All the contributors for the 1.0 release!

<!-- We have recently begun to have “mamba meetings” every week on Monday 16:00 CET. -->
日本語訳
<!-- Everybody is invited (users and maintainers alike). -->
日本語訳
<!-- [Here is the calendar link](https://calendar.google.com/calendar/u/0?cid=YWIzanJmcGVkZTBrcTB1YnNyb2U4MmNkMDBAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ). -->
日本語訳
<!-- We also have a little “Gitter” community now: https://gitter.im/mamba-org/Lobby -->
日本語訳

<!-- It is also really cool to see the mamba contributor community growing: -->
日本語訳

<!-- - **Claudia Rogoz** from *Palantir* and **Antoine Provoust** at *QuantStack* are currently working hard on improving solver messages -->
- **Claudia Rogoz** from *Palantir* and **Antoine Provoust** at *QuantStack* 日本語訳
<!-- - **Joel Lamotte** and **Johan Mabille** of *QuantStack* have contributed many improvements to micromamba (and are currently focusing on the powerloader integration). -->
- **Joel Lamotte** and **Johan Mabille** of *QuantStack* 日本語訳
<!-- - **Jonas Haag** from *QuantCo* has contributed countless improvements and is now a core maintainer with merge rights. Others at *QuantCo* have added fixes and improvements as well: thanks Pavel Zwerschke and Adrian Freund. -->
- **Jonas Haag** from *QuantCo* 日本語訳
<!-- - **Jaime Rodríguez-Guerra** from *Quansight* has worked on the conda ↔ libmamba integration for which he did a lot of testing and helped us uncover some corner cases. That helped to make mamba more stable. -->
- **Jaime Rodríguez-Guerra** from *Quansight* 日本語訳
<!-- - **Chris Burr** from *CERN* has really improved the speed of micromamba’s linking phase -->
- **Chris Burr** from *CERN* 日本語訳

<!-- Thanks to all these wonderful contributions, mamba is as fast and stable as it is today. -->
日本語訳

### About the author

<!-- Wolf Vollprecht is the creator of mamba, and a core contributor to the conda-forge project. -->
日本語訳
<!-- He also organizes PackagingCon, the first conference for software package management. -->
日本語訳
