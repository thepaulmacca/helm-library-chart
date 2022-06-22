{{/*
Renders the container objects required by the chart
*/}}
{{- define "tpm-library.container.tpl" -}}
- name: {{ include "tpm-library.fullname" . }}
  image: "{{ .Values.image.name }}:{{ .Values.image.tag }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  env:
  {{- if .Values.env }}
  {{- range $key, $value := .Values.env }}
  - name: {{ $key }}
    value: {{ $value | quote }}
  {{- end }}
  ports:
  - name: http
    containerPort: {{ .Values.deployment.containerPort }}
    protocol: TCP
  {{- if .Values.livenessProbe.enabled }}
  livenessProbe:
    httpGet:
      path: {{ .Values.livenessProbe.path }}
      port: {{ .Values.livenessProbe.port }}
    initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.livenessProbe.timeoutSeconds }}
  {{- end }}
  {{- if .Values.readinessProbe.enabled }}
  readinessProbe:
    httpGet:
      path: {{ .Values.readinessProbe.path }}
      port: {{ .Values.readinessProbe.port }}
    initialDelaySeconds: {{ .Values.readinessProbe.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.readinessProbe.timeoutSeconds }}
    successThreshold: {{ .Values.readinessProbe.successThreshold }}
    periodSeconds: {{ .Values.readinessProbe.periodSeconds }}
  {{- end }}
  resources:
    {{- toYaml .Values.resources | nindent 12 }}
{{- end -}}
{{- define "tpm-library.container" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.container.tpl") -}}
{{- end -}}