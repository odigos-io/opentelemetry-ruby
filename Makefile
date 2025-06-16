RUBY_VERSIONS=3.1 3.2 3.3 3.4
ARCHES=arm64 amd64
DOCKER_MOUNT_NAME=otel-ruby

##################################################
# Main method to build the gems & binaries
##################################################

.PHONY: all
all:
	@$(MAKE) prepare-multiarch
	@$(MAKE) bake-images
	@for vers in $(RUBY_VERSIONS); do \
		for arch in $(ARCHES); do \
			echo "\n🚀 Handling gems for Ruby $$vers on $$arch"; \
			($(MAKE) unmount-container/$$vers-$$arch || true); \
			$(MAKE) mount-container/$$vers-$$arch; \
			$(MAKE) copy-files/$$vers-$$arch; \
			$(MAKE) unmount-container/$$vers-$$arch; \
		done; \
	done
	@$(MAKE) cleanup
	@echo "\n✅ All gems have been built and copied to the respective directories."

prepare-multiarch:
	@echo "\n🚀 Bootstraping buildx with QEMU support"
	@docker buildx create --name multiarch --driver docker-container --use || true
	@docker buildx inspect --bootstrap

bake-images:
	@echo "\n🚀 Building images"
	@mkdir -p tmp
	@docker buildx bake --file docker-bake.hcl

mount-container/%:
	@echo "🧪 Mounting container"
	@{ \
		VERS=$$(echo "$*" | cut -d '-' -f 1); \
		ARCH=$$(echo "$*" | cut -d '-' -f 2); \
		docker load -i tmp/${DOCKER_MOUNT_NAME}-$*.tar; \
		docker create --platform=linux/$${ARCH} --name ${DOCKER_MOUNT_NAME}-$* ${DOCKER_MOUNT_NAME}:$*; \
	}

unmount-container/%:
	@echo "🧪 Unmounting container"
	@docker rm ${DOCKER_MOUNT_NAME}-$*

copy-files/%:
	@echo "🧪 Copying files"
	@{ \
		VERS=$$(echo "$*" | cut -d '-' -f 1); \
		ARCH=$$(echo "$*" | cut -d '-' -f 2); \
		rm -rf ./$${VERS}/$${ARCH}; \
		mkdir -p ./$${VERS}/$${ARCH}; \
		docker cp ${DOCKER_MOUNT_NAME}-$*:/Gemfile.lock ./$${VERS}/$${ARCH}/Gemfile.lock; \
		docker cp ${DOCKER_MOUNT_NAME}-$*:/usr/local/bundle ./$${VERS}/$${ARCH}/bundle; \
	}

cleanup:
	@echo "\n🚀 Cleaning up leftovers"
	@rm -rf tmp
	@docker buildx use default || docker context use default
	@docker buildx rm multiarch
