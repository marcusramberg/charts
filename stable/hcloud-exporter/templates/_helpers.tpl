{{/*
Expand the name of the chart.
*/}}
{{- define "hcloud-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hcloud-exporter.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hcloud-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create basic labels
*/}}
{{- define "hcloud-exporter.labels" -}}
helm.sh/chart: {{ include "hcloud-exporter.chart" . }}
app.kubernetes.io/name: {{ include "hcloud-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "hcloud-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "hcloud-exporter.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "hcloud-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hcloud-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
