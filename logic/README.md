
1/12時点
- `BFlogic_3.circ`: original (decoderのテスト済み)
- `BFlogic_4.circ`: `BFlogic_3.circ`のデコーダをまとめたもの

- `decoder_test`: デコーダのテストサンプル (全パターン網羅しているはず)


`BFlogic_3.circ`の外観

1. RAM (メモリ)
2. メモリのアドレスを保持するカウンタ
3. ALU (+1と-1をする)
4. ROM (プログラムが格納される)
5. RAM (Stack Pointerを格納する。要するに `[` のアドレスを保持するもの)
6. クロック発振器
7. skipフラグ ( `[]`内を無視するべきか)
8. デコーダ
9. アウトプットの表示

![](imgs/logic4_anot.png)
