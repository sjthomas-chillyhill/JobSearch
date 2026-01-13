# AGENTS.md

Guidelines for agentic coding agents working in the JobSearch repository.

## Project Overview

Ruby on Rails 8.0.2 application for tracking job applications and businesses. Uses Hotwire, Bootstrap 5, SQLite3.

## Commands

### Testing
```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/application_test.rb

# Run single test method
rails test test/models/application_test.rb -n test_should_create_valid_application

# System tests (feature tests)
rails test:system
```

### Development
```bash
# Install dependencies
bundle install && yarn install

# Database
rails db:create db:migrate

# Development server
rails server

# Build CSS
yarn build:css

# Watch CSS changes
yarn watch:css
```

### Linting/Quality
```bash
# Ruby style (RuboCop)
bundle exec rubocop
bundle exec rubocop -a  # Auto-fix

# Security scan
bundle exec brakeman
```

## Code Style Guidelines

### Ruby/Rails
- Use `ApplicationRecord` base class
- Follow Rails naming conventions
- Place validations before associations
- Use `params.expect()` for strong parameters (Rails 8)
- Use enums for status fields with defaults

```ruby
class Application < ApplicationRecord
  validates :title, presence: true
  belongs_to :business
  enum :status, { Applied: 0, Interviewing: 1 }, default: :Applied
end

class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show edit update destroy ]
  
  def application_params
    params.expect(application: [:title, :business_id, :status])
  end
end
```

### Views/ERB
- Use Bootstrap 5 classes
- Include accessibility attributes
- Use Turbo frames for dynamic updates

```erb
<%= form_with(model: application, class: "needs-validation") do |form| %>
  <div class="mb-3">
    <%= form.label :title, class: "form-label" %>
    <%= form.text_field :title, class: "form-control" %>
  </div>
<% end %>
```

### JavaScript/Hotwire
- Use data-controller attributes
- Name controllers: `name_controller.js`
- Import maps structure:

```javascript
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
```

### CSS/SCSS
- Bootstrap 5 utility classes
- Custom SCSS variables
- Mobile-first responsive design

```scss
@import 'bootstrap/scss/bootstrap';
@import 'bootstrap-icons/font/bootstrap-icons';
```

## Database Conventions

### Migrations
- Use `change` method for reversible migrations
- Add foreign key constraints and indexes

```ruby
class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.string :title, null: false
      t.references :business, null: false, foreign_key: true
      t.enum :status, default: "Applied", null: false
      t.timestamps
    end
  end
end
```

## Error Handling

### Controllers
- Use proper HTTP status codes
- Handle ActiveRecord errors gracefully
- Provide user-friendly error messages

```ruby
def create
  @application = Application.new(application_params)
  if @application.save
    redirect_to @application, notice: "Created successfully"
  else
    flash.now[:alert] = "Failed to create"
    render :new, status: :unprocessable_entity
  end
end
```

## Security & Performance

- Use strong parameters (`params.expect()`)
- Run `bundle exec brakeman` for security scans
- Use `includes()` for eager loading associations
- Add database indexes for performance
- Use Solid Queue for background jobs

## Development Workflow

1. Run tests: `rails test`
2. Check style: `bundle exec rubocop`
3. Security scan: `bundle exec brakeman`
4. Use proper git commit messages

## Rails 8 Specific

- `params.expect()` instead of `params.require().permit()`
- Solid Queue/Cache/Cable
- Propshaft asset pipeline
- Thruster HTTP acceleration