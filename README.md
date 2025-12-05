# SRE Technical Challenge Helm Chart

A Helm chart for deploying the SRE Technical Challenge Elixir Phoenix application.

Note, in an actual production env I wouldn't use helm hooks but either an init container or use a job with something like argoCD and sync waves to run the job first and make sure the secret is there (using a tool like liquibase/flyway for the actual migration part)