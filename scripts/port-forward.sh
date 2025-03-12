#!/bin/bash


# Skrypt do przekierowania portów dla wszystkich interfejsów monitorowania 

# Funkcja do zatryzmania przekierowania podczas zamknięcia skrypu 


#!/bin/bash

# Skrypt do przekierowania portów dla wszystkich interfejsów monitorowania

# Funkcja do zatrzymania przekierowania podczas zamknięcia skryptu
cleanup() {
  echo "Zatrzymywanie wszystkich przekierowań portów..."
  kill $(jobs -p) 2>/dev/null
  exit 0
}

# Obsługa zakończenia skryptu
trap cleanup SIGINT SIGTERM

echo "🚀 Uruchamianie port-forward dla interfejsów monitorowania..."

# Sprawdzenie, czy namespace monitoring istnieje
if ! kubectl get namespace monitoring &>/dev/null; then
  echo "❌ Namespace 'monitoring' nie istnieje! Najpierw uruchom 'task create-namespace'."
  exit 1
fi

# Sprawdzanie i uruchamianie port-forwarding dla każdej usługi

# Prometheus
if kubectl get svc -n monitoring prometheus-service &>/dev/null; then
  kubectl port-forward -n monitoring svc/prometheus-service 9090:9090 &
  echo "✅ Prometheus dostępny na http://localhost:9090"
else
  echo "⚠️ Usługa Prometheus nie została znaleziona w przestrzeni nazw 'monitoring'."
fi

# Grafana
if kubectl get svc -n monitoring grafana &>/dev/null; then
  kubectl port-forward -n monitoring svc/grafana 3000:3000 &
  echo "✅ Grafana dostępna na http://localhost:3000 (login: admin, hasło: admin)"
else
  echo "⚠️ Usługa Grafana nie została znaleziona w przestrzeni nazw 'monitoring'."
fi

# Jaeger
if kubectl get svc -n monitoring jaeger-query &>/dev/null; then
  kubectl port-forward -n monitoring svc/jaeger-query 16686:16686 &
  echo "✅ Jaeger UI dostępny na http://localhost:16686"
else
  echo "⚠️ Usługa Jaeger nie została znaleziona w przestrzeni nazw 'monitoring'."
fi

# Loki
if kubectl get svc -n monitoring loki &>/dev/null; then
  kubectl port-forward -n monitoring svc/loki 3100:3100 &
  echo "✅ Loki API dostępne na http://localhost:3100"
else
  echo "⚠️ Usługa Loki nie została znaleziona w przestrzeni nazw 'monitoring'."
fi

echo ""
echo "📊 Wszystkie dostępne interfejsy są teraz przekierowane do portów lokalnych."
echo "📋 Naciśnij Ctrl+C, aby zatrzymać wszystkie przekierowania portów."
echo ""

# Czekaj na Ctrl+C
wait