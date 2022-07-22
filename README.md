# isucon-template

Template repository for ISUCON

## ssh_config 設定

```sh
$ cat .ssh/config >> ~/.ssh/config
$ $EDIDOR ~/.ssh/config
```

## サーバー設定

```sh
$ make setup-servers
```

## アプリケーションのダウンロード

```sh
$ make download-app
```

## アプリケーションのデプロイ

```sh
$ make deploy-app
```

## nginx conf のダウンロード

```sh
$ make download-nginx
```

## nginx conf のデプロイ

```sh
$ make deploy-nginx
```

## MySQL conf のダウンロード

```sh
$ make download-mysql
```

## MySQL conf のデプロイ

```sh
$ make deploy-mysql
```
