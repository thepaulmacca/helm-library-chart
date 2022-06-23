{{/*
Renders the Service objects required by the chart
*/}}
{{- define "tpm-library.service.tpl" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "tpm-library.fullname" . }}-service
  labels:
    {{- include "tpm-library.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
  - port: {{ .Values.service.port }}
    targetPort: {{ .Values.service.targetPort }}
    protocol: TCP
  selector:
    {{- include "tpm-library.selector-labels" . | nindent 4 }}
{{- end -}}
{{- define "tpm-library.service" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.service.tpl") -}}
{{- end -}}