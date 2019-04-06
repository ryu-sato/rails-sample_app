# はじめに

Bundle gem アップロードのため tachikoma を導入している。

# 使い方

1. 環境変数を指定する
    ```
    $ export BUILD_FOR=rails-sample_app
    $ export TOKEN_RAILS_SAMPLE_APP=XXXX
    ```
1. tachikoma が一時的に gem をインストールする先のディレクトリを下記に設定して tachikoma gem を bundle install する。
    * ./vendor/bundle
1. tachikoma を実行する
    ```
    $ bundle exec rake tachikoma:run_bundler
    ```

