# Tang Nano 9K Board

## ボードを作ろうとした目的
Tang Nano 9Kのテストをするとき、入出力用の回路を毎回組むのは面倒なので、Tang Nano 9Kを差し込むだけでそれらの機能が使えるようなボードを作成することにした。

## どんな回路図を設計したか

[![Image from Gyazo](https://i.gyazo.com/690e560d462d991d84030a6d0e54056e.png)](https://gyazo.com/690e560d462d991d84030a6d0e54056e)

必要な部品の一覧は下の表に示す。


| 部品                                        | 目的                                                            | 個数 | 
| ------------------------------------------- | --------------------------------------------------------------- | ---- | 
| Tang Nano 9K                                | FPGA本体                                                        | 1    | 
| 3to8 ラインデコーダー TC74HC138AP            | マトリクスLEDの入力を節約するため                               | 1    | 
| 8chDMOSトランジスターアレイ TBD62786APG<br> | マトリクスLEDの電流増幅用                                       | 1    | 
| カーボン抵抗(炭素皮膜抵抗) 1/4W750Ω        | マトリクスLEDの抵抗                                             | 1    | 
| OSL641501-BRA (8x8マトリクスLED (赤))       | デバッグ用                                                      | 1    | 
| 表面実装用タクトスイッチ TS-06104           | デバッグ用の入力                                                | 3    | 
| DIPスイッチ 8P                              | デバッグ用の入力                                                | 1    | 
| 分割ロングピンソケット 1×42 (42P)           | Tang Nano 9Kを使い回せるようにするため、GPIOピンを設置するため | 3    | 


### 1. マトリクスLED制御回路
[![Image from Gyazo](https://i.gyazo.com/099b2a6294d3a8672e492422bf363784.png)](https://gyazo.com/099b2a6294d3a8672e492422bf363784)

#### マトリクスLED導入の目的
テスト時に少ないピンを用いて、大量の情報を出力するために導入した。
3to8デコーダを介することでマトリクスの行側を3ピンで制御し、列側はTang Nano 9Kに直接制御している。

#### 経緯

### 2. 入力回路

[![Image from Gyazo](https://i.gyazo.com/0dc8c839f610943cc8e21011ae14ea30.png)](https://gyazo.com/0dc8c839f610943cc8e21011ae14ea30)

3つのプッシュスイッチと1つのDIPスイッチを採用した。

DIPスイッチはFPGAボードのPIN79~86に接続している。これらは1.8Vラインなので出力よりも入力に使うほうが良いと考えた。

### 3. 補助ピン

[![Image from Gyazo](https://i.gyazo.com/b01b54d2660cc22070691a9441de0be3.png)](https://gyazo.com/b01b54d2660cc22070691a9441de0be3)

デバッグ用にブレッドボードのようなピンソケットを配置した。1つはGNDと接地させた。

### 4. USBシリアル変換モジュール

[![Image from Gyazo](https://i.gyazo.com/7672853f759d83c9fda6044569fee36b.png)](https://gyazo.com/7672853f759d83c9fda6044569fee36b)

FPGAにファームウェアを書き込むためのラインを用意した。これは、Windowsを使うときに、Windows本体とWSLでI/Oを共有できないときに役に立つ。今時点ではTang Nano 9KのUSB-Cポート1つで十分なので、実装できるようにピンだけ用意しておき、必要になったときに変換モジュールを差し込むようにする。

## どうやってPCB基板を作成したか

[![Image from Gyazo](https://i.gyazo.com/9a5765c7ac94786c0c2ea93e7b5212e1.png)](https://gyazo.com/9a5765c7ac94786c0c2ea93e7b5212e1)

考えること
- 配線は短くする
- 配線は直角に曲げない
- 高電流が流れるところは太い配線を採用する
- 配線はできるだけ表面で完結させる


[![Image from Gyazo](https://i.gyazo.com/f447a7e7db34e89791d57ae22c1e2e25.png)](https://gyazo.com/f447a7e7db34e89791d57ae22c1e2e25)
## 発注までのプロセス

JLCPCBを選択した。100x100を5枚の発注であれば送料が1ドルと破格の安さなので。
