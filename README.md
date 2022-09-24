# 開発環境
自分用メモ
## 言語環境
言語環境構築は `anyenv` によって、*env 環境をインストールする方法にできるだけ統一する

### anyenv
以下参照  
https://github.com/anyenv/anyenv

### Java

JDK の種類は沢山あるが以下の記事を参考に `Adopt JDK`を利用する  
https://www.slideshare.net/TakahiroYamada3/how-to-choose-jdk-20191101
https://qiita.com/yamadamn/items/2dd26a014791b9557199

インストール    
https://adoptopenjdk.net/installation.html

```
$ /usr/libexec/java_home
/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

$ java -version
openjdk version "11.0.9.1" 2020-11-04
OpenJDK Runtime Environment AdoptOpenJDK (build 11.0.9.1+1)
OpenJDK 64-Bit Server VM AdoptOpenJDK (build 11.0.9.1+1, mixed mode)
```

## Editor
基本的に `VSCode` がメイン

### VSCode
https://code.visualstudio.com/

最低これだけは利用する Extention (2022/09)
* Cuelang
* Docker
* Emacs Friendly Keymap
* ESLint
* GitLens
* Go
* HashiCorp Terraform
* IntelliCode
* Kubernetes
* Path Intellisense
* Prettier
* Remote Development
* vscode-ghq
* YAML
* zenkaku

## ソースコード管理

### GHQ
golang の `go get` のようなディレクトリ構造で githubからcloneしてくる.

ローカルマシンでのソースコード管理はこのツールを利用して行う

https://github.com/x-motemen/ghq

## コンテナ環境

### Docker

https://docs.docker.com/install/

* Docker for Mac
* docker-ce (Linux)

### Kubernetes

https://kubernetes.io/ja/docs/setup/

基本的に、
* 学習・検証するとき => Minikube (主に)、kind (たまに) を利用
* Public Cloud で何かしたいとき => GKE
* たまに kubeadm でクラスタ構築

## サーバ環境構築
### GCP
TBD
### AWS
TBD
