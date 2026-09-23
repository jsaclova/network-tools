# 🍺 맥(macOS) 나만의 네트워크 진단 툴킷 (Network Tools)

맥북 및 깃허브 원격 저장소와 연동하여 어디서나 명령어 하나로 유무선 하드웨어 연결 상태 및 주변 기기를 제어하고 날짜별 로그를 관리하는 유닉스 표준 자동화 툴킷입니다.

---

## 🚀 배포 및 설치 가이드 (Installation)

### 💡 방법 A. 원클릭 자동 설치 (추천)
새로운 PC나 포맷한 맥 터미널에서 아래 한 줄만 실행하면 자동 설치됩니다.
```bash
curl -sSL https://githubusercontent.com -o /tmp/nettool_install && chmod +x /tmp/nettool_install && /tmp/nettool_install && rm -f /tmp/nettool_install
```

### 🛠️ 방법 B. 최초 Git Clone 수동 설치 (정석)
원격 저장소에서 소스코드를 직접 내려받아 수동으로 환경을 빌드하는 절차입니다.

```bash
mkdir -p ~/bin && cd ~/bin
git clone git@github.com:jsaclova/network-tools.git
echo 'export PATH="$HOME/bin/network-tools:$PATH"' >> ~/.zshrc
echo "alias netman='cat ~/bin/network-tools/manual | less -R'" >> ~/.zshrc
chmod +x ~/bin/network-tools/*
```
> ⚠️ **설치 후 필수 완료 명령어**: `source ~/.zshrc`

---

## ⚙️ 핵심 내장 명령어 명세 요약

| 명령어 | 주요 기능 |
| :--- | :--- |
| **`netinfo`** | 내 장치 정보 조회 (내부 IP, 마스크, DNS, 공인 IP 출력) |
| **`netscan`** | 주변 장치 탐색 및 주요 10대 포트 개방 여부 진단 |
| **`netcheck`**| 유/무선 물리 링크 점검 (와이파이 및 유선 랜선 연결 추적) |
| **`netbackup`**| 툴킷 원본 압축 후 격리된 `backup/` 폴더에 저장 |
| **`netrestore`**| `backup/` 내 파일 중 가장 최신본을 추적하여 자동 복원 |
| **`netman`** | 터미널 전용 매뉴얼 뷰어 가동 (`q`로 종료) |

---

## 📂 저장소 디렉토리 구조 (Directory Map)
```text
~/bin/network-tools/
├── README.md        # 깃허브 메인보드 대시보드 문서 (현재 파일)
├── nettool_install  # 원격 원클릭 범용 복제 쉘 스크립트
├── netinfo          # 통합 네트워크 요약기
├── netscan          # 자동 기기 탐색 및 10대 포트 스캐너
├── netcheck         # 유무선 하드웨어 링크 진단기
├── netbackup        # 로컬 격리형 아카이브 압축기
├── netrestore       # 최신 타임스탬프 자동 복구기
├── manual           # ANSI 인코딩 텍스트 매뉴얼 본체
├── log/             # netscan 수집 데이터 누적 보관 폴더 (7일 후 자동 삭제)
└── backup/          # netbackup 파일 적재소 (★ Git 원격 업로드 보안 차단)
```
