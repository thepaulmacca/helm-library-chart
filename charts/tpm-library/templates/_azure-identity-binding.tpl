{{/* 
Renders the Azure Identity Binding objects required by the chart 
*/}}
{{- define "tpm-library.azure-identity-binding.tpl" -}}
apiVersion: "aadpodidentity.k8s.io/v1"
kind: AzureIdentityBinding
metadata:
  name: {{ include "tpm-library.fullname" . }}-azure-identity-binding
spec:
  azureIdentity: {{ include "tpm-library.fullname" . }}-azure-identity
  selector: {{ include "tpm-library.fullname" . }}-azure-identity-selector
{{- end -}}
{{- define "tpm-library.azure-identity-binding" -}}
{{- include "tpm-library.util.merge" (append . "tpm-library.azure-identity-binding.tpl") -}}
{{- end -}}