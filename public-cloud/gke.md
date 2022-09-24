### 目的
開発・検証用に GKE をセットアップ するためのメモ
あくまで検証なので 24/365 で起動する必要はない

### GKE の料金
https://cloud.google.com/kubernetes-engine/pricing

### 作成するクラスタ

大体こんな感じのクラスタ

* ノード数 => 3
* zonal/regional => zonal
* Series => n1-standard-1
* Machine Class => Preemptible
* Datacenter => Tokyo (すぐ消す前提で)
* workload identity => 基本的に利用する
* 限定公開クラスタ => その時々で

### クラスタ作成

#### 事前作業？
念の為、[予算アラート](https://cloud.google.com/billing/docs/how-to/budgets?hl=ja&visit_id=637490811924542617-2354298847&rd=1)を設定しておくとよいのか？

#### コマンド実行
gcloud はあらかじめセットアップしておく

https://cloud.google.com/compute/docs/regions-zones?hl=ja

```
$ gcloud container clusters create <cluster name> \
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


[限定公開クラスタ](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters?hl=ja#auto_subnet)の場合、

```
gcloud container clusters create <cluster name> \
--create-subnetwork name=<subnet name> \
--enable-master-authorized-networks \
--enable-ip-alias \
--enable-private-nodes \
--master-ipv4-cidr=172.16.16.0/28 \
--preemptible \
--num-nodes 3 \
--machine-type n1-standard-1 \
--zone asia-northeast1-b \
--workload-pool <project-id>.svc.id.goog \
--master-authorized-networks <cidr>
```
master-ipv4-cidr の範囲に関しては以下を参考に
https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips?hl=ja#internal_ip_addresses

カスタムサブネットを利用する場合は以下を参考に
https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters?hl=ja#custom_subnet

subnet を自動作成する場合は、network は default が使われている




限定公開クラスタの Node からはインターネットにアクセスできないため必要なら Cloud Nat を構成する

基本的には以下のドキュメントを参考にすればよい
https://cloud.google.com/nat/docs/gke-example

```
// e.g.
// Router
gcloud compute routers create nat-router \
    --network default \
    --region asia-northeast1

// NAT
// IP は自動割り当ての場合
gcloud compute routers nats create nat-config \
    --router-region asia-northeast1 \
    --router nat-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips

// IP は静的割り当ての場合
gcloud compute addresses create nat-static-ip-001 --region=asia-northeast1
gcloud compute routers nats create nat-config \
    --router-region asia-northeast1 \
    --router nat-router \
    --nat-all-subnet-ip-ranges \
    --nat-external-ip-pool=nat-static-ip-001
```

```
kubecl run curl --image curlimages/curl -i -t --rm -- /bin/curl httpbin.org/ip
```

参考：
https://www.kujilabo.com/posts/2021/11/gke_004


限定公開クラスタでは、admission webhook の通信を許可するための Firewall 追加が必要な場合がある

参考：
https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#add_firewall_rules


限定公開クラスタのノードに SSH をしたいときは IAP (Identity Aware Proxy) を利用するとよい (上述のCloud NATのドキュメントにもでてきている)
https://cloud.google.com/iap/docs/concepts-overview?hl=ja

### 必要なくなったら削除する

```
// NAT
gcloud compute routers nats delete nat-config --router=nat-router --region asia-northeast1

// Router
 gcloud compute routers delete nat-router --region asia-northeast1

// IP
gcloud compute addresses delete nat-static-ip-001 --region=asia-northeast1

// GKE
$ gcloud container clusters delete <cluster name> --zone asia-northeast1-b
```
### その他

[GCP コスト計算ツール](https://cloud.google.com/products/calculator?hl=ja)
