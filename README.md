# Sonar Server

Aplikacja kliencka napisana w React.js z serwerem w Go, zintegrowana z SonarCloud do analizy jakości kodu.

## Status SonarCloud

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Sharens_sonar_server&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Sharens_sonar_server)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=Sharens_sonar_server&metric=bugs)](https://sonarcloud.io/summary/new_code?id=Sharens_sonar_server)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=Sharens_sonar_server&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=Sharens_sonar_server)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=Sharens_sonar_server&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=Sharens_sonar_server)

## Opis zadania

Należy dodać projekt aplikacji klienckiej oraz serwerowej (jeden
branch, dwa repozytoria) do Sonara w wersji chmurowej
(https://sonarcloud.io/). Należy poprawić aplikacje uzyskując 0 bugów,
0 zapaszków, 0 podatności, 0 błędów bezpieczeństwa. Dodatkowo należy
dodać widżety sonarowe do README w repozytorium dane projektu z
wynikami.

## Wymagania projektu
* ✅ 3.0 Należy dodać litera do odpowiedniego kodu aplikacji serwerowej w
hookach gita
* ✅ 3.5 Należy wyeliminować wszystkie bugi w kodzie w Sonarze (kod
aplikacji serwerowej)
* ✅ 4.0 Należy wyeliminować wszystkie zapaszki w kodzie w Sonarze (kod
aplikacji serwerowej)
* ✅ 4.5 Należy wyeliminować wszystkie podatności oraz błędy bezpieczeństwa
w kodzie w Sonarze (kod aplikacji serwerowej)
* ❌ 5.0 Należy wyeliminować wszystkie błędy oraz zapaszki w kodzie
aplikacji klienckiej

## Wymagania techniczne
- Node.js >= 18.x i npm
- Go >= 1.21 (jeśli aplikacja uruchamiana bez dockera)
- Docker i Docker Compose
- Konto na [SonarCloud](https://sonarcloud.io/)
- Token dostępu do SonarCloud

## Struktura projektu
```bash
sonar_server/
├── .github/workflows/        # GitHub Actions workflows
│   └── sonarcloud.yml        # Konfiguracja SonarCloud CI/CD
├── .husky/                   # Konfiguracja Git hooks
│   ├── _/                    
│   ├── pre-commit           # Hook pre-commit
│   └── pre-push             # Hook pre-push
├── scripts/                  # Skrypty pomocnicze
│   ├── analyze.sh           # Skrypt analizy kodu
│   └── pre-push.sh          # Skrypt pre-push
├── server/                   # Serwer w Go
│   ├── Dockerfile            
│   ├── go.mod               
│   ├── main.go              
│   └── ...                  
├── src/                     # Aplikacja kliencka React
│   ├── components/           
│   │   ├── Products/       
│   │   ├── Cart/           
│   │   └── Payments/       
│   ├── context/            
│   ├── App.js              
│   └── index.js            
├── .eslintrc.json           # Konfiguracja ESLint
├── .golangci.yml            # Konfiguracja golangci-lint
├── .prettierrc             # Konfiguracja Prettier
├── sonar-project.properties # Konfiguracja SonarQube/SonarCloud
├── package.json            
├── package-lock.json       
└── README.md
```

## Konfiguracja środowiska

### Wymagane zmienne środowiskowe

Utwórz plik `.env` w głównym katalogu projektu z następującymi zmiennymi:

```
# Aplikacja kliencka
REACT_APP_API_URL=http://localhost:8080/api

# SonarCloud
SONAR_TOKEN=your_sonarcloud_token
SONAR_ORGANIZATION=your_sonarcloud_organization
```

### Uruchomienie z Docker Compose

```bash
docker-compose up --build
```

### Uruchomienie bez Dockera

1. Uruchom serwer:
   ```bash
   cd server
   go run main.go
   ```

2. W osobnym terminalu uruchom aplikację kliencką:
   ```bash
   npm start
   ```

## Integracja z SonarCloud

1. Zaloguj się na [SonarCloud](https://sonarcloud.io/) i utwórz nowy projekt
2. Wygeneruj token dostępu w ustawieniach konta
3. Dodaj token jako sekret w ustawieniach repozytorium GitHub:
   - `SONAR_TOKEN` - wygenerowany token SonarCloud
   - `SONAR_ORGANIZATION` - nazwa Twojej organizacji na SonarCloud

### Uruchomienie analizy lokalnie

```bash
# Uruchom pełną analizę
./scripts/analyze.sh
```

## Testy i jakość kodu

Przed każdym commitem i push'em są uruchamiane narzędzia do analizy kodu:

- **ESLint** - analiza jakości kodu JavaScript/TypeScript
- **Prettier** - formatowanie kodu
- **golangci-lint** - analiza jakości kodu Go
- **Testy jednostkowe** - uruchamianie testów przed commitem

## Licencja

MIT
Jeśli aplikacja uruchamia backend lokalnie, należy się upewnić, że serwer Go działa na porcie 8080.

## Uruchomienie przez Docker Compose

Aby uruchomić aplikację frontendową i backendową w kontenerach Docker, wykonaj w katalogu projektu:

```bash
docker-compose up --build
```

Po zbudowaniu i uruchomieniu:
- Frontend dostępny jest pod: http://localhost:3000
- Backend API pod: http://localhost:8080/api

Aby zatrzymać i usunąć kontenery, użyj:

```bash
docker-compose down