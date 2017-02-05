# I don't wanna go there

## 概要

1日分の「会社や学校に行きたくない」ツイートを報告します。

## 動かす

* `lib/get_twilog.rake` を毎日動かすよう cron 等に設定しておきます。
上記スクリプトは以下業務を行います。
** 「行きたくないツイート」数の集計
** 集計結果を DB に INSERT
** 集計結果の報告 (@1d0ntwanna5 にツイート)
* Rails サーバーを起動し `index` にアクセスすると、 DB からデータを読み出して「行きたくないツイート」の日毎の遷移をグラフ化して表示します。
** 表示範囲は 1週間/1ヶ月/1年 から選べます。

## 動作環境

* Heroku (Ruby 1.9.3)

## 作成者

Tsubasa Ogawa (@tsubasaogawa on GitHub)
