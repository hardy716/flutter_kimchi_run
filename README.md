## 🌶️ Flutter Kimchi Run - 모바일 러닝 게임

Flutter Kimchi Run은 Flutter와 Unity WebGL을 결합하여 개발된 모바일 러닝 게임입니다. 이 프로젝트는 [노마드 코더 Nomad Coders - 김장 게임을 만들었다 😎 ㅋㅋ](https://youtu.be/A58_FWqiekI?si=fAbvNaV_A-KtURuA)라는 유니티 튜토리얼 유튜브 영상을 기반으로 제작되었으며, Unity로 제작된 게임 콘텐츠를 WebGL로 빌드한 후, Flutter 앱 내의 웹뷰를 통해 모바일 환경에서 플레이할 수 있도록 구현했습니다.

---

##### 🎮 게임 플레이
1. 앱 실행 후 익명 로그인으로 자동 인증
2. 메인 화면에서 게임 시작 버튼 클릭
3. 3Unity WebGL 게임이 Flutter WebView 내에서 실행
4. 게임 종료 시 점수가 Firebase Firestore에 자동 저장
5. (좌측 상단 닉네임 버튼 클릭 후 닉네임 수정)
6. (우측 상단 랭킹 버튼 클릭 후 내 게임 정보(플레이 횟수, 랭킹, 최고 점수), 전체 랭킹 확인)

##### 👤 프로필 관리
- 닉네임 설정 및 수정
- 게임 통계 및 최고 점수 조회
- 전체 랭킹 확인

##### 🏆 랭킹 시스템
- 실시간 글로벌 랭킹
- 개인 최고 점수 기록
- 상위 10명 리더보드


#### 스크린샷 및 영상 링크

|  |  |
|:---:|:---:|
| 닉네임 화면 | 랭킹 화면 |
| <img alt="Image" src="https://github.com/user-attachments/assets/6830d2d6-c071-4439-ba95-26c71bbcb579" /> | <img alt="Image" src="https://github.com/user-attachments/assets/9b7ae01a-0d68-4cf4-96c6-2a587c11a26c" /> |

|  |
|:---:|
| 게임 화면 |
| <img alt="Image" src="https://github.com/user-attachments/assets/4f22c45d-2b86-4dab-b75e-8799c4b4046c" /> |

게임 로딩 영상 링크 - [https://drive.google.com/file/d/1Lz_10MCNN78RyquFADnLGZ2KU3dOzrZD/view?usp=sharing](https://drive.google.com/file/d/1Lz_10MCNN78RyquFADnLGZ2KU3dOzrZD/view?usp=sharing)

게임 플레이 영상 링크 - [https://drive.google.com/file/d/1WtJAUoJSE-hNY3ee1_EMritnKwe9U-Bm/view?usp=sharing](https://drive.google.com/file/d/1WtJAUoJSE-hNY3ee1_EMritnKwe9U-Bm/view?usp=sharing)


#### ✨ 주요 기능

- 🎯 **Unity WebGL 게임 통합**: Flutter 앱 내에서 Unity 게임 실행
- 🔥 **Firebase 인증 시스템**: 익명 로그인 및 사용자 관리
- 💡 **실시간 랭킹 시스템**: Cloud Firestore 기반 점수 추적
- 🛡️ **모듈화된 아키텍처**: 인증, 프로필, 게임 모듈 분리
- 📱 **크로스 플랫폼 지원**: Android, iOS, Web 동시 지원
- 🎨 **현대적 UI/UX**: Material Design과 커스텀 테마 적용

#### 🛠️ 기술 스택

##### 📦 Frontend
- **Flutter SDK**: ^3.8.1
- **Dart**: 주 개발 언어
- **Unity WebGL**: 게임 엔진 통합
- **flutter_inappwebview**: WebView 통합

##### 🔧 Services
- **Firebase Suite**: 완전한 백엔드 솔루션
    - firebase_core
    - firebase_auth (사용자 인증)
    - cloud_firestore (실시간 데이터베이스)
    - firebase_analytics (분석)
    - firebase_crashlytics (충돌 보고)

##### 🗄️ State Management & Architecture
- **flutter_riverpod**: 의존성 주입 및 상태 관리
- **riverpod_annotation**: Riverpod 어노테이션
- **go_router**: 선언적 라우팅
- **freezed**: 불변 클래스 및 유니온 타입
- **json_annotation**: JSON 직렬화

##### ⚙️ DevOps & Tools
- **build_runner**: 코드 생성
- **flutter_gen_runner**: 에셋 생성
- **flutter_lints**: 코드 품질 분석
- **riverpod_lint**: Riverpod 베스트 프랙티스
- **custom_lint**: 커스텀 린팅 규칙

#### 🏗️ 프로젝트 구조

```
flutter_kimchi_run/
├── 📱 android/                 # Android 플랫폼 설정
├── 🍎 ios/                     # iOS 플랫폼 설정  
├── 🌐 web/                     # Web 플랫폼 설정
├── 🎨 assets/                  # 에셋 파일들
│   ├── color/                  # 컬러 정의 (colors.xml)
│   ├── fonts/                  # Jersey25 폰트
│   ├── icons/                  # 아이콘 리소스
│   └── images/                 # 이미지 리소스
├── 📂 lib/                     # Flutter 소스 코드
│   ├── 🏛️ core/               # 핵심 유틸리티
│   │   ├── base/               # 기본 클래스 (Result<S,E>)
│   │   ├── extensions/         # Dart 확장 함수
│   │   └── theme/              # 앱 테마 설정
│   ├── 🤖 gen/                 # 생성된 코드 (assets, fonts, colors)
│   ├── 📋 modules/             # 기능 모듈들
│   │   ├── auth/               # 인증 모듈
│   │   │   ├── data/           # 데이터 레이어
│   │   │   ├── domain/         # 도메인 레이어
│   │   │   └── presentation/   # 프레젠테이션 레이어
│   │   └── game/               # 게임 모듈
│   │       ├── data/           # 데이터 레이어
│   │       ├── domain/         # 도메인 레이어
│   │       └── presentation/   # 프레젠테이션 레이어
│   ├── 🪧 router/              # 네비게이션 설정
│   └── 🧩 shared/              # 공유 UI 컴포넌트
├── 📋 CLAUDE.md                # AI 개발 가이드
└── 📦 pubspec.yaml             # 프로젝트 의존성
```

#### 👥 제작자

**Hardy** - 개발자
- GitHub: [@hardy716](https://github.com/hardy716)
- Nomad Coders YouTube 튜토리얼 기반

#### 🙏 감사의 말

- **Nicolas (Nomad Coders)**: 원본 튜토리얼 제공
- **Flutter Team**: 훌륭한 크로스 플랫폼 프레임워크
- **Firebase Team**: 완벽한 백엔드 서비스
- **Claude Code**: AI 어시스턴트 개발 지원

#### 🙌 저작권 출처 명시

- **[Jersey25-Regular.ttf](https://fonts.google.com/specimen/Jersey+25/license)** :  Jersey25 폰트 Designed by Sarah Cadigan-Fried [(License)](https://fonts.google.com/specimen/Jersey+25/license)
- **[Kimchi Icon](https://travellers-rest.fandom.com/wiki/Kimchi)** :  김치 아이콘 에셋

---

⭐ **이 프로젝트가 유용하다면 별표를 눌러주세요!** ⭐

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>