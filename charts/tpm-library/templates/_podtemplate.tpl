{{/*
Create pod template spec.
*/}}
{{- define "tpm-library.podtemplate.tpl" -}}
template:
  metadata:
    labels:
      {{- include "tpm-library.selector-labels" . | nindent 8 }}
  spec:
    containers:
{{ include "tpm-library.container.tpl" . | indent 6 -}}
{{- end -}}
{{- define "tpm-library.podtemplate" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.podtemplate.tpl") -}}
{{- end -}}