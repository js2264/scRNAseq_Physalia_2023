RCMD := Rscript -e

.PHONY: render
render: ## Render book
	@echo "📖 Rendering book"
	quarto render --to html

.PHONY: serve
serve: ## serve local static site
	$(RCMD) 'servr::httd("docs", port = 4444)'

.PHONY: render-serve
render-serve: ## Test rendering locally
	@echo "📖 Rendering book locally"
	quarto render --to html
	$(RCMD) 'servr::httd("docs", port = 4444)'

.PHONY: git
git: ## Automated commit and pushing to github rpeo
	@echo "📨 Pushing to GH"
	git add .
	git commit -m "make git"
	git push

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
