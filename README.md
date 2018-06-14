# FileManageScripts

## English Description
A collection of bash scripts for managing files

### sortout_download.sh
When you use Safari to download a file more than one time, you will see files,such as note.md, note-2.md, note-3.md and more, in Download directory. This script is used to remove older version of files, and keep the latest version. For example, if there are files note.md, note-2, ..., note-9.md in the directory. After running this script, note.md, note-2.md, ... note-8.md are removed, and note-9.md is renamed to note.md.

This script currently only support those files with filename extension 'md', because I only use it to process the files download from hackmd.io.

## 中文說明
這是管理檔案的bash script工具箱

### sortout_download.sh
當你用Safari下載同一個檔案多次，你會看到Download資料夾出現像 note.md、note-2.md、note-3.md、⋯ 這樣的檔名。這個script是用來刪除舊版的檔案，並只保留最新版本。舉例來說，如果目錄有 note.md、note-2.md、⋯  note-9.md 這些檔案。在執行script後，note.md、note-2、⋯  note-8.md都會被刪除，並且note-9.md被改名為note.md。

目前這個script只支援副檔名為md的檔案，因為我只用來處理hackmd.io下載的檔案。
