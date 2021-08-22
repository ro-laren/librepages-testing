define add_cowsay
	@sed "/<\/main>/e cat components/cowsay.html" index.html > dist/index.html
endef

define copy_styles
	@cp -r css/ dist/
endef

define prod_build 
	@sed -i "/name=\"viewport\" content=\"width=device-width\"/e cat csp.html" dist/index.html
endef

default: clean
	@$(call add_cowsay)
	@$(copy_styles)
	@echo "Development artifacts are available in dist/" 

prod: clean
	@$(call copy_styles)
	@$(call add_cowsay)
	@$(call prod_build)
	@echo "Production artifacts are available in dist/" 


clean:
	@-rm -rf dist
	@mkdir dist
	@touch dist/index.html

help:
	@echo ' default             - prepare for development build'
	@echo ' prod                - prepare for production deployment'
	@echo ' clean               - clean artifacts'
	@echo ' help                - print this help menu'
