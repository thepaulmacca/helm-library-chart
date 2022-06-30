{{/* 
Renders the Azure Identity objects required by the chart 
*/}}
{{- define "tpm-library.azure-identity.tpl" -}}
apiVersion: "aadpodidentity.k8s.io/v1"
kind: AzureIdentity
metadata:
  name: {{ include "tpm-library.fullname" . }}-azure-identity
spec:
  type: 0
  resourceID: {{ .Values.azureIdentity.resourceID }}
  clientID: {{ .Values.azureIdentity.clientID }}
{{- end -}}
{{- define "tpm-library.azure-identity" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.azure-identity.tpl") -}}
{{- end -}}