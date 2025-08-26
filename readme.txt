











■COPYコマンドのエラー検証

以下の処理をCMDにコピペして、ファイル(Bookmarks)をロックする。
　※適宜変数(TGT)を変更してロックファイル対象を修正すること

---↓ＣＭＤスクリプト↓---

set "TGT=C:\Users\fj3683hn\Documents\20250808_辞書登録情報とお気に入り情報のエクスポートインポートバッチ作成\20250826_profileHandoverKit\data\Bookmarks\chrome\Bookmarks"
set "SRC=%TEMP%\locktest_src.txt"
copy /Y "%TGT%" "%TGT%.bak"
echo TEST-DATA> "%SRC%"

start "LOCK_HOLDER" powershell -NoProfile -Command ^
  "$p='%TGT%';" ^
  "$fs=[System.IO.File]::Open($p,[System.IO.FileMode]::Open,[System.IO.FileAccess]::ReadWrite,[System.IO.FileShare]::None);" ^
  "Write-Host 'Locked in this window. Close it to release.';" ^
  "Start-Sleep -Seconds 99999"