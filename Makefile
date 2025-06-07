# Default target
help:
	@echo "Available commands:"
	@echo "  help         Show this help message"
	@echo "  install      Install dependencies"
	@echo "  run          Run development server"
	@echo "  test         Run tests"
	@echo "  tox          Run tests with tox"
	@echo "  lint         Run linting checks"
	@echo "  format       Format code"
	@echo "  migrate      Run database migrations"
	@echo "  makemigrations Create new migrations"
	@echo "  superuser    Create superuser (admin/admin)"
	@echo "  shell        Open Django shell"
	@echo "  collectstatic Collect static files"
	@echo "  clean        Clean cache and temporary files"

# Installation
install:
	uv pip install -e ".[testing,develoment]"

# Development server
run:
	uv run manage.py runserver 0:8000

# Testing
test:
	uv run manage.py test --verbosity=3

tox:
	tox --skip-missing-interpreters

# Code quality
lint:
	uv run ruff check

format:
	uv run ruff format --check

# Django management
migrate:
	uv run manage.py migrate

migrations:
	uv run manage.py makemigrations

superuser:
	@echo "Creating superuser (admin/admin)..."
	@echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='admin').exists() or User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | python manage.py shell
	@echo "Superuser created successfully!"

shell:
	uv run manage.py shell

collectstatic:
	python manage.py collectstatic --noinput

# Maintenance
clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf .tox/
	rm -rf .coverage
	rm -rf htmlcov/
