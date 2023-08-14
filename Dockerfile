# syntax=docker/dockerfile:1
# ARG only take in build time
# ENV take value in build time and run time
ARG PYTHON_VERSION=3.11.3
FROM python:${PYTHON_VERSION}-slim-bullseye as base


# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

ENV PIP_DISABLE_PIP_VERSION_CHECK=1


# install dependencies  
RUN pip install --upgrade pip  


# Change to new working directory
WORKDIR /app

# Install all the requirements
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=app/requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

# Copy the executable from the "build" stage.
COPY  ./app .

# port where the Django app runs  
EXPOSE 8000 


# Set sqlite or postgres
ENV POSTGRES=${POSTGRES}

# # What the container should run when it is started.
ENTRYPOINT [ "./docker-entrypoint.sh" ]

# start server  
CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]

# Create a non-privileged user that the app will run under.
# ARG UID=10001
# RUN adduser \
#     --disabled-password \
#     --gecos "" \
#     --home "/nonexistent" \
#     --shell "/sbin/nologin" \
#     --no-create-home \
#     --uid "${UID}" \
#     appuser
# USER appuser


