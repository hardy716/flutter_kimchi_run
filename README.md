# 🚀 Flutter Kimchi Run

Flutter와 Unity WebGL을 활용한 모바일 러닝 게임 - Nomad Coders 유튜브 튜토리얼 기반 프로젝트

## 📋 프로젝트 개요

Flutter Kimchi Run은 Flutter 프레임워크와 Unity WebGL을 결합한 크로스 플랫폼 모바일 게임입니다. Nicolas(Nomad Coders)의 유튜브 튜토리얼을 기반으로 제작되었으며, Android, iOS, Web 플랫폼을 지원합니다. Firebase 백엔드와 Riverpod 상태관리를 통한 현대적인 아키텍처를 구현했습니다.

## ✨ 주요 기능

- 🎯 **Unity WebGL 게임 통합**: Flutter 앱 내에서 Unity 게임 실행
- 🔥 **Firebase 인증 시스템**: 익명 로그인 및 사용자 관리
- 💡 **실시간 랭킹 시스템**: Cloud Firestore 기반 점수 추적
- 🛡️ **모듈화된 아키텍처**: 인증, 프로필, 게임 모듈 분리
- 📱 **크로스 플랫폼 지원**: Android, iOS, Web 동시 지원
- 🎨 **현대적 UI/UX**: Material Design과 커스텀 테마 적용

## 🛠️ 기술 스택

### 📦 Frontend
- **Flutter SDK**: ^3.8.1
- **Dart**: 주 개발 언어
- **Unity WebGL**: 게임 엔진 통합
- **flutter_inappwebview**: WebView 통합

### 🔧 Services
- **Firebase Suite**: 완전한 백엔드 솔루션
  - firebase_core
  - firebase_auth (사용자 인증)
  - cloud_firestore (실시간 데이터베이스)
  - firebase_storage (파일 스토리지)
  - firebase_analytics (분석)
  - firebase_crashlytics (충돌 보고)

### 🗄️ State Management & Architecture
- **flutter_riverpod**: 의존성 주입 및 상태 관리
- **riverpod_annotation**: Riverpod 어노테이션
- **go_router**: 선언적 라우팅
- **freezed**: 불변 클래스 및 유니온 타입
- **json_annotation**: JSON 직렬화

### ⚙️ DevOps & Tools
- **build_runner**: 코드 생성
- **flutter_gen_runner**: 에셋 생성
- **flutter_lints**: 코드 품질 분석
- **riverpod_lint**: Riverpod 베스트 프랙티스
- **custom_lint**: 커스텀 린팅 규칙

## 🏗️ 프로젝트 구조

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

## 🚀 시작하기

### 📋 사전 요구사항

- **Flutter SDK**: 3.8.1 이상
- **Dart SDK**: 3.5.0 이상
- **Android Studio** 또는 **VS Code** (Flutter 플러그인 포함)
- **Firebase 계정** (Firebase 서비스 이용 시)
- **Unity Hub** (게임 개발/수정 시)
- **Xcode** (iOS 빌드 시, macOS 필요)

### 📦 설치

1. **저장소 클론**
```bash
git clone https://github.com/your-username/flutter_kimchi_run.git
cd flutter_kimchi_run
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **코드 생성**
```bash
dart run build_runner build
```

4. **에셋 생성**
```bash
flutter packages pub run flutter_gen_runner
```

### 🔧 환경 설정

1. **Firebase 설정**
   - Firebase 콘솔에서 새 프로젝트 생성
   - `google-services.json` (Android)을 `android/app/` 디렉토리에 추가
   - `GoogleService-Info.plist` (iOS)를 `ios/Runner/` 디렉토리에 추가
   - Authentication, Firestore, Storage 서비스 활성화

2. **Unity WebGL 빌드**
   - Unity에서 WebGL 플랫폼으로 빌드
   - 빌드된 파일을 `web/unity/` 디렉토리에 배치

### ▶️ 실행

```bash
# 개발 모드 실행
flutter run

# 특정 플랫폼 실행
flutter run -d chrome          # Web
flutter run -d android         # Android
flutter run -d ios             # iOS (macOS 필요)

# 디버그 정보와 함께 실행
flutter run --verbose
```

## 📱 사용법

### 🎮 게임 플레이
1. 앱 실행 후 익명 로그인으로 자동 인증
2. 메인 화면에서 게임 시작 버튼 클릭
3. 3Unity WebGL 게임이 Flutter WebView 내에서 실행
4. 게임 종료 시 점수가 Firebase Firestore에 자동 저장
5. (좌측 상단 닉네임 버튼 클릭 후 닉네임 수정)
6. (우측 상단 랭킹 버튼 클릭 후 내 게임 정보(플레이 횟수, 랭킹, 최고 점수), 전체 랭킹 확인)

### 👤 프로필 관리
- 닉네임 설정 및 수정
- 게임 통계 및 최고 점수 조회
- 전체 랭킹 확인

### 🏆 랭킹 시스템
- 실시간 글로벌 랭킹
- 개인 최고 점수 기록
- 상위 10명 리더보드

## 🎨 스크린샷

<div align="center">
  <img src="assets/screenshots/login.png" width="250" alt="로그인 화면"/>
  <img src="assets/screenshots/game.png" width="250" alt="게임 화면"/>
  <img src="assets/screenshots/ranking.png" width="250" alt="랭킹 화면"/>
</div>

## 🧪 테스트

```bash
# 단위 테스트 실행
flutter test

# 정적 분석 실행
flutter analyze

# Riverpod 린트 실행
dart run custom_lint

# 코드 생성 (강제 재생성)
dart run build_runner build --delete-conflicting-outputs
```

### 📝 커밋 컨벤션
```
<type>: <description> [(<issue>)] [* <additional-info>]

<emoji-section> <service/technology>
<changes-summary>

📂 module: <module-name>
<module-changes>

🤖 Generated with [Claude Code](https://claude.ai/code)
Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types**: 
- `feat`: 새로운 기능
- `ui`: UI/UX 변경
- `fix`: 버그 수정
- `refactor`: 코드 리팩토링
- `chore`: 설정, 의존성 업데이트

## 👥 제작자

**Hardy** - 개발자
- GitHub: [@hardy716](https://github.com/your-username)
- Nomad Coders YouTube 튜토리얼 기반

## 🙏 감사의 말

- **Nicolas (Nomad Coders)**: 원본 튜토리얼 제공
- **Flutter Team**: 훌륭한 크로스 플랫폼 프레임워크
- **Firebase Team**: 완벽한 백엔드 서비스
- **Unity Technologies**: 게임 엔진 지원
- **Claude Code**: AI 어시스턴트 개발 지원

---

⭐ **이 프로젝트가 유용하다면 별표를 눌러주세요!** ⭐

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
