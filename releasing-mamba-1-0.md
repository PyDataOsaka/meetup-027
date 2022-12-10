# Releasing mamba 1.0 の日本語訳

この記事は[Releasing mamba 1.0](https://wolfv.medium.com/releasing-mamba-1-0-8e3c52cc6d37)の日本語翻訳記事です。
typoや翻訳ミスを見つけましたら[こちらのリポジトリ](https://github.com/PyDataOsaka/meetup-027)のissueから報告いただくか、当該記事に対応したmdファイルに対してプルリクエストを発行していただければと思います。

---
<!-- # Releasing mamba 1.0 -->
# mamba 1.0のリリース 

![](https://miro.medium.com/max/720/0*_5teAY19rW39Xg1w)

<!-- The mamba package manager has been in the works for 3 years. -->
mambaパッケージマネージャは3年の間、開発が続けられてきました。
<!-- Starting from the simple idea whether it’s possible to make conda faster to a proper, standalone package management tool that is used by the largest distributions in the conda & mamba ecosystem (conda-forge and bioconda). -->
condaをより高速化することが可能かどうかという単純なアイデアから始まり、condaとmambaのエコシステムにおける最大のディストリビューション(conda-forgeとbioconda)で使用されることにふさわしいスタンドアローンのパッケージ管理ツールへと成長しました。
<!-- Today we are proud to announce that mamba is mature enough for a 1.0 release. -->
今日、私たちはmambaが1.0のリリースに十分なほど成熟したことを誇りを持ってアナウンスします。
<!-- When we started the development of the mamba package manager, the conda-forge repository was already experiencing a major growth in the number of available package versions, and the existing “conda” package manager was unbearably slow for certain tasks. -->
私たちがmambaパッケージマネージャの開発を開始した時、すでにconda-forgeリポジトリでは利用可能なパッケージのバージョンの数が急増しており、既存の"conda"パッケージマネージャーはある種のタスクに対しては我慢できないほど遅くなっていました。

<!-- I was fuelled by the idea of publishing many robotics-related packages on conda-forge (specifically the [ROS stack](https://github.com/robostack/ros-humble)), but I realized that it would be difficult with the slowness of conda. -->
私は多くのロボット関係のパッケージをconda-forge(特に[ROSスタック](https://github.com/robostack/ros-humble))に公開するという考えに燃えていましたが、私はそれがcondaの遅さによって困難となるであろうことに気付いていました。 
<!-- Thankfully we tried to use the `libsolv` library to resolve package dependencies faster, and with a lot of support from the `libsolv` maintainers got an initial prototype pretty quickly! -->
ありがたいことに、私たちはパッケージ依存性をより速く解決するために`libsolv`ライブラリを試用し、`libsolv`メンテナ達からの多くのサポートを受けて初期のプロトタイプをかなり迅速に作ることができました。

<!-- Today, mamba is widely adopted by users across the PyData world and beyond, in CI systems or for quick deployments to the cloud (for example in the Jupyter/MyBinder projects). -->
現在、mambaはPyDataの世界各地のユーザー、更にはCIシステムやクラウドへの迅速なデプロイ(例えばJupyter/MyBinderプロジェクト)において広く採用されています。

<!-- ## Strong foundations in C++ -->
## C++＋による強固な基盤

<!-- Early on I decided to use C++ for the implementation of the critical parts of a speedy package management experience: -->
早い段階で、私はC++を高速なパッケージ管理エクスペリエンスの重要な部分の実装に用いることを決めました。
<!-- C++ gives us a nice high-level interface (exposed in `libmamba`) and simple access to low-level C libraries ( `libsolv`, `libarchive` and `libcurl` are the main dependencies of mamba), and also — given that it is a compiled language — offers high performance for all operations. -->
C++は、洗練された高レベルの(`libmamba`でさらされる)インタフェース、そして低レベルなCライブラリ(`libsolv`、`libarchive`, `libcurl`がmambaの主な依存ライブラリです)へのシンプルなアクセスを我々に提供してくれます。また、C++は - コンパイル言語なので - 全ての操作に対して高いパフォーマンスを提供してくれます。

<!-- Instead of making mamba a monolithic project, we decided to split it in smaller packages/parts for better flexibility and integration in downstream projects. -->
mambaをモノシリックなプロジェクトにする代わりに、私たちはそれを柔軟により小さなパッケージや部品へと分解し、下流となるプロジェクトに統合すること決めました。
<!-- `libmamba` is a standalone library for all basic features related to package mamagement. -->
`libmamba`はパッケージ管理に関係する全ての基本機能に対するスタンドアローンなライブラリです。 
<!-- Thanks to `pybind11`, it provides really nice and easy-to-use Python bindings through `libmambapy` . -->
`pybind11`のおかげで、`libmamba`は`libmambapy`を介して実に洗練された使いやすいPythonバインディングを提供できています。
<!-- mamba simply builds on top of `libmambapy` and adds the CLI interface. -->
mambaはシンプルに`libmambapy`の上に構築され、CLIインタフェースを追加したものです。

<!-- We’re proud to say that one of the first serious users of `libmambapy` is the *conda* project; -->
私たちは`libmambapy`の最初の重大なユーザーの一つが*conda*プロジェクトであると誇りを持って言えます。
<!-- they are integrating with it to provide the same speedy package resolving experience from `mamba` in `conda`! -->
*conda*プロジェクトは`mamba`と同じ高速なパッケージ解決体験を提供するために(`libmambapy`を)`conda`に統合しています。
<!-- We are looking forward to more use cases for `libmamba` & `libmambapy` in the future! -->
私たちは将来的に`libmamba`と`libmambapy`に対するより多くのユースケースが出て来ることを楽しみにしています。

<!--## What’s new in the 1.0 release?-->
## バージョン1.0のリリースにおける新規変更点
![](https://miro.medium.com/max/720/1*-shrIKC2hsBdFx7ehnQUGw.png)

<!-- Most of our activity is currently focused on improving the `micromamba` experience. -->
現在、私たちの活動のほとんどは`micromamba`の体験の改善に重点が置かれています。
<!-- `micromamba` is an evolution of `mamba` that does not rely on Python or conda. -->
`micromamba`はPythonやcondaを必要としない`mamba`の進化版です。
<!-- It comes as a single binary which makes installation and *boot-strapping* very easy, and doesn’t require a base environment or a *miniconda/miniforge* installation. -->
シングルバイナリとして提供され、これによりインストールや*環境の立ち上げ*が非常に簡単になり、ベースとなる環境や*miniconda/miniforge*のインストールも必要としません。

<!-- It also has a largely conda-compatible CLI (with some small deviations). -->
また、(微妙な違いはあるものの)ほぼconda互換のCLIを持っています。

<!-- The 1.0 release comes with improved shell scripts with autocompletion available in PowerShell, xonsh, fish, bash and zsh. -->
バージョン1.0のリリースはPowerShell, xonsh, fish, bash, zshで利用可能な自動補完用のシェルスクリプトの改善版とともに提供されます。
<!-- Micromamba now also has a “shell” subcommand to enter a sub-shell without having to modify the system (just run `micromamba shell -n someenv`). -->
Micromambaは今やシステムの変更を伴わずにサブシェルに入るための"shell"サブコマンドも持っています(`micromamba shell -n someenv`と実行するだけです).

<!-- And finally for the future, micromamba can now update itself with the `micromamba self-update` command. -->
そして最後に将来のために、micromambaは今や自分自身を`micromamba self-update`コマンドで更新できるようになっています。

<!-- You can find [the full changelog here](https://github.com/mamba-org/mamba/releases/tag/2022.11.01). -->
[ここで完全なchangelog](https://github.com/mamba-org/mamba/releases/tag/2022.11.01)について確認することができます。

<!--## Try it now-->
## 今すぐ試そう
<!-- We would love it if more people try `micromamba` and provide us with feedback. It’s easy to take `micromamba` for a spin: -->
私たちはより多くの人が`micromamba`を試し、私たちにフィードバックをくださることを望んでいます。`micromamba`を試しに使ってみるのは簡単です。

<!-- - **[provision-with-micromamba](https://github.com/mamba-org/provision-with-micromamba):** use micromamba inside Github Actions to setup the CI environments quickly -->
- **[provision-with-micromamba](https://github.com/mamba-org/provision-with-micromamba):** これはmicromambaを使用して、GitHub Actionsの中でCI環境を素早くセットアップしてくれます。
<!-- - **[micromamba-docker](https://github.com/mamba-org/micromamba-docker):** use the small `micromamba-docker` image to build your containers with ease -->
- **[micromamba-docker](https://github.com/mamba-org/micromamba-docker):** これは小さな `micromamba-docker`イメージを使用して、コンテナーを簡単にビルドしてくれます。
<!-- - **[micromamba-devcontainer](https://github.com/mamba-org/micromamba-devcontainer):** A general-purpose micromamba-enabled VS Code development container image — save the time and effort of configuring development tools for each project × collaborator × device. -->
- **[micromamba-devcontainer](https://github.com/mamba-org/micromamba-devcontainer):** 一般的な目的のためのmicromambaが有効化されたVS Code開発用のコンテナイメージです。プロジェクト、コラボレータ、デバイスそれぞれに対して開発ツールを設定するための時間と労力を節約してくれます。
<!-- - **micromamba on your local machine / in the cloud:** run `curl micro.mamba.pm/install.sh | bash` to install micromamba on your computer — after that it’s available with `micromamba create -n myenv python -c conda-forge` (we’re working on a simple installation for Windows. Until then follow the docs). -->
- **ローカルマシン環境やクラウド環境におけるmicromamba:**  micromambaをコンピュータにインストールするために`curl micro.mamba.pm/install.sh | bash`を実行し、その後に`micromamba create -n myenv python -c conda-forge`を実行すると利用可能となります(私たちはWindowsに対するシンプルなインストール方法の実現にも取り組んでいます。その時が来るまではドキュメントに従ってください)。
<!-- - **[picomamba](https://github.com/mamba-org/picomamba):** mamba in the browser thanks to WASM (also take a look at [emscripten-forge](http://github.com/emscripten-forge/recipes) where we are crossing over WASM × conda-forge to build packages for mamba & the web) -->
- **[picomamba](https://github.com/mamba-org/picomamba):** WASMの力によってブラウザ上で動作するmambaです(mambaとwebのためのパッケージをビルドするためにWASMとconda-forgeを連携させている[emscripten-forge](http://github.com/emscripten-forge/recipes)についても確認してみてください)。

<!--## We’re not stopping here!-->
## 私たちはここで止まりません！
<!--There’s more we’re planning to add to mamba soon, including:-->
下記のようにmambaにすぐに追加する予定の機能が更にあります。

<!-- - **[boa](https://github.com/mamba-org/boa):** faster package building using `libmamba` and a new recipe format. It’s a revolutionary approach on building packages that is much faster than conda-build and provides a much nicer experience. The stated goal is to make `boa` good enough so that conda-forge can start using it. -->
- **[boa](https://github.com/mamba-org/boa):** 新しいレシピフォーマットと`libmamba`を使ったより高速なパッケージ構築ツールです。 conda-buildよりも更に速く更に良い体験を提供するパッケージビルドにおける革命的なアプローチです。その段階的な目標は、conda-forgeがそれを使い始めることができるように`boa`を十分に良くすることです。
<!-- - **[powerloader](https://github.com/mamba-org/powerloader):** we are working hard on the next “network”-backend for mamba with full support for multiple mirrors, resumable downloads, zchunk (delta-update) support and much more. The integration of powerloader into mamba is going to be another big milestone and one of the main goals for the first release post-1.0 -->
- **[powerloader](https://github.com/mamba-org/powerloader):** 私たちは複数のミラーや再開可能なダウンロード、zchunk(差分アップデート)サポートや、更に多くの機能を完全にサポートしたmambaのための次の"ネットワーク"バックエンドに熱心に取り組んでいます。powerloaderをmambaへと統合することはもう一つの大きなマイルストーンとなる予定であり、バージョン1.0以降の最初のリリースの主な目標の一つになります。
<!-- - **OCI Mirror:** part of the powerloader effort is to enable OCI registries as conda package mirrors. We are already operating a full mirror of the conda-forge repository on [Github Packages](https://github.com/orgs/channel-mirrors/packages). To make that mirror actually useful, we need to integrate powerloader into mamba. -->
- **OCI Mirror:** powerloaderの取り組みの一部は、OCIレジストリをcondaパッケージのミラーとして使えるようにすることです。私たちは既にconda-forgeリポジトリの完全なミラーを[GitHub Packages](https://github.com/orgs/channel-mirrors/packages)上で運用しています。このミラーを実際に役立つようにするために、私たちはpowerloaderをmambaに統合する必要があります。
<!-- - **Package signing:** we want to investigate the integration of `sigstore` further to allow for simple package signing of conda packages — this will be even simpler when we use an OCI registry as sigstore supports those natively -->
- **Package signing:** 私たちはcondaパッケージに対する簡単な署名を実現するために`sigstore`の統合を更に調査したいと考えています。sigstoreがOCIレジストリをネイティブにサポートしているため、OCIレジストリを使用すると、署名は更に簡単になります。
<!-- - **Better error messages:** the first couple of PRs have already landed that build the foundation of better solver messages when no dependency solution can be found. You can find some of the prototype work here: https://github.com/AntoinePrv/mamba-error-reporting/blob/main/examples.ipynb -->
- **Better error messages:** 依存関係の解決策が見つからない時に、より良いソルバーのメッセージの基盤を構築する最初の2つのプルリクエストが既に上がっています。プロトタイプ作業の一部は https://github.com/AntoinePrv/mamba-error-reporting/blob/main/examples.ipynb で確認できます。

<!--## And then there is more …-->
## そして更に…
![A teaser for prefix.dev](https://miro.medium.com/max/720/1*CxK4wBPLSREAP1aASyOIpg.png)

<!-- **But wait — there’s more:** -->
**しかし待ってください - 更に告げることがあります:**
<!-- we’re happy to announce that we’ve also started a new company called **prefix.dev** to move software package management and more forward! -->
私たちはソフトウェアパッケージ管理を更に前進させるために、**prefix.dev**という名前の新しい会社を既に起こしていることを喜んで告知いたします。
<!-- We’ll have more to share on that next week: if you want the latest news, you can [follow me on Twitter](https://twitter.com/wuoulf). -->
私たちは次週、多くのことを共有できるでしょう。もし最新のニュースが必要であれば、[私をTwitterでフォロー](https://twitter.com/wuoulf)してください。

<!--## Community -->
## コミュニティ

![All the contributors for the 1.0 release!](https://miro.medium.com/max/720/1*n7nCAoLn2mBJT9A83YPziw.png)

<!-- We have recently begun to have “mamba meetings” every week on Monday 16:00 CET. -->
私たちは最近"mambaミーティング"を毎週月曜日の16:00(CET)に始めました。
<!-- Everybody is invited (users and maintainers alike). -->
誰でも(ユーザやメンテナなど)参加が可能です。
<!-- [Here is the calendar link](https://calendar.google.com/calendar/u/0?cid=YWIzanJmcGVkZTBrcTB1YnNyb2U4MmNkMDBAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ). -->
[カレンダーのリンク](https://calendar.google.com/calendar/u/0?cid=YWIzanJmcGVkZTBrcTB1YnNyb2U4MmNkMDBAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ)がここにあります。
<!-- We also have a little “Gitter” community now: https://gitter.im/mamba-org/Lobby -->
また、私たちは小さな"Gitter"コミュニティも持っています: https://gitter.im/mamba-org/Lobby

<!-- It is also really cool to see the mamba contributor community growing: -->
mambaのコントリビュータコミュニティの発展を眺めることも非常にクールなことです:

<!-- - **Claudia Rogoz** from *Palantir* and **Antoine Provoust** at *QuantStack* are currently working hard on improving solver messages -->
- *Palantir*の**Claudia Rogoz**と*QuantStack*で働く**Antoine Provoust**は現在solverのメッセージの改善に熱心に取り組んでいます。
<!-- - **Joel Lamotte** and **Johan Mabille** of *QuantStack* have contributed many improvements to micromamba (and are currently focusing on the powerloader integration). -->
- *QuantStack*で働く**Joel Lamotte**と**Johan Mabille**はmicromambaに対する多くの改善点に貢献しています(現在powerloaderとの統合に注力しています)。
<!-- - **Jonas Haag** from *QuantCo* has contributed countless improvements and is now a core maintainer with merge rights. Others at *QuantCo* have added fixes and improvements as well: thanks Pavel Zwerschke and Adrian Freund. -->
- *QuantCo*で働く**Jonas Haag**は数えきれない改善に貢献してきており現在はマージ権を持つコアメンテナとなっています。*QuantCo*における他の人々も修正や改善を同様に追加してきていました: Pavel ZwerschkeとAdrian Freundに感謝します。
<!-- - **Jaime Rodríguez-Guerra** from *Quansight* has worked on the conda ↔ libmamba integration for which he did a lot of testing and helped us uncover some corner cases. That helped to make mamba more stable. -->
- *Quansight*で働く**Jaime Rodríguez-Guerra**は多くのテストを実行したりカバーされていなかったいくつかのコーナーケースを補助するといったconda↔libmamba間の統合に取り組んできました。それはmambaをより安定させる助けとなりました。
<!-- - **Chris Burr** from *CERN* has really improved the speed of micromamba’s linking phase -->
- *CERN*で働く**Chris Burr**はmicromambaのリンクフェーズにおける速度を劇的に改善しました。

<!-- Thanks to all these wonderful contributions, mamba is as fast and stable as it is today. -->
これら全ての素晴らしい貢献のおかげで、mambaは現在のように高速で安定したものとなっています。

<!--### About the author-->
### 著者について

![](https://miro.medium.com/max/300/1*JCUKBuHzM3XzKJkgeuEAUA.png)

<!-- Wolf Vollprecht is the creator of mamba, and a core contributor to the conda-forge project. -->
Wolf Vollprechtはmambaの作者であり、conda-forgeプロジェクトに対するコアコントリビュータです。
<!-- He also organizes PackagingCon, the first conference for software package management. -->
彼はまたソフトウェアパッケージ管理に関する初のカンファレンスである、PackagingConを主催しています。