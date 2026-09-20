# 🍺 맥(macOS) 나만의 네트워크 진단 툴킷 (Network Tools)

맥북 및 깃허브 원격 저장소와 연동하여 어디서나 명령어 하나로 유무선 하드웨어 연결 상태, 내부 대역폭 및 주변 기기를 제어하고 날짜별 로그 아카이브를 관리하는 유닉스 표준 자동화 툴킷입니다.

---

## 🚀 배포 및 설치 가이드 (Installation)

사용자의 환경이나 PC 상태에 따라 **자동 설치** 또는 **수동 설치** 방식을 선택하여 환경을 구축할 수 있습니다.

### 💡 방법 A. 원클릭 자동 설치 (추천)
새로운 PC나 포맷한 맥 환경에서 터미널을 열고 아래 한 줄만 복사해서 엔터를 치면, 깃허브 주소를 입력받아 패키지 다운로드부터 터미널 환경 변수 매핑까지 5초 만에 완료합니다.
```bash
curl -sSL https://githubusercontent.com -o /tmp/nettool_install && chmod +x /tmp/nettool_install && /tmp/nettool_install && rm -f /tmp/nettool_install
```

### 🛠️ 방법 B. 최초 Git Clone 수동 설치 (정석)
원격 저장소에서 소스코드를 직접 내려받아 안전하게 수동으로 환경을 빌드하고 싶을 때는 아래 절차를 순서대로 터미널에 입력합니다.

```bash
# 1. 사용자 명령어 보관 표준 폴더 생성 및 이동
mkdir -p ~/bin && cd ~/bin

# 2. 깃허브 원격 저장소로부터 소스코드 직접 다운로드 (Clone)
git clone git@github.com:jsaclova/network-tools.git

# 3. 맥 터미널 환경설정 파일(~/.zshrc)에 명령어 실행 경로(PATH) 등록
echo 'export PATH="$HOME/bin/network-tools:$PATH"' >> ~/.zshrc

# 4. 언제 어디서나 매뉴얼을 꺼내볼 수 있도록 전용 단축키(alias) 등록
echo "alias netman='cat ~/bin/network-tools/manual | less -R'" >> ~/.zshrc

# 5. 내려받은 모든 진단 명령어 파일에 실행 권한 인가
chmod +x ~/bin/network-tools/*
```

> ⚠️ **설치 완료 후 필수 사항**: 두 방법 모두 설치를 정상적으로 마친 후, 아래 명령어를 입력하거나 터미널 창을 새로 열어주어야 나만의 내장 명령어가 최종 활성화됩니다.
> ```bash
> source ~/.zshrc
> ```

---

## ⚙️ 핵심 내장 명령어 명세 요약

터미널 작업 위치와 상관없이 어디서든 명령어 이름만 입력하면 즉시 구동됩니다.

| 명령어 | 주요 기능 | 비고 / 세부 특징 |
| :--- | :--- | :--- |
| **`netinfo`** | 내 장치 통합 정보 조회 | 내부 사설 IP, 서브넷 마스크, 게이트웨이, DNS 정보 및 **외부 실제 공인 IP(Public IP)** 통합 실시간 출력 |
| **`netscan`** | 주변 장치 및 포트 진단 | **인자값 없음**: 현재 네트워크 대역 자동 계산 및 활성 IP 스캔 (결과는 `log/` 폴더에 일시별 기록, 7일 보관 후 자동 파기)<br>**인자값 지정 (`netscan [대상IP]`)**: 대상 기기의 활성화 여부 체크 및 웹(80/443), SSH(22) 등 **주요 10대 포트 개방 여부** 이모지 레포트 출력 |
| **`netcheck`** | 유/무선 물리 링크 점검 | 와이파이뿐만 아니라 맥북에 도킹된 USB-C 허브, 썬더볼트 독(Dock) 등 **이더넷 랜 하드웨어 케이블 체결 상태(`Active`/`Inactive`)** 정밀 추적 |
| **`netbackup`** | 로컬 백업 아카이브 생성 | 정비된 명령어 원본과 터미널 환경 설정값(~/.zshrc 스니펫)을 압축하여 내부 `backup/` 폴더에 타임스탬프 파일(`.tar.gz`)로 저장 (★ `backup/` 폴더는 `.gitignore` 설정으로 깃 업로드 원천 차단) |
| **`netrestore`**| 최신 아카이브 원클릭 복구 | `backup/` 폴더 내부에 적재된 백업 파일들 중 **날짜와 시간이 가장 최신인 본체를 시스템이 스스로 역추적하여 1초 만에 완벽 복원** |
| **`netman`** | 터미널 통합 지침서 구동 | 터미널 내에서 방향키와 스페이스바를 활용해 화면 단위로 매뉴얼을 깨끗하게 정독할 수 있는 전용 뷰어 가동 (`q`를 누르면 복귀) |

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
├── log/             # netscan 수집 데이터 누적 보관 폴더 (7일 보관 후 자동 삭제)
└── backup/          # netbackup 파일 적재소 (★ Git 원격 업로드 보안 차단)
```
