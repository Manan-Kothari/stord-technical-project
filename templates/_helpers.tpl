{{/*
Expand the name of the chart.
*/}}
{{- define "sre-technical-challenge.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "sre-technical-challenge.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sre-technical-challenge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sre-technical-challenge.labels" -}}
helm.sh/chart: {{ include "sre-technical-challenge.chart" . }}
{{ include "sre-technical-challenge.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sre-technical-challenge.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sre-technical-challenge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Migration job labels
*/}}
{{- define "sre-technical-challenge.migrationLabels" -}}
helm.sh/chart: {{ include "sre-technical-challenge.chart" . }}
{{ include "sre-technical-challenge.migrationSelectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Migration selector labels
*/}}
{{- define "sre-technical-challenge.migrationSelectorLabels" -}}
app.kubernetes.io/name: {{ include "sre-technical-challenge.name" . }}-migration
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

