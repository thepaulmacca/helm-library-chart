{{/* 
Renders the Ingress objects required by the chart 
*/}}
{{- define "tpm-library.ingress.tpl" -}}
{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "tpm-library.fullname" . }}-ingress
  labels:
    {{- include "tpm-library.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  ingressClassName: {{ .Values.ingress.className }}
  rules:
    {{- .Values.ingress.rules | toYaml | nindent 4 }}
{{- end }}
{{- end -}}
{{- define "tpm-library.ingress" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.ingress.tpl") -}}
{{- end -}}