{{/* 
Renders the Namespace objects required by the chart 
*/}}
{{- define "tpm-library.fullnamespace.tpl" -}}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Release.Namespace }}
{{- end -}}
{{- define "tpm-library.fullnamespace" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.fullnamespace.tpl") -}}
{{- end -}}