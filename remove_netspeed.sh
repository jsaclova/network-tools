#!/bin/bash

echo "============================================================"
echo "          🚨 netspeed 관련 모든 정보 완전 삭제 시작"
echo "============================================================"

# 1. 로컬 실행 파일 제거
if [ -f "$HOME/bin/network-tools/netspeed" ]; then
    rm -f "$HOME/bin/network-tools/netspeed"
    echo " ✅ 로컬 실행 파일 삭제 완료 (~/bin/network-tools/netspeed)"
else
    echo " ℹ️ 삭제할 로컬 netspeed 파일이 없습니다."
fi

# 2. 매뉴얼(manual) 파일에서 5번 항목(netspeed) 관련 본문 가이드 라인 도려내기
MANUAL_FILE="$HOME/bin/network-tools/manual"
if [ -f "$MANUAL_FILE" ]; then
    # 5번 항목 시작부터 다음 요약 구분선까지 내용을 안전하게 매칭하여 삭제
    sed -i '' '/5️⃣/,/------------------------------------------------------------/d' "$MANUAL_FILE" 2>/dev/null
    # 요약 정보 관리 라인에 기재되어 있던 netspeed 텍스트 줄 완전 제거
    sed -i '' '/netspeed/d' "$MANUAL_FILE" 2>/dev/null
    echo " ✅ 터미널 매뉴얼(manual) 내 netspeed 가이드 단락 제거 완료"
else
    echo " ℹ️ 수정할 매뉴얼 파일이 유실되어 건너뜁니다."
fi

# 3. 깃허브(GitHub) 원격 저장소 청소 및 최신본 업데이트 동기화
cd "$HOME/bin/network-tools" 2>/dev/null
if [ -d ".git" ]; then
    # 깃 추적 리스트에서 netspeed를 캐시 제외 및 영구 삭제 등록
    git rm netspeed --cached 2>/dev/null
    git add .
    git commit -m "Clean up: netspeed 명령어 및 매뉴얼 가이드 완전 삭제 반영" 2>/dev/null
    git pull origin main --rebase 2>/dev/null
    git push origin main 2>/dev/null
    echo " ✅ 깃허브(GitHub) 원격 저장소 동기화 및 롤백 커밋 업데이트 완료"
else
    echo " ℹ️ 깃 저장소가 초기화되어 있지 않아 원격 업로드를 건너뜁니다."
fi

# 4. 바탕화면에 남아있을지 모르는 구버전 백업 아카이브 삭제 정리
rm -f "$HOME/Desktop/network_tools_backup_*.tar.gz"
echo " ✅ 바탕화면의 이전 세대 압축 백업본 파일(.tar.gz) 정리 완료"

echo "------------------------------------------------------------"
echo " ✨ 삭제 및 원격 업데이트 프로세스가 성공적으로 완료되었습니다."
echo " 💡 이제 'netman'을 입력하셔도 5번 netspeed 항목은 조회되지 않습니다."
echo "============================================================"
