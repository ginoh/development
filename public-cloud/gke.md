### 目的
開発・検証用に GKE をセットアップ するためのメモ
あくまで検証なので 24/365 で起動する必要はまったくない

### GKE の料金
https://cloud.google.com/kubernetes-engine/pricing

### 作成するクラスタについて

* ノード数 => 3
* zonal/regional => zonal
* Series => n1-standard-1
* Machine Class => Preemptible
* Datacenter => Tokyo
* workload identity を設定しておく

### クラスタ作成

#### 事前に
念の為、[予算アラート](https://cloud.google.com/billing/docs/how-to/budgets?hl=ja&visit_id=637490811924542617-2354298847&rd=1)を設定しておくとよい？

#### コマンド実行
gcloud はあらかじめセットアップしておく

```
$ gcloud container cluster create <cluster name> \
--preemptible \
--num-nodes 3 \
--machine-type n1-standard-1 \
--zone asia-northeast1-b \
--workload-pool <project-id>.svc.id.goog \
--enable-master-authorized-networks \
--master-authorized-networks <cidr>
```

参考：

* [プリエンプティブル VM を含むクラスタまたはノードプールを作成する](https://cloud.google.com/kubernetes-engine/docs/how-to/preemptible-vms?hl=ja#create)
* [Workload Identity の使用](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)
* [コントロール プレーン アクセス用の承認済みネットワークの追加](https://cloud.google.com/kubernetes-engine/docs/how-to/authorized-networks?hl=ja)

### 必要なくなったら削除する

```
$ gcloud container cluster delete <cluster name> --zone asia-northeast1
```


### 参考

[GCP コスト計算ツール](https://cloud.google.com/products/calculator?hl=ja)
