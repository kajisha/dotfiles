[vim-surroundの使い方](http://4geek.net/how-to-use-vim-surround/)

# 「テキストを囲うもの」だけを削除もしくは変更する
| 元のテキスト                     | コマンド | 結果                              |
| This is 'a surrounded text'.     | ds'      | This is a surrounded text.        |
| This is (a surrounded text).     | ds(      | This is a surrounded text.        |
| This is <b>a surrounded text</b>.| dst      | This is a surrounded text.        |
| This is 'a surrounded text'.     | cs'"     | This is “a surrounded text”.      |
| This is 'a surrounded text'.     | cs'(     | This is ( a surrounded text ).    |
| This is 'a surrounded text'.     | cs')     | This is (a surrounded text).      |
| This is 'a surrounded text'.     | cs'<b>   | This is <b>a surrounded text</b>. | |

# 「囲われるテキスト」の選択と「テキストを囲う」操作を同時に行う
| 元のテキスト                | コマンド | 結果                             |
|This is 'a surrounded text'. | ysaw)    | This is ‘a (surrounded) text’.   |
|This is 'a surrounded text'. | ysaw(    | This is ‘a ( surrounded ) text’. |
|This is 'a surrounded text'. | ysi'(    | This is ‘( a surrounded text )’. |
|This is 'a surrounded text'. | ysa'(    | This is( ‘a surrounded text’ ).  |
