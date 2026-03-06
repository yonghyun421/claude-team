# Claude Team

Claude Code용 20명 풀스택 개발팀 에이전트 설정.

## 팀 구성

### 전략/판단 (Opus)
| 에이전트 | 역할 |
|---------|------|
| `pm` | 요구사항 분석, 유저스토리, 우선순위 |
| `planner` | 구현 계획, 태스크 분해 |
| `architect` | 시스템 설계, 기술 의사결정 |
| `code-reviewer` | 코드 품질 리뷰 |
| `security-reviewer` | 보안 취약점 탐지 |

### 프론트엔드 (Sonnet)
| 에이전트 | 역할 |
|---------|------|
| `page-builder` | Next.js 라우팅, 레이아웃, SSR/SSG, SEO |
| `frontend` | React 컴포넌트, 상태 관리, 데이터 패칭 |
| `ui-designer` | 디자인 시스템, 애니메이션, 접근성 |
| `form-specialist` | React Hook Form + Zod, 멀티스텝 폼 |

### 백엔드 (Sonnet)
| 에이전트 | 역할 |
|---------|------|
| `backend` | API 라우트, Server Actions |
| `auth-engineer` | 인증/인가, OAuth, RBAC |
| `db-engineer` | 스키마, 마이그레이션, 쿼리 최적화 |
| `integrator` | 결제, 이메일, 웹훅, AI SDK |

### 인프라/성능 (Sonnet)
| 에이전트 | 역할 |
|---------|------|
| `devops` | CI/CD, Docker, 배포 |
| `performance` | 번들 최적화, Core Web Vitals |

### 품질/유지보수 (Sonnet)
| 에이전트 | 역할 |
|---------|------|
| `tdd-guide` | TDD, 80%+ 커버리지 |
| `e2e-runner` | Playwright E2E 테스트 |
| `build-error-resolver` | 빌드 에러 수정 |
| `refactor-cleaner` | 데드코드 정리 |
| `doc-updater` | 문서화 |

## 설치

### 글로벌 설치 (모든 프로젝트에서 사용)

```bash
git clone <this-repo> ~/claude-team
cd ~/claude-team
chmod +x install.sh
./install.sh --global
```

### 심볼릭 링크 설치 (레포 업데이트 자동 반영)

```bash
./install.sh --global --symlink
```

### 로컬 설치 (현재 프로젝트에만)

```bash
cd /path/to/your/project
/path/to/claude-team/install.sh --local
```

### OMC 설정 포함 설치

```bash
./install.sh --global --config
```

## 제거

```bash
./uninstall.sh --global   # 글로벌 제거
./uninstall.sh --local    # 로컬 제거
```

## 커스터마이징

`agents/` 폴더의 `.md` 파일을 수정하면 됩니다.

```yaml
---
name: agent-name
description: 에이전트 설명
tools: Read, Write, Edit, Bash, Grep, Glob
model: sonnet  # sonnet 또는 opus
---
```

### 에이전트 추가

1. `agents/` 폴더에 새 `.md` 파일 생성
2. 위 형식의 frontmatter 작성
3. `./install.sh` 재실행

## 기술 스택

이 팀은 다음 기술 스택에 최적화되어 있습니다:

- **프레임워크**: React 19, Next.js 15 (App Router)
- **스타일링**: Tailwind CSS, shadcn/ui
- **상태 관리**: Zustand
- **폼**: React Hook Form + Zod
- **데이터 패칭**: TanStack Query
- **인증**: Auth.js (NextAuth v5)
- **DB**: PostgreSQL, Prisma/Drizzle
- **테스트**: Vitest, Playwright
- **배포**: Vercel, Docker, GitHub Actions
