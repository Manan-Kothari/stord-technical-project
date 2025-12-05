# SRE Technical Challenge Helm Chart

A Helm chart for deploying the SRE Technical Challenge Elixir Phoenix application.

Note, in an actual production env I wouldn't use helm hooks but either an init container or use a job with something
like argoCD and sync waves to run the job first and make sure the secret is there (using a tool like liquibase/flyway
for the actual migration part)


## Installation

### Setup

These are the commands that will be run to install the postgres database and your Helm chart:

```bash
NAMESPACE=stord

# Install PostgreSQL database
helm install sre-db oci://registry-1.docker.io/bitnamicharts/postgresql \
  --create-namespace \
  --namespace $NAMESPACE \
  --set auth.database=sre-technical-challenge \
  --set auth.postgresPassword=password

# Install the application
helm install sre-app . \
  --debug \
  --namespace $NAMESPACE \
  --values values.yaml
```

## Configuration

### Environment Variables

Environment variables are defined in the `env` template string. Required variables include:

- `DATABASE_URL`: PostgreSQL connection string
- `POOL_SIZE`: Database connection pool size (default: `10`)
- `PORT`: HTTP server port (default: `4000`)
- `PHX_HOST`: Domain name for the service
- `SECRET_KEY_BASE`: References the Kubernetes Secret

Additional environment variables can be added under `env` in values.yaml

## Validation

After installation, you can validate the deployment:

### Database Validation

```bash
# Port forward to database
kubectl port-forward svc/sre-db-postgresql 55432:5432

# Connect to database
psql postgresql://postgres:password@127.0.0.1:55432/sre-technical-challenge
```

### Application Validation

```bash
# Port forward to application (port 80)
kubectl port-forward svc/sre-app-sre-technical-challenge 8080:80

# Or port forward to port 4000
kubectl port-forward svc/sre-app-sre-technical-challenge 8080:4000

# Access the application
curl http://localhost:8080/todos
curl http://localhost:8080/_health
```