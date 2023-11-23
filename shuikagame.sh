#!/bin/bash

# フルーツの絵文字
fruits=("🍒" "🍓" "🍇" "🍊" "🦪" "🍎" "🍐" "🍑" "🍍" "🍈" "🍉")

# 連想配列の宣言
declare -a field

# ゲームフィールド配列の初期化
for i in {1..20}; do
    for j in {1..20}; do
        index=$((i * 100 + j))
        field[index]="　"
    done
done

# カーソルの位置
cursor=10

# ゲームフィールドの表示
function display_field() {
    clear
    echo "┌────────────────────────────────────────┐"
    for i in {1..20}; do
        row="|"
        for j in {1..20}; do
            index=$((i * 100 + j))
            pixel=${field[index]}
            row+=$pixel
        done
        row+="|"
        echo "$row"
    done
    echo "└────────────────────────────────────────┘"
    echo "Current Fruit: ${fruits[1]}"
    echo "Move Cursor: [s] Left, [d] Right"
    echo "Drop Fruit: Space or Enter"
    echo "Circle of Evolution: ${fruits[1]} → ${fruits[2]} → ${fruits[3]} → ${fruits[4]} → ${fruits[5]} → ${fruits[6]} → ${fruits[7]} → ${fruits[8]} → ${fruits[9]} → ${fruits[10]}"
}

# フルーツの落下
function drop_fruit() {
    local x=$(cursor + 1)
    local y=0
    while [[ $y -lt 19 ]]; do
        index=$((i * 100 + j))
        pixel=${field[index]}
        if pixel != "　"; then
            break
        fi
        ((y++))
        field[index]=$fruits[1]
        display_field
    done
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
