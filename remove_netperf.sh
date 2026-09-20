#!/bin/bash

echo "============================================================"
echo "          🚨 netperf 관련 모든 정보 완전 삭제 시작"
echo "============================================================"

# 1. 로컬 실행 파일 삭제
if [ -f "$HOME/bin/network-tools/netperf" ]; then
    rm -f "$HOME/bin/network-tools/netperf"
    echo " ✅ 로컬 실행 파일 삭제 완료 (~/bin/network-tools/netperf)"
else
    echo " ℹ️ 삭제할 로컬 netperf 파일이 없습니다."
fi

# 2. 매뉴얼(manual) 파일에서 6번 항목(netperf) 관련 내용 자동 도려내기
MANUAL_FILE="$HOME/bin/network-tools/manual"
if [ -f "$MANUAL_FILE" ]; then
    # 6번 항목 시작부터 구분선까지의 내용을 삭제하는 sed 매직 스크립트
    sed -i '' '/6️⃣/,/------------------------------------------------------------/d' "$MANUAL_FILE" 2>/dev/null
    # 요약 부분에 명시된 단어 삭제
    sed -i '' '/netperf/d' "$MANUAL_FILE" 2>/dev/null
    echo " ✅ 터미널 매뉴얼(manual) 내 netperf 안내 항목 제거 완료"
else
    echo " ℹ️ 수정할 매뉴얼 파일이 없습니다."
fi

# 3. 깃허브(GitHub) 원격 저장소에서도 netperf를 완전히 삭제하기 위한 커밋 및 푸시
cd "$HOME/bin/network-tools" 2>/dev/null
if [ -d ".git" ]; then
    # 깃 추적에서 netperf 파일을 제거
    git rm netperf --cached 2>/dev/null
    git add .
    git commit -m "Clean up: netperf 명령어 및 매뉴얼 항목 완전 제거" 2>/dev/null
    git pull origin main --rebase 2>/dev/null
    git push origin main 2>/dev/null
    echo " ✅ 깃허브(GitHub) 저장소 동기화 및 원격 삭제 커밋 완료"
else
    echo " ℹ️ 깃 저장소가 초기화되어 있지 않아 원격 삭제를 건너뜁니다."
fi

# 4. 바탕화면에 남아있을지 모르는 구버전 백업 파일 정리 (선택 사항)
rm -f "$HOME/Desktop/network_tools_backup_*.tar.gz"
echo " ✅ 바탕화면의 이전 백업 파일(.tar.gz) 정리 완료"

echo "------------------------------------------------------------"
echo " ✨ 삭제 프로세스가 완료되었습니다."
echo " 💡 이제 'netman'을 입력하셔도 6번 netperf 항목은 나타나지 않습니다."
echo "============================================================"
