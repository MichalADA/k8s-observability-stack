# k8s-observability-stack
Kompletny stos monitorujący dla Kubernetes z Prometheus, Grafana, Loki i Jaeger
# K8s Observability Stack 🔍

Kompletny stos monitorujący dla Kubernetes działający lokalnie z użyciem kind i Devbox.

## Opis projektu

Ten projekt dostarcza gotowy do użycia stos narzędzi do monitorowania aplikacji w Kubernetes, składający się z:

- **Prometheus** - system zbierania i przechowywania metryk
- **Grafana** - platforma do wizualizacji danych i tworzenia dashboardów
- **Loki** - system do agregacji i przeszukiwania logów
- **Promtail** - agent zbierający logi dla Loki
- **Jaeger** - system do śledzenia rozproszonego (distributed tracing)

Całość działa lokalnie na klastrze Kubernetes utworzonym za pomocą kind (Kubernetes in Docker).

## Wymagania

- Docker
- [Devbox](https://www.jetpack.io/devbox/)
- Git

## Szybki start

```bash
# Sklonuj repozytorium
git clone https://github.com/twoja-nazwa/k8s-observability-stack.git
cd k8s-observability-stack

# Uruchom środowisko Devbox
devbox shell

# Wdróż cały stos monitorujący
task deploy-all

# Przekieruj porty do interfejsów UI
task port-forward
```

## Dostępne interfejsy

Po uruchomieniu `task port-forward` będziesz mieć dostęp do:

- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000 (login: admin, hasło: admin)
- **Jaeger UI**: http://localhost:16686
- **Loki API**: http://localhost:3100 (dostępne również przez Grafana)

## Struktura projektu

```
k8s-observability-stack/
├── k8s/                      # Pliki konfiguracyjne Kubernetes
│   ├── namespaces/           # Definicje przestrzeni nazw
│   ├── prometheus/           # Konfiguracja Prometheus
│   ├── grafana/              # Konfiguracja Grafana
│   ├── loki/                 # Konfiguracja Loki
│   ├── promtail/             # Konfiguracja Promtail
│   └── jaeger/               # Konfiguracja Jaeger
├── scripts/                  # Skrypty pomocnicze
│   └── port-forward.sh       # Skrypt do przekierowania portów
└── Taskfile.yml              # Definicje zadań
```

## Dostępne polecenia

Projekt wykorzystuje [Task](https://taskfile.dev) do zarządzania poleceniami:

```bash
# Wyświetl wszystkie dostępne polecenia
task --list

# Podstawowe polecenia:
task setup-cluster      # Utwórz klaster Kubernetes
task create-namespace   # Utwórz przestrzeń nazw monitoring
task apply-monitoring   # Wdróż stos monitorujący
task port-forward       # Przekieruj porty dla interfejsów
task status             # Sprawdź status komponentów
task deploy-all         # Wdróż wszystko - klaster i monitoring
task reset              # Zresetuj całe środowisko
```

## Monitorowane metryki

Domyślna konfiguracja monitoruje:

- **Zasoby klastra** - CPU, pamięć, dysk
- **Zasoby podów** - zużycie CPU i pamięci
- **Metryki Kubernetes** - stan nodów, podów, deploymentów
- **Logi z kontenerów** - zbierane przez Promtail i przechowywane w Loki

## Rozszerzanie stosu

Możesz łatwo rozszerzyć stos monitorujący poprzez:

1. **Dodawanie nowych dashboardów** - umieść definicje dashboardów w `k8s/grafana/grafana-config.yaml`
2. **Konfigurację alertów** - dodaj reguły alertów do Prometheus
3. **Integrację z alertmanagerem** - wdróż Alertmanager do obsługi powiadomień

## Rozwiązywanie problemów

Jeśli napotkasz problemy:

- **Sprawdź status podów**: `kubectl get pods -n monitoring`
- **Sprawdź logi podów**: `kubectl logs -n monitoring <nazwa-poda>`
- **Problemy z uprawnieniami**: sprawdź, czy role RBAC są poprawnie skonfigurowane
- **Problemy z port-forward**: upewnij się, że wymienione porty nie są używane przez inne aplikacje

## Licencja

MIT