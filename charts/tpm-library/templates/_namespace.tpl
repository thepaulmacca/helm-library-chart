{{/* 
Renders the Namespace objects required by the chart 
*/}}
{{- define "tpm-library.namespace.tpl" -}}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Release.Namespace }}
{{- end -}}
{{- define "tpm-library.namespace" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.namespace.tpl") -}}
{{- end -}}