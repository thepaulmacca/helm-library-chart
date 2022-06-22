{{/*
Renders the Deployment objects required by the chart
*/}}
{{- define "tpm-library.deployment.tpl" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "tpm-library.fullname" . }}-deployment
  labels:
    {{- include "tpm-library.labels" . | nindent 4 }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicas }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "tpm-library.selector-labels" . | nindent 6 }}
{{ include "tpm-library.podtemplate.tpl" . | indent 2 -}}
{{- end -}}
{{- define "tpm-library.deployment" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.deployment.tpl") -}}
{{- end -}}