# ------------------------------------------------------------------------------
# Simple helper targets for a Gradle + Docker Spring-Boot project
# ------------------------------------------------------------------------------

GRADLEW     ?= ./gradlew
DOCKER_COMPOSE ?= docker compose
DEFAULT_PORT ?= 8080

.DEFAULT_GOAL := test

# -----------------------------------------------------------------------------#
# Quality / tests                                                              #
# -----------------------------------------------------------------------------#

.PHONY: test
test:              ## Clean, build, run unit tests + coverage verification
	$(GRADLEW) --no-daemon clean check

.PHONY: coverage
coverage: test     ## Generate the JaCoCo HTML report (open after build)
	$(GRADLEW) --no-daemon jacocoTestReport
	@echo "Coverage HTML: build/reports/jacoco/test/html/index.html"

.PHONY: lint
lint:              ## Fail the build if any file is not correctly formatted
	$(GRADLEW) --no-daemon spotlessCheck

.PHONY: format
format:            ## Re-format source files in-place to satisfy Spotless
	$(GRADLEW) --no-daemon spotlessApply

.PHONY: ci
ci: lint coverage  ## One-shot target you can call from CI if you like

# -----------------------------------------------------------------------------#
# Local runtime convenience                                                    #
# -----------------------------------------------------------------------------#

.PHONY: run
run:               ## Run the app locally on $(DEFAULT_PORT)
	SPRING_PROFILES_ACTIVE=local $(GRADLEW) --no-daemon bootRun

.PHONY: docker-up
docker-up:         ## Build the image and start the container in the background
	$(DOCKER_COMPOSE) up --build -d

.PHONY: docker-down
docker-down:       ## Stop and remove containers
	$(DOCKER_COMPOSE) down

.PHONY: clean
clean:             ## Gradle clean + docker prune
	$(GRADLEW) --no-daemon clean
	-$(DOCKER_COMPOSE) down -v --remove-orphans

# -----------------------------------------------------------------------------#
# Help (make help)                                                             #
# -----------------------------------------------------------------------------#

.PHONY: help
help:              ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
