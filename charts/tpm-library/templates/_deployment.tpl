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
  template:
    metadata:
      labels:
        {{- if .Values.azureIdentity }}
        aadpodidbinding: {{ include "tpm-library.fullname" . }}-azure-identity-selector
        {{- end }}
        {{- include "tpm-library.selector-labels" . | nindent 8 }}
    spec:
      containers:
        - name: {{ include "tpm-library.fullname" . }}
          image: "{{ .Values.image.name }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          {{- if .Values.container.command }}
          command:
            {{- toYaml .Values.container.command | nindent 12 }}
          {{- end }}
          {{- if .Values.container.args }}
          args:
            {{- toYaml .Values.container.args | nindent 12 }}
          {{- end }}
          ports:
            - name: http
              containerPort: {{ .Values.container.port }}
              protocol: TCP
          {{- if .Values.env }}
          env:
            {{- range $key, $value := .Values.env }}
            - name: {{ $key }}
              value: {{ $value | quote }}
            {{- end }}
          {{- end }}
          {{- if .Values.configMap }}
          envFrom:
            - configMapRef:
                name: {{ include "tpm-library.fullname" . }}-configmap
          {{- end }}
          {{- if .Values.resources }}
          resources: 
            {{- toYaml .Values.resources | nindent 12 }}
          {{- end }}
          {{- if .Values.livenessProbe.enabled }}
          livenessProbe:
            httpGet:
              path: {{ .Values.livenessProbe.path }}
              port: {{ .Values.livenessProbe.port }}
            initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds }}
            periodSeconds: {{ .Values.livenessProbe.periodSeconds }}
            timeoutSeconds: {{ .Values.livenessProbe.timeoutSeconds }}
            successThreshold: {{ .Values.livenessProbe.successThreshold }}
            failureThreshold: {{ .Values.livenessProbe.failureThreshold }}
          {{- end }}
          {{- if .Values.readinessProbe.enabled }}
          readinessProbe:
            httpGet:
              path: {{ .Values.readinessProbe.path }}
              port: {{ .Values.readinessProbe.port }}
            initialDelaySeconds: {{ .Values.readinessProbe.initialDelaySeconds }}
            periodSeconds: {{ .Values.readinessProbe.periodSeconds }}
            timeoutSeconds: {{ .Values.readinessProbe.timeoutSeconds }}
            successThreshold: {{ .Values.readinessProbe.successThreshold }}
            failureThreshold: {{ .Values.readinessProbe.failureThreshold }}
          {{- end }}
{{- end -}}
{{- define "tpm-library.deployment" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.deployment.tpl") -}}
{{- end -}}