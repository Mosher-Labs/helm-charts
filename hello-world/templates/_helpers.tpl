{{- define "hello-world.labels" -}}
{
  "app.kubernetes.io/name": "{{ include "hello-world.name" . }}",
  "helm.sh/chart": "{{ include "hello-world.chart" . }}",
  "app.kubernetes.io/instance": "{{ .Release.Name }}",
  "app.kubernetes.io/managed-by": "{{ .Release.Service }}"
}
{{- end -}}

{{- define "hello-world.selectorLabels" -}}
{
  "app.kubernetes.io/name": "{{ include "hello-world.name" . }}",
  "app.kubernetes.io/instance": "{{ .Release.Name }}"
}
{{- end -}}

{{- define "hello-world.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- if .Values.serviceAccount.name -}}
{{ .Values.serviceAccount.name }}
{{- else -}}
{{ include "hello-world.fullname" . }}
{{- end -}}
{{- else -}}
"default"
{{- end -}}
{{- end -}}

{{- define "hello-world.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "hello-world.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "hello-world.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hello-world.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version -}}
{{- end -}}
