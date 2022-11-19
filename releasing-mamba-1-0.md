Releasing mamba 1.0
The mamba package manager has been in the works for 3 years. Starting from the simple idea whether it’s possible to make conda faster to a proper, standalone package management tool that is used by the largest distributions in the conda & mamba ecosystem (conda-forge and bioconda). Today we are proud to announce that mamba is mature enough for a 1.0 release.
When we started the development of the mamba package manager, the conda-forge repository was already experiencing a major growth in the number of available package versions, and the existing “conda” package manager was unbearably slow for certain tasks. I was fuelled by the idea of publishing many robotics-related packages on conda-forge (specifically the ROS stack), but I realized that it would be difficult with the slowness of conda. Thankfully we tried to use the libsolv library to resolve package dependencies faster, and with a lot of support from the libsolv maintainers got an initial prototype pretty quickly!

Today, mamba is widely adopted by users across the PyData world and beyond, in CI systems or for quick deployments to the cloud (for example in the Jupyter/MyBinder projects).

Strong foundations in C++
Early on I decided to use C++ for the implementation of the critical parts of a speedy package management experience: C++ gives us a nice high-level interface (exposed in libmamba) and simple access to low-level C libraries ( libsolv, libarchive and libcurl are the main dependencies of mamba), and also — given that it is a compiled language — offers high performance for all operations.

Instead of making mamba a monolithic project, we decided to split it in smaller packages/parts for better flexibility and integration in downstream projects. libmamba is a standalone library for all basic features related to package mamagement. Thanks to pybind11, it provides really nice and easy-to-use Python bindings through libmambapy . mamba simply builds on top of libmambapy and adds the CLI interface.

We’re proud to say that one of the first serious users of libmambapy is the conda project; they are integrating with it to provide the same speedy package resolving experience from mamba in conda! We are looking forward to more use cases for libmamba & libmambapy in the future!

What’s new in the 1.0 release?

Most of our activity is currently focused on improving the micromamba experience. micromamba is an evolution of mamba that does not rely on Python or conda. It comes as a single binary which makes installation and boot-strapping very easy, and doesn’t require a base environment or a miniconda/miniforge installation.

It also has a largely conda-compatible CLI (with some small deviations).

The 1.0 release comes with improved shell scripts with autocompletion available in PowerShell, xonsh, fish, bash and zsh. Micromamba now also has a “shell” subcommand to enter a sub-shell without having to modify the system (just run micromamba shell -n someenv). And finally for the future, micromamba can now update itself with the micromamba self-update command.

You can find the full changelog here.

Try it now
We would love it if more people try micromamba and provide us with feedback. It’s easy to take micromamba for a spin:

provision-with-micromamba: use micromamba inside Github Actions to setup the CI environments quickly
micromamba-docker: use the small micromamba-docker image to build your containers with ease
micromamba-devcontainer: A general-purpose micromamba-enabled VS Code development container image — save the time and effort of configuring development tools for each project × collaborator × device.
micromamba on your local machine / in the cloud: run
curl micro.mamba.pm/install.sh | bash to install micromamba on your computer — after that it’s available with micromamba create -n myenv python -c conda-forge (we’re working on a simple installation for Windows. Until then follow the docs).
picomamba: mamba in the browser thanks to WASM (also take a look at emscripten-forge where we are crossing over WASM × conda-forge to build packages for mamba & the web)
We’re not stopping here!
There’s more we’re planning to add to mamba soon, including:

boa: faster package building using `libmamba` and a new recipe format. It’s a revolutionary approach on building packages that is much faster than conda-build and provides a much nicer experience. The stated goal is to make boa good enough so that conda-forge can start using it.
powerloader: we are working hard on the next “network”-backend for mamba with full support for multiple mirrors, resumable downloads, zchunk (delta-update) support and much more. The integration of powerloader into mamba is going to be another big milestone and one of the main goals for the first release post-1.0
OCI Mirror: part of the powerloader effort is to enable OCI registries as conda package mirrors. We are already operating a full mirror of the conda-forge repository on Github Packages. To make that mirror actually useful, we need to integrate powerloader into mamba.
Package signing: we want to investigate the integration of sigstore further to allow for simple package signing of conda packages — this will be even simpler when we use an OCI registry as sigstore supports those natively
Better error messages: the first couple of PRs have already landed that build the foundation of better solver messages when no dependency solution can be found. You can find some of the prototype work here: https://github.com/AntoinePrv/mamba-error-reporting/blob/main/examples.ipynb
And then there is more …
A teaser for prefix.dev
But wait — there’s more: we’re happy to announce that we’ve also started a new company called prefix.dev to move software package management and more forward! We’ll have more to share on that next week: if you want the latest news, you can follow me on Twitter.

Community

All the contributors for the 1.0 release!
We have recently begun to have “mamba meetings” every week on Monday 16:00 CET. Everybody is invited (users and maintainers alike). Here is the calendar link. We also have a little “Gitter” community now: https://gitter.im/mamba-org/Lobby

It is also really cool to see the mamba contributor community growing:

Claudia Rogoz from Palantir and Antoine Provoust at QuantStack are currently working hard on improving solver messages
Joel Lamotte and Johan Mabille of QuantStack have contributed many improvements to micromamba (and are currently focusing on the powerloader integration).
Jonas Haag from QuantCo has contributed countless improvements and is now a core maintainer with merge rights. Others at QuantCo have added fixes and improvements as well: thanks Pavel Zwerschke and Adrian Freund.
Jaime Rodríguez-Guerra from Quansight has worked on the conda ↔ libmamba integration for which he did a lot of testing and helped us uncover some corner cases. That helped to make mamba more stable.
Chris Burr from CERN has really improved the speed of micromamba’s linking phase
Thanks to all these wonderful contributions, mamba is as fast and stable as it is today.

About the author


Wolf Vollprecht is the creator of mamba, and a core contributor to the conda-forge project. He also organizes PackagingCon, the first conference for software package management.
