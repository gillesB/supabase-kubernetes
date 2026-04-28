{{/*
Expand the name of the chart.
*/}}
{{- define "supabase.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "supabase.fullname" -}}
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
{{- define "supabase.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "supabase.labels" -}}
helm.sh/chart: {{ include "supabase.chart" . }}
{{ include "supabase.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supabase.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supabase.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supabase.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "supabase.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Get the database host for CNPG cluster
Returns the CNPG read-write service name: {release-name}-db-rw
*/}}
{{- define "supabase.db.cnpgHost" -}}
{{- if .Values.db.enabled -}}
  {{- if .Values.db.cluster.nameOverride -}}
    {{- printf "%s-rw" .Values.db.cluster.nameOverride -}}
  {{- else -}}
    {{- printf "%s-db-rw" .Release.Name -}}
  {{- end -}}
{{- else -}}
  {{- required "DB_HOST must be specified in service environment when db.enabled=false" .Values.auth.environment.DB_HOST -}}
{{- end -}}
{{- end }}

{{/*
Get the database host for a legacy (normal Deployment) postgres instance
Returns the standard Kubernetes service name: {release-name}-db
*/}}
{{- define "supabase.db.legacyHost" -}}
{{- if .Values.db.enabled -}}
  {{- if .Values.db.cluster.nameOverride -}}
    {{- .Values.db.cluster.nameOverride -}}
  {{- else -}}
    {{- printf "%s-db" .Release.Name -}}
  {{- end -}}
{{- else -}}
  {{- required "DB_HOST must be specified in service environment when db.enabled=false" .Values.auth.environment.DB_HOST -}}
{{- end -}}
{{- end }}

{{/*
Get the database host — delegates to legacyHost when db.enableLegacy=true, cnpgHost otherwise
*/}}
{{- define "supabase.db.host" -}}
{{- if .Values.db.enableLegacy -}}
  {{- include "supabase.db.legacyHost" . -}}
{{- else -}}
  {{- include "supabase.db.cnpgHost" . -}}
{{- end -}}
{{- end }}

{{/*
Reusable migration initContainer that waits for PostgreSQL to accept connections.
*/}}
{{- define "supabase.db.waitForDbInitContainer" -}}
- name: wait-for-db
  image: {{ .Values.db.waitHook.image | default "postgres:15-alpine" }}
  imagePullPolicy: IfNotPresent
  command: ["/bin/sh", "-c"]
  args:
    - |
      until pg_isready -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE"; do
        echo "Waiting for database..."
        sleep 5
      done
      echo "Database is ready!"
  env:
    - name: PGHOST
      value: {{ include "supabase.db.host" . }}
    - name: PGPORT
      value: "5432"
    - name: PGUSER
      valueFrom:
        secretKeyRef:
          name: {{ include "supabase.secret.db" . }}
          key: {{ .Values.secret.db.secretRefKey.username | default "username" }}
    - name: PGPASSWORD
      valueFrom:
        secretKeyRef:
          name: {{ include "supabase.secret.db" . }}
          key: {{ .Values.secret.db.secretRefKey.password | default "password" }}
    - name: PGDATABASE
      valueFrom:
        secretKeyRef:
          name: {{ include "supabase.secret.db" . }}
          key: {{ .Values.secret.db.secretRefKey.database | default "database" }}
{{- end }}

{{/*
CNPG cluster name
*/}}
{{- define "supabase.db.clusterName" -}}
{{- if .Values.db.cluster.nameOverride }}
{{- .Values.db.cluster.nameOverride }}
{{- else }}
{{- printf "%s-db" .Release.Name }}
{{- end }}
{{- end }}

{{/*
Database component name (for log filtering)
*/}}
{{- define "supabase.db.name" -}}
{{- printf "%s-db" .Chart.Name }}
{{- end }}

{{/*
CNPG initdb SQL secret name
*/}}
{{- define "supabase.initdb.secret" -}}
{{- printf "%s-initdb-sql" .Release.Name }}
{{- end }}

{{/*
CNPG initdb scripts ConfigMap name
*/}}
{{- define "supabase.initdb.configmap" -}}
{{- printf "%s-initdb-scripts" .Release.Name }}
{{- end }}

{{/*
Supabase roles secret name
*/}}
{{- define "supabase.secret.roles" -}}
{{- printf "%s-roles" .Release.Name }}
{{- end }}

{{/*
CNPG backup secret name
*/}}
{{- define "supabase.cnpg.backupSecret" -}}
{{- if .Values.db.backup.s3.existingSecret }}
{{- .Values.db.backup.s3.existingSecret }}
{{- else }}
{{- printf "%s-backup-s3" .Release.Name }}
{{- end }}
{{- end }}

{{/*
CNPG plugin ObjectStore name
*/}}
{{- define "supabase.cnpg.objectStore" -}}
{{- printf "%s-db-object-store" .Release.Name }}
{{- end }}
