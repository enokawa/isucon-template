# Snippets

## alp 

### 基本

```sh
alp json < /var/log/nginx/access.log
```

### 不特定多数の URI へのリクエストを纏める

```sh
alp json \
--sort sum -r \
-m "/posts/[0-9]+,/@\w+,/image/\d+" \
-o count,method,uri,min,avg,max,sum \
< /var/log/nginx/access.log
```

- `-m "/posts/[0-9]+,/@\w+,/image/\d+"`
  - `/posts/` , `/@username` , `/image/` は不特定多数の URI へのリクエストがあるため纏める

## nginx

### ログフォーマットの JSON 化

```conf
http {
  log_format json escape=json '{"time":"$time_local",'
                                  '"host":"$remote_addr",'
                                  '"forwardedfor":"$http_x_forwarded_for",'
                                  '"req":"$request",'
                                  '"status":"$status",'
                                  '"method":"$request_method",'
                                  '"uri":"$request_uri",'
                                  '"body_bytes":$body_bytes_sent,'
                                  '"referer":"$http_referer",'
                                  '"ua":"$http_user_agent",'
                                  '"request_time":$request_time,'
                                  '"cache":"$upstream_http_x_cache",'
                                  '"runtime":"$upstream_http_x_runtime",'
                                  '"response_time":"$upstream_response_time",'
                                  '"vhost":"$host"}';

  access_log  /var/log/nginx/access.log  json;
}
```

### 静的ファイルを nginx で配信する

```conf
server {
  location ~ ^/(favicon\.ico|css/|js/|img/) {
    root /home/isucon/private_isu/webapp/public/;
    expires 1d;
  }
}
```

- `favicon.ico`, `css/`, `js/` , `img/` 配下のリクエストを nginx で受ける
- `expires 1d` でクライアントに 1 日キャッシュさせる

### 特定のファイルが存在しない場合に　app Server にリクエストを割り振る

```sh
server {
  location /image/ {
    root /home/isucon/private_isu/webapp/public/;
    expires 1d;
    try_files $uri @app
  }

  location @app {
    internal;
    proxy_pass http://localhost:8080;
  }  
}
```

- `/image/` 配下にファイルが存在したらキャッシュして nginx から返す
- `/image/` 配下にファイルが存在しなかったら `@app` にリクエストを割り振る

## MySQL

### 接続方法

```sh
mysql -u isucon -pisucon -D isucondition
```

- `-u`: ユーザー名
- `-p`: パスワード
- `-D`: DB 名

### Slow query ログ出力設定

```
slow_query_log = 1
slow_query_log_file = /var/log/mysql/mariadb-slow.log
long_query_time = 0
```

### INDEX

```SQL
ALTER TABLE `isu_condition` ADD INDEX `jia_isu_uuid_idx` (jia_isu_uuid);

ALTER TABLE `isu_condition` ADD INDEX `jia_isu_uuid_idx` (jia_isu_uuid, timestamp DESC);

ALTER TABLE `isu_condition` DROP INDEX `jia_isu_uuid_idx`;
```