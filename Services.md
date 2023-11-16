# Services

## Frontend - NextJs
The frontend service runs a React web application.

### Image
The frontend service builds an image from the `../frontend` directory.

### Dependencies
The frontend service depends on the `backend` service.

### Environment Variables
The frontend service uses environment variables from the `../frontend/.env` file.

### Ports
The frontend service exposes port `${FRONTEND_PORT}`.

### Restart Policy
The frontend service restarts unless stopped.

### Volumes
The frontend service mounts the `./app` directory as a volume.


## Backend - Based on Strapi
The backend service runs a Node.js server.

### Image
The backend service builds an image from the `../backend` directory.

### Dependencies
The backend service depends on the `db` service.

### Environment Variables
The backend service uses environment variables from the `../backend/app/.env` file.

### Ports
The backend service exposes port `${BACKEND_PORT}`.

### Restart Policy
The backend service restarts on failure.

### Volumes
The backend service mounts the `./app` directory as a volume.


## DB - PostgreSQL
The db service runs a PostgreSQL database.

### Image
The db service uses the `postgres` image.

### Ports
The db service exposes port `${DATABASE_PORT}`.

### Environment Variables
The db service uses environment variables from the `../backend/app/.env` file.

### Restart Policy
The db service restarts unless stopped.

### Volumes
The db service mounts the `./data` directory as a volume.
