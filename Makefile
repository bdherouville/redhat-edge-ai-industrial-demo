# Define variables
IMAGE_NAME := nut:latest
DOCKERFILE_PATH := ./Dockerfile
CONTEXT_PATH := container
CONTAINER_NAME := nut-instance

.PHONY: build-image run-image clean

build-image:
	@echo "Building the image using Buildah..."
	buildah bud -t $(IMAGE_NAME) -f $(DOCKERFILE_PATH) $(CONTEXT_PATH)

run-image:
	@echo "Running the image using Podman..."
	podman run -d --name $(CONTAINER_NAME) -p 5000:5000 $(IMAGE_NAME)

clean:
	@echo "Cleaning up..."
	podman stop $(CONTAINER_NAME)
	podman rm $(CONTAINER_NAME)
	buildah rmi $(IMAGE_NAME)

# Optionally, you can add a target for pushing the image to a container registry here
