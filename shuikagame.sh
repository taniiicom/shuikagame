#!/bin/zsh

# フルーツの絵文字
fruits=("🍒" "🍓" "🍇" "🍊" "🦪" "🍎" "🍐" "🍑" "🍍" "🍈" "🍉")

# ゲームフィールドの初期化
field=()
for (( i = 0; i < 20; i++ )); do
    row=()
    for (( j = 0; j < 20; j++ )); do
        row+=( " " )
    done
    field+=("${(j:,:)row}")
done

# カーソルの位置
cursor=10

# ゲームフィールドの表示
function display_field() {
    clear
    for row in "${field[@]}"; do
        echo "$row"
    done
    echo "Current Fruit: ${fruits[1]}"
    echo "Move Cursor: [s] Left, [d] Right"
    echo "Drop Fruit: Space or Enter"
}

# フルーツの落下
function drop_fruit() {
    local x=$cursor
    local y=0
    while [[ $y -lt 19 && "${field[$y + 1][$x]}" == " " ]]; do
        ((y++))
    done
    field[$y]=$cursor:🍒
}

# ゲームループ
while true; do
    display_field
    read -s -n1 key
    case "$key" in
        $'s') ((cursor = cursor > 0 ? cursor - 1 : cursor));;
        $'d') ((cursor = cursor < 19 ? cursor + 1 : cursor));;
        $'\n' | " ") drop_fruit;;
    esac
done

