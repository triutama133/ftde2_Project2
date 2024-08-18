# Use the official PostgreSQL image from the Docker Hub
FROM postgres:12

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=1234
ENV POSTGRES_DB=postgres

# Expose the default PostgreSQL port
EXPOSE 5432

# Optional: Add custom configuration or scripts here