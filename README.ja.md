# Docker Composeで学ぶ並列コンピューティングラボ:NumPyとmultiprocessingでGPUの考え方を理解する(GPUはありません)

[English](README.md) | [Français](README.fr.md) | [Español](README.es.md) | [日本語](README.ja.md) | [Deutsch](README.de.md)

[![check](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml/badge.svg)](https://github.com/mitsurutech/lab-parallel-lab/actions/workflows/check.yml)

[MitsuruTechラーニングプラットフォーム](https://mitsurutech.co.uk/learning)が提供する、授業でそのまま使えるラボです。このプラットフォームでは、学校、大学などの教育機関が、すべての学生に専用のデータベース、コンテナ、ターミナルをブラウザ上で提供しています。GPUの土台になっている考え方を、NumPy、Pythonのmultiprocessing、いくつかの小さなスクリプトで学ぶラボです。結果は毎回同じになります。ラボにGPUはありません。

`docker-compose` ファイルが1つ(`compose.yaml`)あるだけで、プラットフォーム上でも自分のマシンでも同じように動きます。プラットフォームでは、学生一人ひとりに専用のコピーが渡され、インターネットへの出口はありません。

## プラットフォームで使う

プラットフォームでは、学生一人ひとりにラボの専用コピーが、ブラウザ上でターミナル付きで渡されます。

**試すには:** [コンテナのページ](https://mitsurutech.co.uk/container)を開き、**Sample labs** の中からこのラボを見つけて Start を押します。無料アカウントが必要です。

**クラスの課題として設定するには:**

1. モジュールで、種類が **Lab** のタスクを作り、**In a GitHub repository** を選びます。
2. `https://github.com/mitsurutech/lab-parallel-lab` とブランチ `main` を指定します。compose ファイルは既定の `compose.yaml` です。変更したい場合は、先にこのリポジトリをフォークしてください。
3. 公開(Publish)します。学生のコピーは公開したコミットから始まるので、あとでここを変更しても、すでに出した課題のラボは変わりません。

ヘルプマニュアルの[このラボのページ](https://mitsurutech.co.uk/help/lab-parallel-lab)と[コンテナラボのガイド](https://mitsurutech.co.uk/help/labs)に、そのほかの内容があります。対応する基礎レッスンは **Parallel Computing Basics** です。まだ学校のアカウントがありませんか。[最初の1年間は無料](https://mitsurutech.co.uk/pricing)(学生50人まで)で、[サインアップ](https://mitsurutech.co.uk/signup)にはメールアドレスだけが必要です。

## 自分のマシンで動かす

Docker と Compose プラグインが必要です。

```bash
docker compose -f compose.yaml -f local.yaml up
```

<http://127.0.0.1:8888/lab> を開きます。`local.yaml` が公開するポートは `127.0.0.1` だけなので、ラボには自分のコンピュータからのみ接続でき、ほかからは届きません。ラボにはパスワードを求める仕組みがないので、ほかの人が接続できる場所では動かさないでください。止めるには `Ctrl-C` を押し、削除するには `docker compose -f compose.yaml -f local.yaml down -v` を実行します。

## ラボで動かないこと

ラボにはインターネットへの出口がないため、何かをインストールしたりダウンロードしたりすることはできません。**何も保存されません**。ラボを止めるとすべてのファイルが消えるので、学生は止める前に自分の作業をダウンロードしてください。`compose.yaml` の先頭のコメントに、このラボが何であり、何ではないかが書かれています。

## ラボを検証する

`test/check.sh` は、プラットフォームのランナーが各サービスを起動するのと同じ条件(すべての capability を外す、`no-new-privileges`、プロセス数の上限、メモリの上限、インターネットへの出口なし)でラボを起動し、compose ファイルが述べているとおりにラボが動くかを確かめます。Docker が必要で、プッシュのたびに実行されます。冒頭のバッジがその結果です。

```bash
test/check.sh
```

## ライセンス

この作品は [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) のもとで提供されています。学習と教育のために共有し、改変することができます。ただし、Mitsuru Technologies Ltd のクレジットを表示すること、商用に使わないこと、これをもとに作ったものを同じライセンスで共有することが条件です。全文は `LICENSE` ファイルにあります。

## このリポジトリについて

[Mitsuru Technologies](https://mitsurutech.co.uk) が [MitsuruTechラーニングプラットフォーム](https://mitsurutech.co.uk/learning)のために作りました。学校や大学向けに、Python、Java、Go、Node、SQL、Linux をブラウザ上で使え、コンテナラボ、GitHub からデプロイするWebアプリ、自動採点のクイズも備えています。アカウントなしでコードを試せる[プレイグラウンド](https://mitsurutech.co.uk/playground)もあります。

同じ提供元の、ほかのラボ: [lab-computer-vision](https://github.com/mitsurutech/lab-computer-vision)、[lab-frontend-web](https://github.com/mitsurutech/lab-frontend-web)、[lab-usability](https://github.com/mitsurutech/lab-usability)、[lab-mobile-web](https://github.com/mitsurutech/lab-mobile-web)、[lab-quantum-sim](https://github.com/mitsurutech/lab-quantum-sim)。
